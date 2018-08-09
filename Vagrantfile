# XXX Be sure to add entries to /etc/hosts for each WDK site installed
# E.g.,
#  172.28.128.3 vm.ebrc.org
#  172.28.128.3 plasmodb.vm.ebrc.org
#  172.28.128.3 clinepidb.vm.ebrc.org
#  172.28.128.3 fungidb.vm.ebrc.org
#  172.28.128.3 microbiomedb.vm.ebrc.org

sites = [
  [ 'ClinEpiDB', 8000 ],
  [ 'MicrobiomeDB', 8001 ],
  [ 'PlasmoDB', 8002 ],
  [ 'FungiDB', 8003 ],
]

Vagrant.configure(2) do |config|

  config.vm.box_url = 'http://software.apidb.org/vagrant/webdev.json'
  config.vm.box = 'ebrc/webdev'

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end

  config.ssh.forward_agent = true

  # plasmodb.vm.ebrc.org
  config.vm.hostname = 'vm.ebrc.org'

  config.vm.network 'private_network', type: 'dhcp'

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Fix user and group ids for nfs shares
  # config.nfs.map_uid = Process.uid
  # config.nfs.map_gid = Process.gid
  # config.nfs.map_uid = 60001
  # config.nfs.map_gid = 60001
  # config.vm.synced_folder '.', '/vagrant', type: 'nfs'

  config.vm.synced_folder '.', '/vagrant'

  sites.each { |product, port|
    config.vm.network "forwarded_port", guest: port, host: port
    config.vm.provision 'shell', inline: "/bin/sh /vagrant/scripts/installWdkSite #{product}", privileged: false
    config.vm.provision 'shell', inline: "/bin/sh /vagrant/scripts/installTomcatDebug #{product} #{port}", privileged: true
  }

end
