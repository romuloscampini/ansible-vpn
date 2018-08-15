# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize [ "modifyvm", :id, "--memory", "512", "--cpus", "1" ]
  end

  # Rede
  config.vm.define "vagrant" do |vb|
    config.vm.network "private_network", ip: "192.168.33.30"
  end

  # Ansible
 config.vm.provision "ansible" do |ansible|
   ansible.playbook = "openvpn.yml"
   ansible.groups = {
     "vpn" => [ "vagrant" ]
   }
   ansible.raw_ssh_args = ['-o ControlMaster=auto']
   ansible.verbose = "vv"
 end

end
