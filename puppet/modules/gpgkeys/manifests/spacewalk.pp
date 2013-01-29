# Install  spacewalk GPG keys based on our OS
class gpgkeys::spacewalk {

    case $operatingsystem { 
    'CentOS', 'Scientific', 'Fedora': {
      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-spacewalk":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-spacewalk';
      }
    } 
  }
}