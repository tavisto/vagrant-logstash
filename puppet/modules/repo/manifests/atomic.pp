define repo::atomic($enabled) {

    if $enabled == true {
    
        # Install the repo based on our EL version
        case $operatingsystem { 
            'CentOS', 'Scientific': {
                case $operatingsystemrelease {

                    # EL5
                    /^5.*/: {
                        file {
                            "/etc/yum.repos.d/atomic.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/atomic-EL5-x86_64.repo';
                        }
                    } 

                    # EL6
                    /^6.*/: {
                        file {
                            "/etc/yum.repos.d/atomic.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/atomic-EL6-x86_64.repo';
                        }
                    } 
                }
            }
        }
    }
}