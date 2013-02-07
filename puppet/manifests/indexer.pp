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


  # RabbitMQ input
  logstash::input::amqp { 'apache-access':
    exchange  => 'logstash-exchange',
    queue     => 'logstash-queue',
    key       => 'logstash-key',
    host      => '192.168.1.10',
    user      => 'indexer',
    exclusive => false,
    password  => 'pass',
    vhost     => 'logstash',
    type      => 'apache',
    tags      => ['apache','access'],
  }

  logstash::filter::grok { 'apache-access':
    type    => 'apache',
    pattern => ['%{COMBINEDAPACHELOG} (?:%{QS:cookie})',]
  }

  logstash::output::elasticsearch_http { 'local':
    host => '127.0.0.1',
  }

}