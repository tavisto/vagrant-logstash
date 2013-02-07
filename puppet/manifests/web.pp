node web {

  class { 'kibana':
    standalone  => false,
    config_file => '/vagrant/Kibana/KibanaConfig.rb'
  }
}