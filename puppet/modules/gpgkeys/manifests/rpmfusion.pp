# Install rpmfusion GPG keys based on our OS
class gpgkeys::rpmfusion {

    case $operatingsystem { 
        'CentOS', 'Scientific': {
            case $operatingsystemrelease {
    
                # EL5
                /^5.*/: {
                    file {
                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmfusion-free-el';

                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmfusion-nonfree-el';
                    }
                } 
    
                # EL5
                /^5.*/: {
                    file {
                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-el-6":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmfusion-free-el-6';

                        "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-el-6":
                            mode    => 0644,
                            owner   => 'root',
                            group   => 'root',
                            source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmfusion-nonfree-el-6';
                    }
                } 
            }
        }
    }
}