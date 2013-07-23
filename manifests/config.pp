# Internal: Configure apache.
#
# Examples
#
#   include apache::config
class apache::config {
  require boxen::config

  $configdir    = "${boxen::config::configdir}/apache"
  $configfile   = "${configdir}/httpd.conf"
  $datadir      = "${boxen::config::datadir}/apache"
  $htdocsdir    = "${datadir}/htdocs"
  $executable   = "${boxen::config::homebrewdir}/bin/httpd"
  $logdir       = "${boxen::config::logdir}/apache"
  $logfile      = "${logdir}/httpd.log"
  $errorlogfile = "${logdir}/error.log"
  $pidfile      = "${datadir}/httpd.pid"

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
