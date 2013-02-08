node shipper {
  include gpgkeys::tavisto
  repo::tavisto {'tavisto':}

  # Fire up the server
  class { 'rabbitmq::server':
    port              => '5672',
    delete_guest_user => true,
    version           => 'latest',
  }

  # Set up the admin user and permissions
  rabbitmq_user { 'admin':
    admin    => true,
    password => 'pass',
    provider => 'rabbitmqctl',
  }
  rabbitmq_user_permissions {
    'admin@/logstash':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      ;
    'admin@/':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      ;
  }

  # Logstash vhost
  rabbitmq_vhost { '/logstash':
    provider => 'rabbitmqctl',
  }

  # Set up the shipper user and permissions
  rabbitmq_user { 'shipper':
    admin    => false,
    password => 'pass',
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions {
    'shipper@/logstash':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      ;
    'shipper@/':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
  }

  # Set up the indexer user and permissions
  rabbitmq_user { 'indexer':
    admin    => false,
    password => 'pass',
    provider => 'rabbitmqctl',
  }
  rabbitmq_user_permissions {
    'indexer@/logstash':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      ;
    'indexer@/':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
      provider             => 'rabbitmqctl',
      ;
  }

  $rabbitmq_plugins = ['rabbitmq_management']
  rabbitmq_plugin { $rabbitmq_plugins:
    ensure   => present,
    require  => Class['rabbitmq::server'],
    provider => 'rabbitmqplugins',
  }

  package { ['python-pip', 'redis']:
    ensure => latest,
  }

  file { '/usr/bin/pip':
    ensure  => link,
    target  => '/usr/bin/pip-python',
    require => Package['python-pip'],
  }

  class { 'beaver':
    transport => 'rabbitmq',
    require   => File['/usr/bin/pip'],
  }

  beaver::input::file { 'secure':
    file => '/var/log/secure',
    type => 'secure',
  }

  beaver::output::rabbitmq { 'rabbitmq_output':
    queue            => 'logstash-queue',
    exchange_type    => 'fanout',
    host             => 'localhost',
    exchange         => 'logstash-exchange',
    key              => 'logstash-key',
    username         => 'shipper',
    password         => 'pass',
  }

}