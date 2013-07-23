# Internal: Configure apache.
#
# Examples
#
#   include apache::config
class apache::config {
  require boxen::config

  $serverrootdir = "${boxen::config::homebrewdir}/opt/apache24"
  $modulesdir    = "${serverrootdir}/modules"

  $configdir    = "${boxen::config::configdir}/apache"
  $configfile   = "${configdir}/httpd.conf"

  $datadir      = "${boxen::config::datadir}/apache"
  $htdocsdir    = "${datadir}/htdocs"

  $logdir       = "${boxen::config::logdir}/apache"
  $logfile      = "${logdir}/httpd.log"
  $errorlogfile = "${logdir}/error.log"

  $executable   = "${boxen::config::homebrewdir}/bin/httpd"
  $pidfile      = "${datadir}/httpd.pid"

  $port = 8080

  anchor { [
    $configdir,
    $configfile,
    $datadir,
    $htdocsdir,
    $executable,
    $logdir,
    $logfile,
    $pidfile,
  ]: }
}
