# == Class: webalizer
#
# Installs webalizer and configures /etc/webalizer.conf
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# [*version*]
#   Specify a version of the webalizer package to install. Default is *present*
#
# [*config*]
#   Defaults to /etc/webalizer.conf on RedHat family and /etc/webalizer/webalizer.conf
#   on Debian
#
# [*puppet_apache*]
#   Should the puppet module create a /etc/httpd/conf.d/webalizer.conf, default is
#   *true*
#
# [*allow*]
#   Specify who is permitted to access the /usage URL, default is from 'from 127.0.0.1' only.
#   The value ends up in the /etc/httpd/conf.d/webalizer.conf file above.
#
# [*logfile*, *logtype*, *historyname*, ...]
#   There are around 70 configuration options that set values in /etc/webalizer.conf.
#   These values come direct from the man page for webalizer.conf. Note that some
#   values are strings where as some are arrays. Check the defaults in params.pp
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
# Steve Traylen <steve.traylen@cern.ch>
#
# === Copyright
#
# Copyright 2013 Steve Traylen, CERN
#
class webalizer (
# 	$default_config = $webalizer::params::default_config,
#   $version = $webalizer::params::version,
#   $config  = $webalizer::params::config,
#   $puppet_apache = $webalizer::params::puppet_apache,
#   $allow = $webalizer::params::allow,
#   $logfile = $webalizer::params::logfile,
#   $logtype = $webalizer::params::logtype,
#   $historyname = $webalizer::params::historyname,
#   $incremental = $webalizer::params::incremental,
#   $clf = $webalizer::params::clf,
#   $incrementalname = $webalizer::params::incrementalname,
#   $reporttitle = $webalizer::params::reporttitle,
#   $hostname = $webalizer::params::hostname,
#   $htmlextenstion  = $webalizer::params::htmlextenstion,
#   $pagetype  = $webalizer::params::pagetype,
#   $usehttps  = $webalizer::params::usehttps,
#   $dnscache  = $webalizer::params::dnscache,
#   $dnschildren  = $webalizer::params::dnschildren,
#   $htmlpre  = $webalizer::params::htmlpre,
#   $htmlhead = $webalizer::params::htmlhead,
#   $htmlbody = $webalizer::params::htmlbody,
#   $htmlpost = $webalizer::params::htmlpost,
#   $htmltail = $webalizer::params::htmltail,
#   $htmlend   = $webalizer::params::htmlend ,
#   $quiet     = $webalizer::params::quiet   ,
#   $reallyquiet     = $webalizer::params::reallyquiet   ,
#   $timeme  = $webalizer::params::timeme,
#   $gmttime  = $webalizer::params::gmttime,
#   $debug  = $webalizer::params::debug,
#   $foldseqerr  = $webalizer::params::foldseqerr,
#   $visittimeout  = $webalizer::params::visittimeout,
#   $ignorehist  = $webalizer::params::ignorehist,
#   $countrygraph  = $webalizer::params::countrygraph,
#   $dailygraph  = $webalizer::params::dailygraph,
#   $dailystats  = $webalizer::params::dailystats,
#   $hourlygraph  = $webalizer::params::hourlygraph,
#   $hourlystats  = $webalizer::params::hourlystats,
#   $graphlegend  = $webalizer::params::graphlegend,
#   $graphlines  = $webalizer::params::graphlines,
#   $topsites  = $webalizer::params::topsites,
#   $topksites  = $webalizer::params::topksites,
#   $topurls    = $webalizer::params::topurls  ,
#   $topkurls   = $webalizer::params::topkurls ,
#   $topreferrers  = $webalizer::params::topreferrers,
#   $topagents  = $webalizer::params::topagents,
#   $topcountries  = $webalizer::params::topcountries,
#   $topentry  = $webalizer::params::topentry,
#   $topexit  = $webalizer::params::topexit,
#   $topsearch  = $webalizer::params::topsearch,
#   $topusers  = $webalizer::params::topusers,
#   $allsites  = $webalizer::params::allsites,
#   $allurls  = $webalizer::params::allurls,
#   $allreferrers  = $webalizer::params::allreferrers,
#   $allagents  = $webalizer::params::allagents,
#   $allsearchstr  = $webalizer::params::allsearchstr,
#   $allusers  = $webalizer::params::allusers,
#   $indexalias  = $webalizer::params::indexalias,
#   $hidesite  = $webalizer::params::hidesite,
#   $hidereferrer  = $webalizer::params::hidereferrer,
#   $hideurl  = $webalizer::params::hideurl,
#   $hideagent  = $webalizer::params::hideagent,
#   $hideuser  = $webalizer::params::hideuser,
#   $groupurl  = $webalizer::params::groupurl,
#   $groupsite  = $webalizer::params::groupsite,
#   $groupreferrer  = $webalizer::params::groupreferrer,
#   $groupuser  = $webalizer::params::groupuser,
#   $hideallsites  = $webalizer::params::hideallsites,
#   $groupdomains  = $webalizer::params::groupdomains,
#   $groupshading   = $webalizer::params::groupshading,
#   $grouphighlight  = $webalizer::params::grouphighlight,
#   $ignoresite  = $webalizer::params::ignoresite,
#   $ignoreurl  = $webalizer::params::ignoreurl,
#   $ignorereferrer  = $webalizer::params::ignorereferrer,
#   $ignoreagent  = $webalizer::params::ignoreagent,
#   $ignoreuser  = $webalizer::params::ignoreuser,
#   $mangleagents  = $webalizer::params::mangleagents,
#   $searchagents = $webalizer::params::searchagents

) inherits webalizer::params {
	package { 'webalizer': ensure => present }
	# since this module explicitly manages webalizer's config
	# we don't want the default conf file provided with the package to get in the middle
	file { $webalizer::params::config:
		ensure  => absent,
		require => Package['webalizer'];
	}

#   validate_string($version)
#   validate_string($allow)
# 
#   anchor { 'webalizer::begin': } ->
#   class { '::webalizer::install': } ->
#   class { '::webalizer::config': } ->
#   anchor { 'webalizer::end': }

}
