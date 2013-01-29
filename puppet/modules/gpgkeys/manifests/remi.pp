# Install remi GPG key
class gpgkeys::remi {

    case $operatingsystem { 
    'CentOS', 'Scientific': {
      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-remi":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-remi';
      }
    } 
  }
}