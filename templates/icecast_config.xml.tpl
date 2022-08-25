<icecast>
    <listen-socket>
        <port>8000</port>
        <bind-address>0.0.0.0</bind-address> <!-- Listen on all interfaces -->
    </listen-socket>

    <mount>
        <mount-name>/{mountname}</mount-name>
        <username>{src_client_user}</username>
        <password>{src_client_pw}</password>
        <max-listeners>{max_listeners}</max-listeners>
    </mount>
</icecast>
