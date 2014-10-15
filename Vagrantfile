# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.provision "shell", inline: "sudo service iptables stop && chkconfig iptables off"

  config.vm.define :master do |master|
    # Every Vagrant virtual environment requires a box to build off of.
    master.vm.box = "puppetlabs/centos-6.5-64-nocm"

    master.vm.provider :vmware_fusion do |vmware, override|
      vmware.vmx["memsize"] = "2048"
    end

    master.vm.provision :hostmanager

    master.hostmanager.enabled = true
    master.hostmanager.manage_host = true
    master.hostmanager.aliases = %w(master puppet puppetmaster)

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    master.vm.network "forwarded_port", guest: 80, host: 8080
    master.vm.network "forwarded_port", guest: 443, host: 4433

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    master.vm.network "public_network"
  end

  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.box = "puppetlabs/centos-6.5-64-nocm"
    puppetdb.hostmanager.aliases = %w(puppetdb)
  end

  config.vm.define "postgresql" do |postgresql|
    postgresql.vm.provision :shell, :path => "./provisions/oss-puppet.sh"
    postgresql.vm.box = "puppetlabs/centos-6.5-64-nocm"
    postgresql.hostmanager.aliases = %w(postgresql)

    postgresql.vm.provision :puppet do |puppet|
      puppet.working_directory = '/vagrant/puppet'
      puppet.manifests_path = 'puppet/manifests'
      puppet.manifest_file  = 'site.pp'
      puppet.module_path    = 'puppet/modules'
    end
  end

  config.vm.define "console" do |console|
    console.vm.box = "puppetlabs/centos-6.5-64-nocm"
    console.hostmanager.aliases = %w(console)
  end

  config.vm.define :"centos-agent" do |agent|
    agent.hostmanager.enabled = true
    agent.hostmanager.manage_host = true
    agent.hostmanager.aliases = %w(centos centos-agent)

    agent.vm.provision :hostmanager

    agent.vm.box = "puppetlabs/centos-6.5-64-nocm"
  end

  config.vm.define :"debian-agent" do |agent|
    agent.hostmanager.enabled = true
    agent.hostmanager.manage_host = true
    agent.hostmanager.aliases = %w(debian debian-agent)

    agent.vm.provision :hostmanager

    agent.vm.box = "puppetlabs/debian-7.4-64-nocm"
  end

  config.vm.define :"windows-agent" do |agent|
    agent.hostmanager.enabled = true
    agent.hostmanager.manage_host = true
    agent.hostmanager.aliases = %w(windows windows-agent)

    agent.vm.communicator = "winrm"
    agent.vm.guest = :windows

    agent.vm.provision :hostmanager

    agent.vm.box =  'packer_windows-2008r2-standard-x64-dev'
    agent.vm.box_url = "http://int-resources.ops.puppetlabs.net/vagrant/puppetless_boxes/packer_windows-2008r2-standard-x64-dev_virtualbox.box"

    agent.vm.provider :vmware_fusion do |vmware, override|
      override.vm.box_url = "http://int-resources.ops.puppetlabs.net/vagrant/puppetless_boxes/packer_windows-2008r2-standard-x64-dev_vmware.box"
    end
  end
end
