
#
# Makefile for targets in the Global Frequency broadcast / syndication stack
#

setup-dirs:
	cat required_dirs.txt | xargs mkdir -p


install-reqs:
	#
	# core libraries and CLI utils 
	#
	cat required_system_installs.txt | xargs sudo apt install -y 
	#
	# ngrok (for testing from a private network)
	#
	curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install -y ngrok


gen-icecast-config:
	warp --py --template-file=templates/icecast_config.xml.tpl \
	--params=mountname:$$MOUNTNAME,src_client_user:$$STREAM_USER,src_client_pw:$$STREAM_PW,max_listeners:0 \
	> config/broadcast_config.xml


gen-ices-config:
	cat tempdata/ices_params.json | warp --py --template-file=templates/base_autoplay.xml.tpl -s \
	> config/base_autoplay.xml
	

icecast-test:
	rsas -t -c config/broadcast_config.xml


icecast-up:
	rsas --icecast-config config/broadcast_config.xml


ices-up:
	ices2 config/base_autoplay.xml


ices-down:
	ps ax | grep ices | awk '{ print $$1 }' | xargs kill


pipeline-convert-mp3:

	ls inputs/*.mp3 > tempdata/mp3_file_list.txt

	cat tempdata/mp3_file_list.txt | tuple2json --delimiter '.mp3' --keys=basename \
	> tempdata/mp3_basenames.jsonl

	cp templates/shell_script_core.sh.tpl temp_scripts/convert_mp3_to_ogg.sh

	loopr -p -j --listfile tempdata/mp3_basenames.jsonl \
	--cmd-string 'mpg321 {basename}.mp3 -w raw && oggenc raw -o {basename}.ogg' \
	>> temp_scripts/convert_mp3_to_ogg.sh


	chmod u+x temp_scripts/convert_mp3_to_ogg.sh
	./temp_scripts/convert_mp3_to_ogg.sh

	mv inputs/*.ogg media/


# execute this target to spin up a playlist based on our existing (sample)
# media files.
# File format is ogg-vorbis; MP3 files must be transcoded before adding to the rotation.
#
pipeline-update-playlist:
	ls media/*.ogg > tempdata/base_playlist.txt


	


