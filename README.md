# Managing Mesos with Puppet

One of [my colleagues](https://github.com/rji) wrote up a post on
[Managing Mesos with Puppet](http://rogerignazio.com/blog/managing-mesos-with-puppet/).
This repo turns that blog post into a working Vagrant based example.
This is both:

* A good way of setting up a local Mesos cluster with Chronos and
  Marathon
* A starting point if you're building out a production cluster with
  Puppet

## Dependencies

First you'll need to install [Bundler](http://bundler.io/).
We'll use that to install [librarian-puppet](https://github.com/rodjek/librarian-puppet)
which we'll then use to download the required Puppet modules. You'll also
need [Vagrant](https://www.vagrantup.com/) and Virtualbox installed.

For the full example you'll need the
[vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager)
plugin which can be installed with:

    vagrant plugin install vagrant-hostmanager

And you can hugely speed up the full load time by using
[vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) to build a
local package cache for the boxes:

    vagrant plugin install vagrant-cachier

Then lets install librarian-puppet and download the relevant Puppet
modules:

    bundle install
    bundle exec librarian-puppet install

The last command will download the Puppet modules listed in `Puppetfile`
into the `vendor/modules` directory.


## Usage

    vagrant up --provider virtualbox

This will launch 6 virtual machines, a cluster of 3 masters and 3
slaves. If you want to reduce the number of slaves you can run:

    MESOS_SLAVES=1 vagrant up --provider virtualbox

This will take some time to run as it's installing Java, Zookeeper,
Mesos, Marathon and Chronos on all the hosts. Note that in order to
setup the local host entries it might prompt you for your sudo password.
Once it has completed you should be able to access the varios services:

* Mesos: [ninja:5050](http://ninja:5050)
* Marathon: [ninja:8080](http://ninja:8080)
* Chronos: [ninja:4400](http://ninja:4400)

Note that depending on the leader election for the master, the above
URLs might redirect you to the current leader first.


## Thanks

* To Roger for his [blog
  post](http://rogerignazio.com/blog/managing-mesos-with-puppet)
* To [Tomas](https://github.com/deric) for the excellent
  [puppet-mesos](https://github.com/deric/puppet-mesos) module
* [Mesosphere](http://mesosphere.com/) for the Mesos, Chronos and
  Maraathon packages
