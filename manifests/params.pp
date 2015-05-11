# Class: webalizer::params
class webalizer::params {
# Class params:
	# the webalizer conf file can be built either right from the webalizer class,
	# in which case a single webalizer.conf file exists,
	# or multiple config files will be built (the default),
	# in which case some params need to be adjusted accordingly (see webalizer::config)
	# and webalizer.conf should NOT exist.
	$singleconfig = false
	# location of default webalizer configuration file.
	$base_config = $::osfamily ? {
		'Debian' => '/etc/webalizer',
		default  => '/etc'
	}
	$config = "${base_config}/webalizer.conf"
	
	# Apache-related config.
	# Should I create a httpd configuration file?
	$puppet_apache = false
	# apache conf snippet file name and location
	$apache_conffile = $::osfamily ? {
	# on Debian the cron script will treat all *.conf under /etc/webalizer
	# as webalizer.conf files, so I need a different extension for this.
	# On the other hand, Debian's standard is to leave the apache snippet within the main conf dir,
	# then add a symlink to this file wherever required.
		'Debian' => "${base_config}/apache.config",
		default  => '/etc/httpd/conf.d/webalizer.conf',
	}
	# The (virtual) URL for web access
	$apache_alias = $::osfamily ? {
		'Debian' => '/webalizer',
		default  => '/usage'
	}
	# Who is permitted to access the URL.
	$allow = 'from 127.0.0.1'
	
	# Cron-related config is only valid for non-debian systems
	# If not false, a customized cron file will be built.
	$cronfile = $::osfamily ? {
		'Debian' => false,
		default  => '/etc/cron.daily/00webalizer'
	}

# All other variables are just lowercased configurations from man webalizer.conf.

# Log file to process
	$base_log = $::osfamily ? {
		'Debian' => '/var/log/apache2',
		default  => '/var/log/httpd',
	}
	$logfile = $::osfamily ? {
		'Debian' => "${base_log}/access.log.1",
		default  => "${base_log}/access.log"
	}
  $logtype = 'clf'
  
  $output  = $::osfamily ? {
    'Debian' => '/var/www/webalizer',
    default  => '/var/www/usage'
  }
  $historyname = $::osfamily ? {
    'Debian' => 'webalizer.hist',
    default  => '/var/lib/webalizer/webalizer.hist'
  }
  $incremental = 'yes'
  $incrementalname = $::osfamily ? {
    'Debian' => 'webalizer.current',
    default  => '/var/lib/webalizer/webalizer.current'
  }
  $reporttitle = 'Usage Statistics for'
  $hostname = 'localhost'
  $htmlextenstion = html
  $pagetype = ['htm*','cgi','php','shtml']
  $usehttps = no
	$dnscache = $::osfamily ? {
		'Debian' => 'dns_cache.db',
		default  => undef
	}
	$dnschildren = $::osfamily ? {
		'Debian' => '10',
		default  => undef
	}
  $htmlpre = ['<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">']
  $htmlhead = ['<META NAME="author" CONTENT="The Webalizer">']
  $htmlbody = '<HTMLBody <BODY BGCOLOR="#E8E8E8" TEXT="#000000" LINK="#0000FF" VLINK="#FF0000">'
  $htmlpost = ['<BR CLEAR="all">']
  $htmltail = '<IMG SRC="msfree.png" ALT="100% Micro$oft free!">'
  $htmlend  = '</BODY></HTML>'
  $quiet    = 'yes'
  $reallyquiet    = 'no'
  $timeme = 'no'
  $gmttime = 'no'
  $debug = 'no'
  $foldseqerr = 'yes'
  $visittimeout = '1800'
  $ignorehist = 'no'
  $countrygraph = 'yes'
  $dailygraph = 'yes'
  $dailystats = 'yes'
  $hourlygraph = 'yes'
  $hourlystats = 'yes'
  $graphlegend = 'yes'
  $graphlines = '2'
  $topsites = '30'
  $topksites = '10'
  $topurls   = '30'
  $topkurls  = '10'
  $topreferrers = '30'
  $topagents = '15'
  $topcountries = '30'
  $topentry = '10'
  $topexit = '10'
  $topsearch = '20'
  $topusers = '20'
  $allsites = 'no'
  $allurls = 'no'
  $allreferrers = 'no'
  $allagents = 'no'
  $allsearchstr = 'no'
  $allusers = 'no'
  $indexalias = ['home.htm','homepage.htm']
  $hidesite = []
  $hidereferrer = []
  $hideurl = ['*.gif','*.GIF','*.jpg','*.JPG','*.png','*.PNG','*.ra']
  $hideagent = ['RealPlayer']
  $hideuser = []
  $groupurl = []
  $groupsite = []
  $groupreferrer = []
  $groupuser = []
  $hideallsites = 'no'
  $groupdomains = '0'
  $groupshading  = 'yes'
  $grouphighlight = 'yes'
  $ignoresite = []
  $ignoreurl = []
  $ignorereferrer = []
  $ignoreagent = []
  $ignoreuser = []
  $mangleagents = '0'
  $searchagents = ['yahoo.com       p=','altavista.com   q=','google.com      q=','eureka.com      q=']
}
