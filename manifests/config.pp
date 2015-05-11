# Define ::webalizer::config
# Configures a webalizer's conf file and output directory aimed at a specific virtual host
define webalizer::config (
# non-default/customized params go first
	$hostname  = $title,
	$config    = "${webalizer::params::base_config}/${title}.conf",
	$logfile   = "${webalizer::params::base_log}/${title}.access.log",
	$outputdir = "${webalizer::params::outputdir}/${title}",
	
# then, all the other params
  $logtype = $webalizer::params::logtype,
  $historyname = $webalizer::params::historyname,
  $incremental = $webalizer::params::incremental,
  $incrementalname = $webalizer::params::incrementalname,
  $reporttitle = $webalizer::params::reporttitle,
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
) {
# A bit of error checking first:
# we are either called from our parent class (single config) or from a different class (multiple configs)
	if $::webalizer::singleconfig {
		if $caller_module_name != 'webalizer' {
			fail( "Processing SINGLE config, but you explicitly called the 'webalizer::config' defined type.
			       You should pass parameters to the webalizer class instead!!" )
		}
	} else {
		if caller_module_name == 'webalizer' {
			fail( "Processing MULTI config but called from webalizer.
			       Please, call the 'webalizer::config' defined type instead!!" )
		} elsif $config == $webalizer::params::config {
		# in MULTI mode, 'webalizer.conf' becomes a "forbidden" name
			fail( "Webalizer's config file can't be ${config} when in MULTI config mode!!
			       Please choose a different one or let unassigned so 'webalizer::config' picks a suitable name." )
		}
	}
	
# Once everything's OK, let's go for the real stuff
# vhost-based webalizer conf file
	file { $config:
		ensure  => file,
		mode    => '0644',
		owner   => root,
		group   => root,
		content => template('webalizer/webalizer.conf.erb'),
		require => Package['webalizer'];
	}
# set per-vhost output dir
	file { $outputdir:
		ensure  => directory,
		mode    => '0755',
		owner   => 'root',
		group   => 'root',
		require => Package['webalizer'];
	}
}
