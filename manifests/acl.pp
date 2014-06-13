# create specific source-destination ACL files
#
define squid::acl (
    $source_ips = [],
    $dest_names = [],
    $dest_ips = [],
    $description = '',  # unused here
    $squid = "squid",
) {

    file {
        "/etc/${squid}/acls/${name}":
            ensure  => directory,
            require => File["/etc/${squid}/acls"],
            notify  => Service[$squid];

        "/etc/${squid}/acls/${name}/source_ips.txt":
            ensure  => present,
            content => template("squid/source_ips.txt.erb"),
            require => File["/etc/${squid}/acls/${name}"],
            notify  => Service[$squid];

        "/etc/${squid}/acls/${name}/dest_ips.txt":
            ensure  => present,
            content => template("squid/dest_ips.txt.erb"),
            require => File["/etc/${squid}/acls/${name}"],
            notify  => Service[$squid];

        "/etc/${squid}/acls/${name}/dest_names.txt":
            ensure  => present,
            content => template("squid/dest_names.txt.erb"),
            require => File["/etc/${squid}/acls/${name}"],
            notify  => Service[$squid];
    }
}
