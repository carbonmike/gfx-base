<?xml version="1.0"?>
<ices>
    <!-- run in background -->
    <background>1</background>
    <!-- where logs, etc go. -->
    <logpath>logs</logpath>
    <logfile>ices.log</logfile>
    <!-- 1=error,2=warn,3=info,4=debug -->
    <loglevel>4</loglevel>
    <!-- set this to 1 to log to the console instead of to the file above -->
    <consolelog>1</consolelog>

    <!-- optional filename to write process id to -->
    <!-- <pidfile>/home/ices/ices.pid</pidfile> -->

    <stream>
        <!-- metadata used for stream listing (not currently used) -->
        <metadata>
            <name>My Syndication Service</name>
            <genre>content_genre</genre>
            <description>A short description of your stream</description>
        </metadata>

        <!-- input module

            The module used here is the playlist module - it has 
            'submodules' for different types of playlist. There are
            two currently implemented, 'basic', which is a simple
            file-based playlist, and 'script' which invokes a command
            to returns a filename to start playing. -->

        <input>
            <module>playlist</module>
            <param name="type">basic</param>
            <param name="file">{playlist_file}</param>
            <!-- random play -->
            <param name="random">0</param>
            <!-- if the playlist get updated that start at the beginning -->
            <param name="restart-after-reread">0</param>
            <!-- if set to 1 , plays once through, then exits. -->
            <param name="once">0</param>
        </input>

		<!-- Stream instance
            You may have one or more instances here. This allows you to 
            send the same input data to one or more servers (or to different
            mountpoints on the same server). Each of them can have different
            parameters. This is primarily useful for a) relaying to multiple
            independent servers, and b) encoding/reencoding to multiple
            bitrates.
            If one instance fails (for example, the associated server goes
            down, etc), the others will continue to function correctly.
            This example defines two instances as two mountpoints on the
            same server.  -->
        <instance>
            <!-- Server details:
                You define hostname and port for the server here, along with
                the source password and mountpoint.  -->
            <hostname>{stream_server_ip}</hostname>
            <port>{stream_server_port}</port>
            <username>{stream_server_user}</username>
            <password>{stream_server_pw}</password>
            <mount>{mountpoint}</mount>

            <!-- Reconnect parameters:
                When something goes wrong (e.g. the server crashes, or the
                network drops) and ices disconnects from the server, these
                control how often it tries to reconnect, and how many times
                it tries to reconnect. Delay is in seconds.
                If you set reconnectattempts to -1, it will continue 
                indefinately. Suggest setting reconnectdelay to a large value
                if you do this.
            -->
            <reconnectdelay>2</reconnectdelay>
            <reconnectattempts>5</reconnectattempts> 

            <!-- maxqueuelength:
                This describes how long the internal data queues may be. This
                basically lets you control how much data gets buffered before
                ices decides it can't send to the server fast enough, and 
                either shuts down or flushes the queue (dropping the data)
                and continues. 
                For advanced users only.
            -->
            <maxqueuelength>80</maxqueuelength>

            <!-- Live encoding/reencoding:
                Currrently, the parameters given here for encoding MUST
                match the input data for channels and sample rate. That 
                restriction will be relaxed in the future.
                Remove this section if you don't want your files getting reencoded.
            -->
	    <!--
            <encode>  
                <nominal-bitrate>64000</nominal-bitrate>
                <samplerate>44100</samplerate>
                <channels>2</channels>
            </encode>
	    -->
        </instance>

	</stream>
</ices>