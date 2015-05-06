# Class: webalizer::install
class webalizer::install {
	package { 'webalizer': ensure => present }
}
