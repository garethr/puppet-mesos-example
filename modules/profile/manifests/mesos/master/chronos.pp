class profile::mesos::master::chronos {
  package { 'chronos':
    ensure  => latest,
    require => Class['::mesos::repo'],
  }

  service { 'chronos':
    ensure  => running,
    enable  => true,
    require => Package['chronos'],
    notify  => Service['mesos-master'],
  }
}
