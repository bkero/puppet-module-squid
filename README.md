puppet-module-squid
===================

Mozilla IT's Squid module
This is the Squid puppet module used by Mozilla's IT team.

Example usage:
node 'squid1.example.com' {
    class { 'squid':
        acls => {
            '00000000-Localhost' => {
                'description' => 'Allows allow localhost',
                'source_ips   => ['127.0.0.1, '::1'],
                'dest_ips'    => ['all'],
            },
            'myacl1' => {
                'description' => 'My first ACL rule',
                'source_ips'  => [
                                '10.0.2.0/24',
                                '10.0.3.0/24',
                                '10.0.4.0/24',
                                 ],
               'dest_ips'    => ['10.0.1.0/24',],
            },
        }
    }
}

Example wpad usage:
node 'squid1.example.com': {
    class { 'squid::wpad':
        server_alises => ['wpad.squid1.example.com'];
    }
}
