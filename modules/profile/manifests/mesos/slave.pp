class profile::mesos::slave {
  class { '::mesos':
    repo => 'mesosphere',
  }
  class { '::mesos::slave':
    env_var => {
      'MESOS_LOG_DIR' => '/var/log/mesos',
    },
  }
  service { ['zookeeper', 'mesos-master']:
    ensure  => stopped,
    enable  => false,
    require => Class['::mesos::slave'],
  }
}
