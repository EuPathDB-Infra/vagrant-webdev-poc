A Vagrant Demo For EBRC Website Development
===========================================

This is a starter Vagrant project for EBRC website development.
Copy it, make it your own, commit it to your own repository.

The Vagrant box has been provisioned using a subset of the same
pipelines used to set up development webservers in the datacenter so it
has high parity with the traditional work environments.


Prerequisites
=============

The vagrant box is downloaded from a restricted EuPathDB server. You
will need to be on campus for the initial box download to be allowed
through the server firewall. Alternatively, you can use
[sshuttle](#run-sshuttle) to access the server. (Downloads happen the first
time you run `vagrant up` or whenever you run `vagrant box update`). Once the
box is cached on your host, you can work off-campus.


Vagrant
---------------

Vagrant manages the lifecycle of the virtual machine, by following the
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

If you decide to not use landrush, you can add entries to your host machines
`/etc/hosts` file (this will be different on Windows). You will have to
determine the external IP address of your vagrant guest (`ip addr show`).


Usage
=======

Obtain a Local Copy of This Vagrant Project
--------------------------

Using either Git or Subversion,

    git clone https://github.com/EuPathDB-Infra/vagrant-webdev-poc.git

or

    svn co https://github.com/EuPathDB-Infra/vagrant-webdev-poc.git vagrant-webdev-poc


Run sshuttle
-----------------

If you are off campus, you will need to tunnel through firewalls in order to
download the vagrant box, and in order to access databases hosted on campus.
Sshuttle is a useful utility for that. You can run it on your host if you have
OS X or Linux, otherwise use the copy installed on the virtual machine.

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


Start the Virtual Machine
-------------------------

    cd vagrant-webdev-poc
    vagrant up

The first time you run `vagrant up`, the vagrant box will be downloaded to your
host machine. As mentioned earlier, this requires a campus internet connection
or a tunnelled connection via `sshuttle` (see above).

Vagrant will also run any provisioning scripts the first time `vagrant up` is
run. These are declared in [Vagrantfile](Vagrantfile). The Vagrantfile in this
repo includes provisioning scrips to set up a "nice" shell environment, vim
plugins, and it will install and enable WDK websites. It will also set up port
forwarding for associated Tomcat instances. See [this section of
Vagrantfile](Vagrantfile#L9-L14) for details.

_Note, SVN projects will not be checked out and websites will not be built. Read
further to see how to do this._

See https://www.vagrantup.com/docs/provisioning/index.html for more information
about Vagrant provisioning.


ssh to the Virtual Machine
-----------------

To connect to the VM as the `vagrant` user, run

    vagrant ssh


Checkout SVN projects
----------------

Checkout SVN projects needed to build websites. This repo includes a script that
will checkout projects for all websites we develop (genomic, clinepi,
microbiome, and orthomcl).

    cd $HOME/project_home
    /vagrant/scripts/checkout-all.sh

`$HOME/project_home` has been symlinked to the websites intalled in the
provisioning script.


Configure a website
----------------

As a part of the provisioning done with `vagrant up`, a shell function `sc` was
include with the `.bashrc` script. `sc` will start a GNU screen session with the
proper environment variables set to work with a particular website, and will put
you in the base directory for the websites (aka, `$BASE_GUS`). You can use this
to start working with a website.

    sc plasmodb.vm.ebrc.org
    conifer install plasmodb.vm.ebrc.org
    conifer seed plasmodb.vm.ebrc.org
    vi etc/conifer_site_vars.yaml # or use emacs, if you swing that way...
    conifer install plasmodb.vm.ebrc.org


Build a website
-----------------

Once you can configured a website, you are ready to build your site! Make sure
you have tunneling enabled (with sshuttle, or otherwise).

    rebuilder plasmodb.vm.ebrc.org


Other Relevant Information
=================

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

Install a Website
-----------------

Once logged in to the VM as the `vagrant` user, run

    installWdkSite

and follow instructions to manage a property file. The hostname is
preconfigured to be `webdev.vm.apidb.org` in the `Vagrantfile` so you
can readily create a website with that hostname.

Typical EBRC Tomcat instances are pre-installed but disabled to conserve
system resources. You will need to enable the desired Tomcat instance
before running `installWdkSite` with the property file. For example, to
enable the `ToxoDB` instance for a ToxoDB website,

    sudo instance_manager enable ToxoDB

Then install the website directories and Apache and Tomcat
configurations,

    installWdkSite *.prop

You are now responsible for checking out website source code,
configuring the application and building.

If are using the Landrush plugin, you can edit the `config.landrush.tld`
value in `Vagrantfile` to set a project vanity domains - allowing you,
for example, to have a website for sa.vm.toxodb.org. See '**About Apache
VirtualHost Names**' below for more details on hostname.

Website Maintenance
-------------------

The virtual machine uses the same environment as physical servers so
standard operating procedures apply.

For a virtual environment, the most commonly used tools are:

**rebuilder** - a system script to rebuild development websites. In its
simplest form, just pass it the host name of the website you want to
build.

    rebuilder jane.toxodb.org

Run `rebuilder -h` for additional help.

**conifer** - for configuring the WDK and auxiliary components.

See the [Quick Start Guide](https://cbilsvn.pmacs.upenn.edu/svn/gus/FgpUtil/trunk/Util/lib/conifer/docs/QuickstartGuide.md)
for basic usage, and the 
[User Manual](https://cbilsvn.pmacs.upenn.edu/svn/gus/FgpUtil/trunk/Util/lib/conifer/docs/UserManual.md)
for more information.

**cattail** - a convenience script that locates the Apache and Tomcat
logs for a given website and runs `tail` on the Apache and Tomcat logs.

    cattail jane.toxodb.org

Run `cattail  -h` for additional help.

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

### Editing project from host machine

Put `$PROJECT_HOME` on an NFS share somehow so it can be edited with
host IDE. (I manually make a `project_home` directory on
`/vagrant/scratch` and symlink it in `/var/www/sa.vm.toxodb.org/`. There
are many other options to explore.

### Partial rebuild

It will probably be necessary at some point for you to rebuild a part of a site
for development purposes.  This can be accomplished without running the full
5-15 minute build by following the relevant steps below.

<!-- TODO: explain the bldw command use case -->

#### Java Code Change

If you have only made a change to Java code and need to rebuild a project the
`bld {project}` command can be used to rebuild a specific project:

1. Ensure desired code changes are available in the vm `project_home` directory.
2. From the `/var/www/{SiteName}/{site.vm}` directory run the following command:
   ```bash
   bld {project}
   ```
   Example rebuilding the WDK/Model project using PlasmoDB:
   ```bash
   sc plasmodb.vm.ebrc.org
   bld WDK/Model
   ```
3. Deploy the built changes:
   ```bash
   instance_manager manage {SiteName} reload {site.vm}
   ```
   Example using PlasmoDB:
   ```bash
   instance_manager manage PlasmoDB reload plasmo.vm
   ```
   This command will not show any output until it completes.

Troubleshooting
---------------

### Yarn

Occasionally, during the build step, the yarn command will fail.
To get around this, the following steps can be used:

1. Navigate to the `/var/www/{SiteName}/{name.vm}` directory.\
   This is the working directory you will be in after running the `sc {site}` 
   command described above.
2. Ensure that yarn is installed:
   ```bash
   npm install -g yarn
   ```
3. Run the `yarn` command for the relevant projects:
   ```bash
   cd project_home/WDK/View && yarn && cd ../.. \
     && cd EbrcWebsiteCommon/Site && yarn && cd ../.. \
     && cd ApiCommonWebsite/Site && yarn && cd ../../..
   ```
4. Retry the build using the `rebuilder` command step above.

Known Issues
------------

TBD
