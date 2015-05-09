# webalizer

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#description)
3. [Usage - Configuration options and additional functionality](#usage)
	* [Single config file](#single-config-file)
	* [Multiple configuration files](#multiple-configuration-files)
4. [Limitations - OS compatibility, etc.](#limitations)
	* [OS support](os-support)
	* [Apache config](#apache-config)
5. [License](#license)
6. [Support](#support)


## Overview
This module allows puppet to manage/configure a webalizer set-up, providing support for multiple virtual hosts.

It is a fork of CERNOps/webalizer by CERN-Ops.

It is also my first attempt to publish a puppet module, so please be patient :)

**WARNING:** This module currently under heavy refactoring.  Documentation will be updated afterwards.

## Description
1. Installs the webalizer package.
2. Configures webalizer's config file(s). 
3. Overwrites the cron job file provided by the package (rhel only).
4. Optionally creates apache configuration to serve webalizer's output.  
	**NOTE:** See [Limitations: Apache config](#apache-config).

This module has been tested on Debian *"wheezy"*.

## Usage
There are two *"main modes"* of usage, depending if you want to create just one or more than one configuration files (i.e. to produce stats for multiple virtual hosts).

On top of that, both the `webalizer` class and the `webalizer::vhost` defined type basically accept as many params as the webalizer program makes available.

For default values see `webalizer::params` and either `webalizer` or `webalizer::vhost` respectively.

### Single configuration file
If you just need to produce output stats for a single web site, you are better off declaring `webalizer` as a parametrized class and let it produce a single `webalizer.conf` file.

The following is an example for setting up webalizer to process an alternate log file, and then grant *access from all* to the publication tree:
```puppet
class { 'webalizer':
	logfile       => "/var/log/httpd/my_access.log",
	allow         => 'from all',
	puppet_apache => true,
}
```

### Multiple configuration files
If you want to produce stats for different web sites, you can use the `webalizer::vhost` defined type to produce multiple webalizer config files.  An example follows:
```puppet
class { 'webalizer': default_config => false }
webalizer::vhost { ['site1', 'site2']:
	allow    => 'from localhost 127.0.0.0/8 ::1 192.168.1.0/24',
	logtype  => 'clf',
	htmlhead => ['<meta http-equiv="content-type" content="text/html; charset=UTF-8">',
	             '<META NAME="author" CONTENT="The Webalizer">'],
	htmltail => '';
}
```

First we declare the `webalizer` class with a single parameter to get rid of the default `webalizer.conf` file.  
Then we declare the `webalizer::vhost` defined type, which tries to set sensible defaults out of the defined type instance's $title:
* On Debian (and derivatives):
	* Output config file: `/etc/webalizer/${title}.conf`
	* Log file to process: `/var/log/apache2/${title}.access.log`
	* Hostname: `$title`
	* Output directory: `/var/www/webalizer/${title}`
* On RedHat (and derivatives):
	* Output config file: `/etc/${title}.conf`
	* Log file to process: `/var/log/httpd/${title}.access.log`
	* Output directory: `/var/www/usage/${title}`

Of course, you still can overwrite all the avaliable params for a finer tuned result.

## Limitations

### OS support
Up to version 0.2.3, this module has been tested on rhel/fedora and debian systems.

Version 1.0.0 underwent significant changes in order to allow virtual hosts support by means of multiple configuration files.  Therefore, since I only use Debian systems nowadays, version 1.0.0 and upwards are tagged to only be Debian compatible.  
This doesn't necessarily mean it won't work on redhat derivatives, it's only it hasn't been tested.  In case of problems on redhat derivatives, patches are welcome.

### Apache config
You probably want webalizer's stats to be published by your local web server but current support for this is very basic:
* You can set webalizer's `$puppet_apache` boolean class variable to *true* (which is the default).  This will create an apache config snippet either at `/etc/httpd/conf.d/webalizer.conf` (on redhat) or `/etc/webalizer/apache.config` (on debian).  
It is up to you what to do with it in order for Apache to read it and publish webalizer's contents.
* The `webalizer::vhost` defined type, offers no support for the `$puppet_apache` boolean, so it's up to you how to publish webalizer's stats.

## License
Apache 2.0

## Support
Please log tickets and issues at https://github.com/jmnavarrol/puppet-webalizer/issues.
