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
    'admin@logstash':
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
  rabbitmq_vhost { 'logstash':
    provider => 'rabbitmqctl',
  }

  # Set up the shipper user and permissions
  rabbitmq_user { 'shipper':
    admin    => false,
    password => 'pass',
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions {
    'shipper@logstash':
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
    'indexer@logstash':
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

  package { 'python-pip':
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

  beaver::input::file { 'test-log':
    file => '/var/log/secure',
  }

  beaver::output::rabbitmq { 'rabbitmq_output':
    host          => 'localhost',
    vhost         => 'logstash',
    username      => 'shipper',
    password      => 'pass',
    queue         => 'logstash-queue',
    exchange      => 'logstash-exchange',
    exchange_type => 'fanout',
    key           => 'logstash-key',
  }

}