#Class: webalizer::install
class webalizer::install ($version = 'present' ) inherits webalizer {
  package{'webalizer':
    ensure => $version
  }
}
