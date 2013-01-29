# Install tavisto GPG key
class gpgkeys::tavisto {

  case $::operatingsystem {
    'CentOS', 'Scientific': {
      file {
          '/etc/pki/rpm-gpg/RPM-GPG-KEY-TAVISTO':
              mode    => '0644',
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-TAVISTO';
      }
    }
  }
}