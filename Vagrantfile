# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$number_of_slaves = (ENV['MESOS_SLAVES'] || 3).to_i

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  masters = ['ninja', 'nova', 'nuclear']
  slaves = ['tornado', 'torpedo', 'trident']
  all = masters + slaves[0, $number_of_slaves]

  all.each_with_index do |name, i|
    config.vm.define name do |instance|
      instance.vm.hostname = name
      instance.vm.box = "ubuntu/trusty64"
      instance.vm.provision :shell, :path => 'scripts/puppet.sh'

      instance.vm.network "private_network", :ip => "10.24.1.1#{i+1}"

      instance.vm.provision :puppet do |puppet|
        puppet.options        = '--debug --verbose --summarize --reports store --hiera_config=/vagrant/hiera.yaml'
        puppet.manifests_path = 'manifests'
        puppet.module_path    = [ 'modules', 'vendor/modules' ]
        puppet.manifest_file  = 'base.pp'
      end
    end
  end

end
