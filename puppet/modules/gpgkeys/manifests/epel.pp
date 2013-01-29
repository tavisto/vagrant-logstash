# Install EPEL GPG keys based on our OS
class gpgkeys::epel {

    case $operatingsystem { 
        'CentOS', 'Scientific': {
            case $operatingsystemrelease {
    
                # EL5
                /^5.*/: {
                    file {
                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-EPEL';
                    }
                } 
    
                # EL6
                /^6.*/: {
                    file {
                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-EPEL-6';
                    }
                } 
            }
        }
    }
}