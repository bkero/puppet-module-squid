class squid::wpad (
    $server_aliases = [],
){
    require apache::standardconfig

    file {
        '/var/www/html/wpad':
            ensure => directory;

        '/etc/httpd/conf.d/wpad.conf':
            ensure  => present,
            notify  => Service['httpd'],
            content => template('squid/wpad.conf.erb');

        '/var/www/html/wpad/wpad.dat':
            content => template('squid/wpad.dat.erb');

        '/var/www/html/wpad/proxy.pac':
            ensure => link,
            target => '/var/www/html/wpad/wpad.dat';
    }
}
