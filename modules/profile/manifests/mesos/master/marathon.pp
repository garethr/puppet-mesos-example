class profile::mesos::master::marathon {
  package { 'marathon':
    ensure  => latest,
    require => Class['::mesos::repo'],
  }

  service { 'marathon':
    ensure  => running,
    enable  => true,
    require => Package['marathon'],
    notify  => Service['mesos-master'],
  }
}
