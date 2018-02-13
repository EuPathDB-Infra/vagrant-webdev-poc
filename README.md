A Vagrant Demo For EBRC Website Development
===========================================

This is an very incomplete starter project for EBRC website development.
Copy it, make it your own, commit it to your own repository.

The Vagrant box has been provisioned using a subset of the same
pipelines used to set up development webservers in the datacenter so it
should have high parity with the traditional work environments.
Nonetheless, treat this Vagrant project and box as a proof of concept
and chance to identify features needed in our next generation VM
templates.

Prerequisites
=====


The vagrant box is downloaded from a restricted EuPathDB server. You
will need to be on campus for the initial box download to be allowed
through the server firewall. (Downloads happen the first time you run
`vagrant up` or whenever you run `vagrant box update`). Once the box is
cached on your host, you can work off-campus.


Vagrant
---------------

Vagrant manages the lifecycle of the virtual machine, following by the
instructions in the `Vagrantfile` that is included with this project.

[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

You should refer to Vagrant documentation and related online forums for
information not covered in this document.

VirtualBox
------------------

Vagrant needs VirtualBox to host the virtual machine defined in this
project's `Vagrantfile`. Other virtualization software (e.g. VMWare) are
not compatible with this Vagrant project as it is currently configured.

[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

You should refer to VirtualBox documentation and related online forums
for information not covered in this document.

Ansible
---------------

_Ansible is currently not required. This is a placeholder for future tasks of provisioning a specific website._

[http://docs.ansible.com/ansible/intro_installation.html](http://docs.ansible.com/ansible/intro_installation.html)

You should refer to Ansible documentation and related online forums for
information not covered in this document.

Vagrant Landrush Plugin (Optional)
--------------------------------------

The [Landrush](https://github.com/vagrant-landrush/landrush) plugin for
Vagrant provides a local DNS so you can register guest hostnames and
refer to them in the host browser. It is not strictly required but it
makes life easier than editing `/etc/hosts` files. This plugin has
maximum benefit for OS X hosts, some benefit for Linux hosts and no
benefit for Windows. Windows hosts will need to edit the `hosts` file.

    vagrant plugin install landrush

_If you have trouble getting the host to resolve guest hostnames through
landrush try clearing the host DNS cache by running_

`sudo killall -HUP mDNSResponder`.

You should refer to Landrush and Vagrant documentation and related
online forums for information not covered in this document.

Usage
=======

Obtain a Local Copy of This Vagrant Project
--------------------------

Using either Git or Subversion,

    git clone https://github.com/mheiges/vagrant-webdev-poc.git

or

    svn co https://github.com/mheiges/vagrant-webdev-poc.git vagrant-webdev-poc

Start the Virtual Machine
-------------------------

    cd vagrant-webdev-poc
    vagrant up

ssh to the Virtual Machine
-----------------

To connect to the VM as the `vagrant` user, run

    vagrant ssh

Enable a Tomcat Instance
-----------------

The virtual machine comes with the common set of EBRC tomcat instances
preinstalled and configured but they are in the disabled state so they
do not unnecessarily consume system memory. Before installing a website,
you will need to enable one or more of the tomcat instances using
`instance_manager`.

    sudo instance_manager enable AmoebaDB

You may need to increase the memory in the `Vagrantfile` to run more
than one tomcat instance. See Vagrant documentation for instructions.

Likewise, shutdown and disable an instance you no longer need with
`instance_manager`.

    sudo instance_manager disable AmoebaDB

Run sshuttle
-----------------

If you are off campus and want access databases hosted on campus you
will need to tunnel through firewalls. Sshuttle is a useful utility for
that. You can run it on your host if you have OS X, otherwise use the
copy installed on the virtual machine.

The `sshutle` on the virtual machine is managed from the command line.

    sshuttle -e 'ssh -o StrictHostKeyChecking=no' -r joe@host.upenn.edu 10.12.33.0/24 10.11.60.0/24 > /dev/null 2>&1 &

Substitute `joe@host.upenn.edu` with your username and your preferred
tunnel endpoint. For best performance, pick an endpoint that is close to
the database. The `10.12.33.0/24 10.11.60.0/24` specify which subnet
destinations will be tunneled. Substitute these values with appropriate
subnets for our datacenters.

Adjust the command arguments as desired. This example squashes logging
and puts the process into the background; change that if you need to see
stderr/stdout for troubleshooting.

See [sshuttle documentation](http://sshuttle.readthedocs.io/en/stable/)
for details.

Install a Website
-----------------

Once logged in to the VM as the `vagrant` user, run

    installWdkSite

and follow instructions. The hostname is preconfigured to be
`webdev.vm.apidb.org` in the `Vagrantfile` so you can readily create a
website with that hostname.

If are using the Landrush plugin, you can edit the `config.landrush.tld`
value in `Vagrantfile` to set a project vanity domains - allowing you,
for example, to have a website for sa.vm.toxodb.org. See '**About Apache
VirtualHost Names**' below for more details on hostname.

Website Maintenance
-------------------

The virtual machine uses the same environment as physical servers so
standard operating procedures apply. See summary list of tools at
https://wiki.apidb.org/index.php/WebsiteMaintenanceScripts

----

About Apache VirtualHost Names
------------------------------

The convention is to use `vm.*.org` subdomains of our project domains as
hostnames. This allows us to have Landrush to configure the local DNS to
handle any request to those subdomains (e.g. `sa.vm.toxodb.org`) and
direct them to the guest virtual machine while allowing primary domain
requests to pass through, so requests to `www.toxodb.org` are directed
to our physical servers.

In short, for OS X hosts, I recommend using the Landrush plugin and
using a vagrant configuration something like

    config.vm.hostname = 'sa.vm.toxodb.org'
    config.landrush.tld = 'vm.toxodb.org'

and installing your website with a matching hostname, e.g.
`sa.vm.toxodb.org`. (The `sa` name is not important, you can choose any
name you prefer).

With this setup, pointing your browser at http://sa.vm.toxodb.org/ will
show you the virtual machine, http://toxodb.org/ will take you to the
live production website.


Tips
------------

Put `$PROJECT_HOME` on an NFS share somehow so it can be edited with
host IDE. (I manually make a `project_home` directory on
`/vagrant/scratch` and symlink it in `/var/www/sa.vm.toxodb.org/`. There
are many other options to explore.

Known Issues
------------

TBD
