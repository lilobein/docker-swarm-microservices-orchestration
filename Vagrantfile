ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

Vagrant.configure("2") do |config|
  config.vm.define "manager01" do |m|
    m.vm.box = "ubuntu/jammy64"
    m.vm.provider "virtualbox" do |vb|
      vb.name = 'manager01'
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 1
    end
    m.vm.hostname = "manager01"
    m.vm.network "private_network", ip: "192.168.56.10"
    m.vm.provision "shell", name: "install-docker", path: "src/scripts/install-docker.sh"
    m.vm.provision "shell", name: "manager-init", inline: <<-SHELL
      docker swarm init --advertise-addr 192.168.56.10
      docker swarm join-token worker -q > /vagrant/token
    SHELL
  end

  config.vm.define "worker01" do |w1|
    w1.vm.box = "ubuntu/jammy64"
    w1.vm.provider "virtualbox" do |vb|
      vb.name = 'worker01'
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 1
    end
    w1.vm.hostname = "worker01"
    w1.vm.network "private_network", ip: "192.168.56.11"
    w1.vm.provision "shell", name: "install-docker", path: "src/scripts/install-docker.sh"
    w1.vm.provision "shell", name: "worker-init", path: "src/scripts/swarm_init.sh", args: [File.read("token").strip]
  end

  config.vm.define "worker02" do |w2|
    w2.vm.box = "ubuntu/jammy64"
    w2.vm.provider "virtualbox" do |vb|
      vb.name = 'worker02'
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 1
    end
    w2.vm.hostname = "worker02"
    w2.vm.network "private_network", ip: "192.168.56.12"
    w2.vm.provision "shell", name: "install-docker", path: "src/scripts/install-docker.sh"
    w2.vm.provision "shell", name: "worker-init", path: "src/scripts/swarm_init.sh", args: [File.read("token").strip]
  end
end
