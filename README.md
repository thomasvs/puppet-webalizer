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

It is a fork of [CERNOps/webalizer by CERN-Ops](https://github.com/cernops/puppet-webalizer).

It is also my first attempt to publish a puppet module, so please be patient :)

## Description
1. Installs the webalizer package.
2. Creates webalizer's config file(s). 
3. Overwrites the cron job file provided by the package (non-debian only).
4. Optionally creates apache configuration to serve webalizer's output.  
	**NOTE:** See [Limitations: Apache config](#apache-config).

This module has been tested on Debian *"wheezy"* and *"jessie"*.

## Usage
There are two *"main modes"* of usage, depending if you want to create just one or more than one webalizer configuration files (i.e. to produce stats for multiple virtual hosts).

On top of that, both the `webalizer` class and the `webalizer::config` *defined type* basically accept as many params as the webalizer program makes available.

For default values see `webalizer::params` and either `webalizer` or `webalizer::config` respectively.

### Single configuration file
If you just need to produce output stats for a single web site, you need to declare `webalizer` as a parametrized class and let it produce a single `webalizer.conf` file.

The following is an example for setting up webalizer to process an alternate log file, and then grant *access from all* to the publication tree (but see [Limitations: Apache config](#apache-config) for details about the *'allow'* parameter):
```puppet
class { 'webalizer':
	singleconfig  => true,
	logfile       => "/var/log/httpd/my_access.log",
	puppet_apache => true,
	allow         => 'from all',
}
```

### Multiple configuration files
If you want to produce stats for different web sites, you should use the `webalizer::config` defined type to produce multiple webalizer config files.  In that case, you can **not** call the `webalizer` class with the *singleconfig* parameter set to *true*.  
An example follows:
```puppet
class { 'webalizer':
	puppet_apache => true,
	allow         => 'from localhost 127.0.0.0/8 ::1 192.168.1.0/24',
}
webalizer::config { ['site1', 'site2']:
	htmlhead => ['<meta http-equiv="content-type" content="text/html; charset=UTF-8">',
	             '<META NAME="author" CONTENT="The Webalizer">'],
	htmltail => '';
}
```

First we declare the `webalizer` class and tell it to create an apache snippet.  Note that, since this invocation won't create a `webalizer.conf` file and, in fact, **it will delete the `webalizer.conf` file at its default location**, webalizer-related params will be ignored.  
An alternate invocation if default params are OK, would be just `include webalizer`.  
Then we declare the `webalizer::config` defined type, which tries to set sensible defaults out of the defined type instance's *$title*:
* On Debian (and derivatives):
	* Output config file: `/etc/webalizer/${title}.conf`
	* Log file to process: `/var/log/apache2/${title}.access.log`
	* Hostname: `$title`
	* Output directory: `/var/www/webalizer/${title}`
* On other systems:
	* Output config file: `/etc/${title}.conf`
	* Log file to process: `/var/log/httpd/${title}.access.log`
	* Output directory: `/var/www/usage/${title}`

Of course, you still can overwrite all the avaliable params for a finerly tuned result.

## Limitations

### OS support
Up to version 0.2.3, this module has been tested on rhel/fedora and debian systems.

Version 1.0.0 underwent significant changes in order to allow virtual hosts support by means of multiple configuration files.  Therefore, since I only use Debian systems nowadays, version 1.0.0 and upwards are tagged to only be Debian compatible.  
This doesn't necessarily mean it won't work on redhat derivatives, it's only it hasn't been tested.  
In case of problems on other distributions, patches are welcome.

### Apache config
You probably want webalizer's stats to be published by your local web server but current support for this is very basic:
* You can set webalizer's `$puppet_apache` boolean class variable to *true*.  This will create an apache config snippet either at `/etc/webalizer/apache.config` (on debian) or `/etc/httpd/conf.d/webalizer.conf` (on other systems).  
It is up to you what to do with it in order for Apache to read it and publish webalizer's contents.
	* There was a auth-related change in apache's syntax on version 2.4 upwards.  While in 2.2 you'd use something like the following snippet to control access to a virtual dir...
	```apache```
	Order allow,deny
	Allow from 127.0.0.1
	```  
	...You will use something like the following with apache 2.4:
	```apache```
	Require local
	```  
	I added logic and a new template to cope with the differences.  For more details see [the relevant Apache docs](http://httpd.apache.org/docs/current/mod/mod_authz_host.html).
* The `webalizer::config` defined type, offers no support for the `$puppet_apache` boolean, so it's up to you how to publish webalizer's stats when more than one site is processed.

## License
Apache 2.0

## Support
Please log tickets and issues at https://github.com/jmnavarrol/puppet-webalizer/issues.
