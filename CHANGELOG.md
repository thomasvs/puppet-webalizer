##2015-05-07   Release 1.0.0
- DNSCache and DNSChildren options are no longer added
  to webalizer.conf file by default since the values
  are not supported by new webalizers. The old 
  behaviour can be restored by explicitly setting 
  those values.
```puppet
class webalizer{
  dnscache    => '/var/lib/webalizer/dns_cache.db',
  dnschildren => '10'
}
```

- Addition of tests

##2013-12-12   Release 0.2.1
- First guess at debian support.
- Bugfixes in webalizer.conf.erb template.

