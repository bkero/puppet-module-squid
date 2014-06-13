class squid::client (
    $http_proxy_server = hiera('http_proxy_server'),
    $https_proxy_server = hiera('https_proxy_server'),
    $http_proxy_port = hiera('http_proxy_port', '3128'),
    $https_proxy_port = hiera('https_proxy_port', '3128'),
    $no_proxy = hiera('no_proxy', 'localhost,127.0.0.1,.localdomain,10.0.0.0/8,.dc1.example.com,.dc2.example.com'),
) {

    file {
        '/etc/profile.d/proxy.sh':
            ensure  => present,
            mode    => '0644',
            user    => 'root',
            group   => 'root',
            content => template('modules/squid/proxy.sh.erb');
    }
}
