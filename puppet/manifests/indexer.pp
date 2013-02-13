node indexer {

  include gpgkeys::tavisto
  repo::tavisto {'tavisto':}
  class { 'elasticsearch':
    config      => {
      'node'    => {
        'name'  => 'indexer001'
      },
      'index'   => {
        'number_of_replicas' => '0',
        'number_of_shareds'  => '5'
      },
      'network' => {
        'host'  => '0.0.0.0'
      }
    }
  }

  class { 'logstash':
    status   => 'running',
    provider => 'package',
  }

  # Quick dirty input
  logstash::input::tcp { 'apache':
    type => 'apache',
    port => 3333,
    tags => ['apache','access']
  }

  logstash::input::file { 'logstash':
    type         => 'logstash',
    path         => ['/var/log/logstash/logstash.log'],
    sincedb_path => '/var/lib/logstash',
  }

  logstash::filter::json { 'logstash':
    type => 'logstash',
  }


  # RabbitMQ input
  #logstash::input::amqp { 'secure':
  #  queue       => 'logstash-queue',
  #  type        => 'fanout',
  #  host        => '192.168.1.10',
  #  exchange    => 'logstash-exchange',
  #  user        => 'indexer',
  #  password    => 'pass',
  #  tags        => ['apache','access'],
  #}

  logstash::input::redis { 'redis_from_beaver':
    type      => 'secure',
    host      => '192.166.1.10',
    data_type => 'list',
    key       => 'logstash:beaver'
  }

  logstash::filter::grok { 'apache-access':
    type    => 'apache',
    pattern => ['%{COMBINEDAPACHELOG} (?:%{QS:cookie})',]
  }

  logstash::output::elasticsearch_http { 'local':
    host => '127.0.0.1',
  }

}