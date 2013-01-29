define repo::tavisto() {
  # Install the repo based on our EL version
  case $::operatingsystem {
    'CentOS', 'Scientific': {
      case $::operatingsystemrelease {
        # EL6
        /^6.*/: {
          file {
            '/etc/yum.repos.d/tavisto.repo':
              mode    => '0644',
              owner   => 'root',
              group   => 'root',
              source  => 'puppet:///modules/repo/tavisto-EL6-x86_64.repo';
          }
        }
        default: { }
      }
    }
    default: { }
  }
}