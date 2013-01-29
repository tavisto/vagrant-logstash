# Install remi GPG key
class gpgkeys::rpmforge {

    case $operatingsystem { 
    'CentOS', 'Scientific': {
      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmforge-dag';
      }

      file {
          "/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian":
              mode    => 0644,
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/gpgkeys/RPM-GPG-KEY-rpmforge-fabian';
      }
    } 
  }
}