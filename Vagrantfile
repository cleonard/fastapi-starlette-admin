Vagrant.configure("2") do |config|
  # Official Ubuntu 20.04 LTS (Focal Fossa) builds
  config.vm.box = "ubuntu/focal64"

  # Resources
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # Provision VM
  config.vm.provision "shell", path: "provision.sh", privileged: false

  # Forward port
  config.vm.network :forwarded_port, guest: 8000, host: 8080
end
