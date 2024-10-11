# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

VAGRANT_BOX         = "ubuntu/focal64"
#VAGRANT_BOX_VERSION = "4.2.10"
CPUS_MASTER_NODE    = 2
CPUS_WORKER_NODE    = 2
MEMORY_MASTER_NODE  = 4096
MEMORY_WORKER_NODE  = 2048
WORKER_NODES_COUNT  = 1


Vagrant.configure(2) do |config|

  # Kubernetes Master Server
  config.vm.define "kmaster" do |node|

    node.vm.box               = VAGRANT_BOX
    node.vm.box_check_update  = false
    node.vm.provider :virtualbox
    #node.vm.box_version       = VAGRANT_BOX_VERSION
    node.vm.hostname          = "kmaster.example.com"
    node.vm.disk :disk, size: "50GB", primary: true
    node.vm.provision "shell", path: "bootscript.sh"
    node.vm.network "public_network", bridge: "192.168.15.17", :adapter=>2, type: "dhcp"
    node.vm.provider :virtualbox do |v|
      v.name    = "kmaster"
      v.memory  = MEMORY_MASTER_NODE
      v.cpus    = CPUS_MASTER_NODE
    end

  end


  # #Kubernetes Worker Nodes
  (1..WORKER_NODES_COUNT).each do |i|

    config.vm.define "kworker#{i}" do |node|

      node.vm.box               = VAGRANT_BOX
      node.vm.box_check_update  = false
      #node.vm.box_version       = VAGRANT_BOX_VERSION
      node.vm.hostname          = "kworker#{i}.example.com"
      node.vm.disk :disk, size: "50GB", primary: true
      node.vm.provision "shell", path: "bootscript.sh"
      node.vm.network "public_network", bridge: "192.168.15.17", :adapter=>2, type: "dhcp"

      node.vm.provider :virtualbox do |v|
        v.name    = "kworker#{i}"
        v.memory  = MEMORY_WORKER_NODE
        v.cpus    = CPUS_WORKER_NODE
      end

    end

  end

end
