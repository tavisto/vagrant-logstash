# Install  puppet GPG keys based on our OS
class gpgkeys::puppet {

    case $operatingsystem { 
    'CentOS', 'Scientific', 'Fedora': {
      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-puppetlabs';
      }
    } 
  }
}