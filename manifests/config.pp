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
	# it gets all its params from the parent class
		webalizer::vhost { 'default':
			hostname        => $hostname,
			config          => $config,
			logfile         => $logfile,
			output          => $output,
			allow           => $allow,
			logtype         => $logtype,
			historyname     => $historyname,
			incremental     => $incremental,
			clf             => $clf,
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
			searchagents    => $webalizer::params::searchagents		}
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
