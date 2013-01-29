define repo::spacewalk_server($enabled) {

    if $enabled == true {
    
        # Install the repo based on our EL version
        case $operatingsystem { 
            'CentOS', 'Scientific': {
                case $operatingsystemrelease {
                    # EL6
                    /^5.*/: {
                        file {
                            "/etc/yum.repos.d/spacewalk-server.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-server-EL5-x86_64.repo';
                        }
                    } 
                    # EL6
                    /^6.*/: {
                        file {
                            "/etc/yum.repos.d/spacewalk-server.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-server-EL6-x86_64.repo';
                        }
                    } 
                }
            }
            'Fedora': {
                case $operatingsystemrelease {
                    /^16.*/: {
                        file {
                            "/etc/yum.repos.d/spacewalk-server.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-server-f16-x86_64.repo';
                        }
                    }
                }
            }
        }
    }
}