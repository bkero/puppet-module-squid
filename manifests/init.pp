class squid (
    $safe_ports = [],
    $global_allow_domains = [],
    $global_deny_domains = [],
    $global_allow_subnets = [],
    $global_deny_subnets = [],
    $acls = {},
){

    realize(Nrpe::Plugin["squid", "proxy"])

    $squid = $::operatingsystem ? {
        "Ubuntu" => "squid3",
        "Debian" => "squid3",
        default  => "squid",
    }

    package {
        $squid:
            ensure => latest;
    }

    file {
        "/etc/${squid}/squid.conf":
            ensure  => present,
            content => template("squid/squid.conf.erb"),
            require => Package[$squid],
            notify  => Service[$squid];

        "/etc/${squid}/global_allow_domains.txt":
            ensure  => present,
            content => template("squid/global_allow_domains.txt.erb"),
            require => Package[$squid],
            notify  => Service[$squid];

        "/etc/${squid}/global_allow_subnets.txt":
            ensure  => present,
            content => template("squid/global_allow_subnets.txt.erb"),
            require => Package[$squid],
            notify  => Service[$squid];

        "/etc/${squid}/global_deny_domains.txt":
            ensure  => present,
            content => template("squid/global_deny_domains.txt.erb"),
            require => Package[$squid],
            notify  => Service[$squid];

        "/etc/${squid}/global_deny_subnets.txt":
            ensure  => present,
            content => template("squid/global_deny_subnets.txt.erb"),
            require => Package[$squid],
            notify  => Service[$squid];

        "/etc/${squid}/acls":
            ensure  => directory,
            require => Package[$squid],
            purge   => true,  # We made this directory, delete anything not managed by us
            recurse => true,  # For recursive cleaning
            force   => true,  # To ensure deletion of unmanaged folders too
            notify  => Service[$squid];
    }

    service {
        $squid:
            ensure     => running,
            enable     => true,
            hasrestart => true,
            restart    => "/etc/init.d/${squid} reload",
            require    => File["/etc/${squid}/squid.conf"];
    }

    # Create files for specific source-dest acls

    $acl_defaults = {
        'source_ips'  => [],
        'dest_ips'    => [],
        'dest_names'  => [],
        'description' => '',
        'squid'       => $squid,
    }
    create_resources(squid::acl, $acls, $acl_defaults)
}
