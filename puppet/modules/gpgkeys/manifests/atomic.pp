# Install  Atomic GPG keys 
class gpgkeys::atomic {

    case $operatingsystem { 
    'CentOS', 'Scientific', 'Fedora': {
      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-atomic":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-atomic';
      }
    } 
  }
}