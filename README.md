#webalizer

## Overview
1. Installs webalizer package.
2. Configures /etc/webalizer.conf. 
3. Overrights thecron job file provided by the package.
4. Optionally creates apache configuration to serve webalizer's output.

This has only been tested on rhel/fedora type systems, it contains
a guess at Debian which may or may not work.

## Examples
Set up webalizer on an alternative logfile, allow access from all to the
apache served ouput

```puppet
class{'webalizer':
    logfile => "/var/log/httpd/my_access.log",
    allow   => 'from all',
    puppet_apache => true,
}
```

## Params
See webalizer::init and webalizer::params for confguration that can passed
to webalizer::init.

## License
Apache 2.0

## Contact
Steve Traylen <steve.traylen@cern.ch>

## Support
Please log tickets and issues at http://github.com/cernops/puppet-webalizer
