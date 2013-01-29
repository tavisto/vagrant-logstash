define repo::spacewalk_tools($enabled) {

    if $enabled == true {
    
        # Install the repo based on our EL version
        case $operatingsystem { 
            'CentOS', 'Scientific': {
                case $operatingsystemrelease {

                    # EL5
                    /^5.*/: {
                        file {
                            "/etc/yum.repos.d/spacewalk-tools.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-tools-EL5-x86_64.repo';
                        }
                    } 

                    # EL6
                    /^6.*/: {
                        file {
                            "/etc/yum.repos.d/spacewalk-tools.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-tools-EL6-x86_64.repo';
                        }
                    } 
                }
            }
            'Fedora': {
                case $operatingsystemrelease {
                    /^16/: {
                        file {
                            "/etc/yum.repos.d/spacewalk_tools.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/spacewalk-tools-f16-x86_64.repo';
                        }
                    }
                }
            }
        }
    }
}