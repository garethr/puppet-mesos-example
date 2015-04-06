class role::mesos::master {
  include profile::zookeeper
  include profile::mesos::master
  include profile::mesos::master::chronos
  include profile::mesos::master::marathon
}
