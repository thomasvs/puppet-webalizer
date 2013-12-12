# Class: webalizer::params
class webalizer::params {
  # Package version of webalizer.
  $version = present

  # Location of configuration file.
  $config = $::osfamily {
    'Debian' => '/etc/webalizer/webalizer.conf',
    'RedHat' => '/etc/webalizer.conf'
  }

  # If not false a cron file will be written.
  $cronfile = $::osfamily {
    'Debian' => false,
    'RedHat' => '/etc/cron.daily/00webalizer'
  }

  #Should I create a httpd configuration file.
  $puppet_apache = true
  # Who is permitted to access the URL.
  $allow = 'from 127.0.0.1'

  #Webalizer configuration. All other variables
  # are just lower cased configurations from
  # man webalizer.conf.
  $logfile = $::osfamily {
    'Debian' => '/var/log/apache2/access.log.1',
    'RedHat' => '/var/log/httpd/access.log'
  }
  $logtype = 'clf'
  $output  = $::osfamily {
    'Debian' => '/var/www/webalizer',
    'RedHat' => '/var/www/usage'
  }
  $historyname = $::osfamily {
    'Debian' => 'webalizer.hist',
    'RedHat' => '/var/lib/webalizer/webalizer.hist'
  }
  $incremental = 'yes'
  $incrementalname = $::osfamily {
    'Debian' => 'webalizer.current',
    'RedHat' => '/var/lib/webalizer/webalizer.current'
  }
  $reporttitle = 'Usage Statistics for'
  $hostname = undef
  $htmlextenstion = html
  $pagetype = ['htm*','cgi','php','shtml']
  $usehttps = no
  $dnscache = '/var/lib/webalizer/dns_cache.db'
  $dnschildren = '10'
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

