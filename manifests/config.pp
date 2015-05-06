#Class: webalizer::config
#confgures webalizer.conf and cron job using
#parameters from init (defaults params.pp)
class webalizer::config (
  $config = $webalizer::params::config,
  $puppet_apache = $webalizer::params::puppet_apache,
  $cronfile = $webalizer::params::cronfile
) inherits webalizer {

	if $puppet_apache {
		file{ $webalizer::params::apache_conffile:
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => '0644',
			content => template('webalizer/webalizer-httpd.conf.erb')
		}
	}
	
	if $default_config {
		webalizer::vhost { 'default':
			hostname => "${webalizer::params::hostname}",
			config   => "${webalizer::params::config}",
			logfile  => "${webalizer::params::logfile}",
			output   => "${webalizer::params::output}";
		}
	} else {
		file { "${webalizer::params::config}": ensure => absent }
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
