class profile::zookeeper {
  include ::java
  class { '::zookeeper':
    require => Class['java'],
  }
  contain '::zookeeper'
}
