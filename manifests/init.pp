#
# Installs apache server
#
class apache {
  require homebrew
  require apache::config

  # Set up all the files and directories apache expects. We go
  # nonstandard on this mofo to make things as clearly accessible as
  # possible under $BOXEN_HOME.

  file { [
    $apache::config::configdir,
    $apache::config::datadir,
    $apache::config::logdir
  ]:
    ensure => directory
  }

  file { $apache::config::configfile:
    content => template('apache/config/httpd.conf.erb'),
    notify  => Service['dev.apache']
  }

  file { $apache::config::htdocsdir:
    ensure => directory,
    recurse => true,
    source => 'puppet:///modules/apache/htdocs'
  }

  file { "${boxen::config::bindir}/apachectl":
    content => template('apache/apachectl.erb'),
    mode    => '0755',
    require => Package['apache24'],
  }


  homebrew::tap { 'homebrew/dupes': }
  homebrew::tap { 'jozefizso/apache2': }

  package { 'apache24':
    ensure   => installed,
    provider => 'homebrew',
    notify   => Service['dev.apache']
  }

  file { '/Library/LaunchDaemons/dev.apache.plist':
    content => template('apache/dev.apache.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.apache'],
    owner   => 'root'
  }

  service { 'dev.apache':
    ensure => running,
    require => Package['apache24'],
  }
}
