# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Grab the sl6 box from Tavisto's sandbox if it is not already imported
  config.vm.box_url = 'https://dl.dropbox.com/u/766359/sl6.box'
  config.vm.box = "sl6"

  config.vm.define :shipper do |config01|
    config01.vm.host_name = "shipper"
    config01.vm.network :hostonly, "192.168.1.10"
    config01.vm.provision :puppet do |puppet|
      puppet.manifest_file = "shipper.pp"
      puppet.module_path   = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
    end
  end

  config.vm.define :indexer do |config02|
    config02.vm.host_name = "indexer"
    config02.vm.forward_port 9200, 9200
    config02.vm.customize ["modifyvm", :id, "--memory", 1024]
    config02.vm.network :hostonly, "192.168.1.11"
    config02.vm.provision :puppet do |puppet|
      puppet.manifest_file = "indexer.pp"
      puppet.module_path   = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
    end
  end

  config.vm.define :web do |config03|
    config03.vm.host_name = "web"
    config03.vm.forward_port 80, 8080
    config03.vm.forward_port 5601, 5601
    config03.vm.network :hostonly, "192.168.1.12"
    config03.vm.provision :puppet do |puppet|
      puppet.manifest_file = "web.pp"
      puppet.module_path   = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
    end
  end

end
