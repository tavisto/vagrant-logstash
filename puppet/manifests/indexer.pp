node indexer {

  include gpgkeys::tavisto
  repo::tavisto {'tavisto':}
  class { 'elasticsearch':
    config                   => {
      'node'                 => {
        'name'               => 'indexer001'
      },
      'index'                => {
        'number_of_replicas' => '0',
        'number_of_shareds'  => '5'
      },
      'network'              => {
        'host'               => '0.0.0.0'
      }
    }
  }
  class { 'logstash':
    jarfile     => '/vagrant/logstash-1.1.9-monolithic.jar',
    provider    => 'custom',
    installpath => '/var/logstash',
    status      => 'unmanaged',
  }


  logstash::input::tcp { 'apache':
    type => 'apache',
    port => 3333,
    tags => ['apache','access']
  }

  logstash::filter::grok { 'apache-access':
    type    => 'apache',
    pattern => ['%{COMBINEDAPACHELOG} (?:%{QS:cookie})',]
  }

  logstash::output::elasticsearch_http { 'local':
    host => '127.0.0.1',
  }

}