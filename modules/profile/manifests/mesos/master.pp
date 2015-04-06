class profile::mesos::master {
  class { '::mesos':
    repo => 'mesosphere',
  }

  class { '::mesos::master':
    env_var => {
      'MESOS_LOG_DIR' => '/var/log/mesos',
    },
    require => Class['profile::zookeeper'],
  }
  contain '::mesos'
  contain '::mesos::master'
}
