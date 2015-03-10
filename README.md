# webalizer

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#description)
3. [Usage - Configuration options and additional functionality](#params)
	* [Examples](#examples)
4. [License](#license)
6. [Support](#support)


## Overview

This module allows puppet to manage/configure a webalizer set-up.

It is a fork of CERNOps/webalizer by CERN-Ops, since I didn't manage to contact the original author.

It is also my first attempt to publish a puppet module, so be patient :)

## Description

1. Installs webalizer package.
2. Configures /etc/webalizer.conf. 
3. Overwrites the cron job file provided by the package.
4. Optionally creates apache configuration to serve webalizer's output.
	**NOTE:** On Debian systems, the Apache snippet is '/etc/webalizer/apache.config'.
	It is up to the user to either copy, move or symlink it wherever it makes sense
	(i.e. under '/etc/apache2/config.d/')

This has been tested on rhel/fedora and debian type systems.

## Params
See webalizer::init and webalizer::params for confguration that can passed
to webalizer::init.

### Examples
Set up webalizer on an alternative logfile, allow access from all to the
apache served ouput

```puppet
class{'webalizer':
	logfile => "/var/log/httpd/my_access.log",
	allow   => 'from all',
	puppet_apache => true,
}
```

## License
Apache 2.0

## Support
Please log tickets and issues at https://github.com/jmnavarrol/puppet-webalizer/issues.
Steve Traylen <steve.traylen@cern.ch> for the original module author.
