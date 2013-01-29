define repo::remi($enabled) {

    if $enabled == true {
    
        # Install the repo based on our EL version
        case $operatingsystem { 
            'CentOS', 'Scientific': {
                case $operatingsystemrelease {

                    # EL6
                    /^6.*/: {
                        file {
                            "/etc/yum.repos.d/remi.repo":
                                mode    => 0644,
                                owner   => 'root',
                                group   => 'root',
                                source  => 'puppet:///modules/repo/remi-EL6-x86_64.repo';
                        }
                    } 
                }
            }
        }
    }
}