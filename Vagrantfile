Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1000
    vb.cpus = 2
  end

  # Configure shared folder
  {
    "." => "/home/vagrant/apps/ecommerce",
  }.each do |src, dest|
    config.vm.synced_folder src, dest, type: "sshfs", sshfs_opts_append: "-o auto_cache,reconnect,workaround=rename"
  end

  # system provision
  config.vm.provision "shell", path: "VagrantfileProvision.sh"

  # configure private network ip
  config.vm.network :private_network, ip: "192.168.68.10"
end
