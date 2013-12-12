#Class: webalizer::config
#confgures webalizer.conf and cron job using
#parameters from init (defaults params.pp)
class webalizer::config (
  $config = $webalizer::params::config,
  $puppet_apache = $webalizer::params::puppet_apache,
  $cronfile = $webalizer::params::cronfile
) inherits webalizer {


  if $::puppet_apache {
    file{'/etc/httpd/conf.d/webalizer.conf':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('webalizer/webalizer-httpd.conf.erb')
    }
  }

  file{$config:
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('webalizer/webalizer.conf.erb')
  }
  #Kill the rpm provided cron job.
  if $cronfile {
    file{$cronfile:
      ensure  => file,
      mode    => '0755',
      owner   => root,
      group   => root,
      content => template('webalizer/webalizer.cron.erb'),
      require => Package['webalizer']
    }
  }
}
