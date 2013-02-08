node web {
  include gpgkeys::tavisto
  repo::tavisto {'tavisto':}

  class { 'kibana':
    status      => enabled,
    standalone  => true,
    config_file => '/vagrant/KibanaConfig.rb'
  }
}