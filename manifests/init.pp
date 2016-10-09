# == Class: webalizer
#
# Installs webalizer and configures /etc/webalizer.conf
#
# === Parameters
#
# [*singleconfig*]
#   Should the module create just a single webalizer.conf file or multiple files.
#   Default is *false*: the module will delete the default `webalizer.conf`
#   and will create as many conf files as times the webalizer::config defined typed is called.
#
# [*config*]
#   The single webalizer's config file to be created.  Defaults to:
#   * '/etc/webalizer/webalizer.conf' on Debian.
#   * '/etc/webalizer.conf' on other systems.
#
# [*puppet_apache*]
#   Should the puppet module create an apache config snippet; default is *false*.
#
# [*apache_conffile*]
#   Name and path for the apache config snippet.  Defaults to:
#   * '/etc/webalizer/apache.config' on Debian.
#   * '/etc/httpd/conf.d/webalizer.conf' on other systems.
#
# [*apache_alias*]
#   Apache alias the output directory will be known as.  Defaults to:
#   * '/webalizer' on Debian.
#   * '/usage' on other systems.
#
# [*allow*]
#   Specify who is permitted to access the /usage URL, default is from 'from 127.0.0.1' only.
#   The value ends up in the /etc/httpd/conf.d/webalizer.conf file above.
#	NOTE: Apache 2.4, in use starting Debian 8 ("Jessie"), came with a new authorization syntax.
#	On Debian 7 ("Wheezy") 'allow' defaults to 'from 127.0.0.1' only (see template):
#		Order allow,deny
#		Allow from 127.0.0.1
#	On Debian 8 ("Jessie") 'allow' defaults to 'local' (see template):
#		Require local
#
# [*logfile*, *logtype*, *historyname*, ...]
#   There are around 70 configuration options that set values in /etc/webalizer.conf.
#   These values come direct from the man page for webalizer.conf. Note that some
#   values are strings while some others are arrays. Check the defaults in params.pp
# === Examples
#
#  class { webalizer:
#    logfile       => '/var/log/httpd/my_accces.log',
#    allow         => 'from all',
#    puppet_apache => true
#  }
#
# === Authors
#
# Steve Traylen <steve.traylen@cern.ch> for the original development.
# Jesus M. Navarro <jesus.navarro@undominio.net> for further evolution.
#
# === License
#
# This software is distributed under the terms of the Apache License, version 2.0
#
class webalizer (
# Class-level params
	$singleconfig    = $webalizer::params::singleconfig,
	$config          = $webalizer::params::config,
	# apache-related
	$puppet_apache   = $webalizer::params::puppet_apache,
	$apache_conffile = $webalizer::params::apache_conffile,
	$apache_alias    = $webalizer::params::apache_alias,
	$allow           = $webalizer::params::allow,
# webalizer-related config
	$logfile   = $webalizer::params::logfile,
	$logtype   = $webalizer::params::logtype,
	$outputdir = $webalizer::params::outputdir,
  $historyname = $webalizer::params::historyname,
  $incremental = $webalizer::params::incremental,
  $incrementalname = $webalizer::params::incrementalname,
  $reporttitle = $webalizer::params::reporttitle,
  $hostname = $webalizer::params::hostname,
  $htmlextenstion  = $webalizer::params::htmlextenstion,
  $pagetype  = $webalizer::params::pagetype,
  $usehttps  = $webalizer::params::usehttps,
  $dnscache  = $webalizer::params::dnscache,
  $dnschildren  = $webalizer::params::dnschildren,
  $htmlpre  = $webalizer::params::htmlpre,
  $htmlhead = $webalizer::params::htmlhead,
  $htmlbody = $webalizer::params::htmlbody,
  $htmlpost = $webalizer::params::htmlpost,
  $htmltail = $webalizer::params::htmltail,
  $htmlend   = $webalizer::params::htmlend ,
  $quiet     = $webalizer::params::quiet   ,
  $reallyquiet     = $webalizer::params::reallyquiet   ,
  $timeme  = $webalizer::params::timeme,
  $gmttime  = $webalizer::params::gmttime,
  $debug  = $webalizer::params::debug,
  $foldseqerr  = $webalizer::params::foldseqerr,
  $visittimeout  = $webalizer::params::visittimeout,
  $ignorehist  = $webalizer::params::ignorehist,
  $countrygraph  = $webalizer::params::countrygraph,
  $dailygraph  = $webalizer::params::dailygraph,
  $dailystats  = $webalizer::params::dailystats,
  $hourlygraph  = $webalizer::params::hourlygraph,
  $hourlystats  = $webalizer::params::hourlystats,
  $graphlegend  = $webalizer::params::graphlegend,
  $graphlines  = $webalizer::params::graphlines,
  $topsites  = $webalizer::params::topsites,
  $topksites  = $webalizer::params::topksites,
  $topurls    = $webalizer::params::topurls  ,
  $topkurls   = $webalizer::params::topkurls ,
  $topreferrers  = $webalizer::params::topreferrers,
  $topagents  = $webalizer::params::topagents,
  $topcountries  = $webalizer::params::topcountries,
  $topentry  = $webalizer::params::topentry,
  $topexit  = $webalizer::params::topexit,
  $topsearch  = $webalizer::params::topsearch,
  $topusers  = $webalizer::params::topusers,
  $allsites  = $webalizer::params::allsites,
  $allurls  = $webalizer::params::allurls,
  $allreferrers  = $webalizer::params::allreferrers,
  $allagents  = $webalizer::params::allagents,
  $allsearchstr  = $webalizer::params::allsearchstr,
  $allusers  = $webalizer::params::allusers,
  $indexalias  = $webalizer::params::indexalias,
  $hidesite  = $webalizer::params::hidesite,
  $hidereferrer  = $webalizer::params::hidereferrer,
  $hideurl  = $webalizer::params::hideurl,
  $hideagent  = $webalizer::params::hideagent,
  $hideuser  = $webalizer::params::hideuser,
  $groupurl  = $webalizer::params::groupurl,
  $groupsite  = $webalizer::params::groupsite,
  $groupreferrer  = $webalizer::params::groupreferrer,
  $groupuser  = $webalizer::params::groupuser,
  $hideallsites  = $webalizer::params::hideallsites,
  $groupdomains  = $webalizer::params::groupdomains,
  $groupshading   = $webalizer::params::groupshading,
  $grouphighlight  = $webalizer::params::grouphighlight,
  $ignoresite  = $webalizer::params::ignoresite,
  $ignoreurl  = $webalizer::params::ignoreurl,
  $ignorereferrer  = $webalizer::params::ignorereferrer,
  $ignoreagent  = $webalizer::params::ignoreagent,
  $ignoreuser  = $webalizer::params::ignoreuser,
  $mangleagents  = $webalizer::params::mangleagents,
  $searchagents = $webalizer::params::searchagents
) inherits webalizer::params {
# local params
$apache_template = $webalizer::params::apache_template

# Make sure the webalizer package gets installed
	package { 'webalizer': ensure => present }
	
# Some input validation
	validate_string($allow)
	
# Create base_config if necessary
  if $webalizer::params::base_config != '/etc' {
    file { $webalizer::params::base_config:
      ensure => directory
    }
  }
# On non-debian systems (see params), kill the rpm-provided cron job and use ours instead
	if $webalizer::params::cronfile {
		file{ $webalizer::params::cronfile:
			ensure  => file,
			mode    => '0755',
			owner   => root,
			group   => root,
			content => template('webalizer/webalizer.cron.erb'),
			require => Package['webalizer']
		}
	}
	
# Create an apache config snippet if requested
	if $puppet_apache {
		file{ $apache_conffile:
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => '0644',
			content => template("webalizer/${apache_template}")
		}
	}
	
# Single config means we build a 'webalizer.conf' file right here
	if $singleconfig {
	# we reuse our defined type for this.
	# Bad luck we can't avoid repeating these many params
		webalizer::config { 'default':
			hostname        => $hostname,
			config          => $config,
			logfile         => $logfile,
			outputdir       => $outputdir,
			allow           => $allow,
			logtype         => $logtype,
			historyname     => $historyname,
			incremental     => $incremental,
			incrementalname => $incrementalname,
			reporttitle     => $reporttitle,
			htmlextenstion  => $htmlextenstion,
			pagetype        => $pagetype,
			usehttps        => $usehttps,
			dnscache        => $dnscache,
			dnschildren     => $dnschildren,
			htmlpre         => $htmlpre,
			htmlhead        => $htmlhead,
			htmlbody        => $htmlbody,
			htmlpost        => $htmlpost,
			htmltail        => $htmltail,
			htmlend         => $htmlend ,
			quiet           => $quiet   ,
			reallyquiet     => $reallyquiet   ,
			timeme          => $timeme,
			gmttime         => $gmttime,
			debug           => $debug,
			foldseqerr      => $foldseqerr,
			visittimeout    => $visittimeout,
			ignorehist      => $ignorehist,
			countrygraph    => $countrygraph,
			dailygraph      => $dailygraph,
			dailystats      => $dailystats,
			hourlygraph     => $hourlygraph,
			hourlystats     => $hourlystats,
			graphlegend     => $graphlegend,
			graphlines      => $graphlines,
			topsites        => $topsites,
			topksites       => $topksites,
			topurls         => $topurls  ,
			topkurls        => $topkurls ,
			topreferrers    => $topreferrers,
			topagents       => $topagents,
			topcountries    => $topcountries,
			topentry        => $topentry,
			topexit         => $topexit,
			topsearch       => $topsearch,
			topusers        => $topusers,
			allsites        => $allsites,
			allurls         => $allurls,
			allreferrers    => $allreferrers,
			allagents       => $allagents,
			allsearchstr    => $allsearchstr,
			allusers        => $allusers,
			indexalias      => $indexalias,
			hidesite        => $hidesite,
			hidereferrer    => $hidereferrer,
			hideurl         => $hideurl,
			hideagent       => $hideagent,
			hideuser        => $hideuser,
			groupurl        => $groupurl,
			groupsite       => $groupsite,
			groupreferrer   => $groupreferrer,
			groupuser       => $groupuser,
			hideallsites    => $hideallsites,
			groupdomains    => $groupdomains,
			groupshading    => $groupshading,
			grouphighlight  => $grouphighlight,
			ignoresite      => $ignoresite,
			ignoreurl       => $ignoreurl,
			ignorereferrer  => $ignorereferrer,
			ignoreagent     => $ignoreagent,
			ignoreuser      => $ignoreuser,
			mangleagents    => $mangleagents,
			searchagents    => $webalizer::params::searchagents
		}
	} else {
	# when in multi config mode, we don't want the default conf file provided with the package to get in the middle
		file { $webalizer::params::config:
			ensure  => absent,
			require => Package['webalizer'];
		}
	}
}
