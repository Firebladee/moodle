class moodle (
  $install  = true,
  $web      = true,
  $database = true,
  $auto     = true,

  $install_type  = 'file',
  $web_type      = 'apache',
  $database_type = 'mysql',

  $moodle_mysql = $moodle::params::moodle_mysql,
  $dbtype       = 'mysqli',
  $dblibrary    = 'native',
  $dbhost       = 'localhost',
  $db_user      = 'fred',
  $db_name      = 'moodledb',
  $dbpass       = 'fredblogs',
  $prefix       = 'mdl_',
  $wwwroot      = 'http://127.0.0.1:4568/moodle',
  $dataroot     = '/opt/moodle',
  $admin        = 'admin',

  $directorypermissions = '0777',

  $dboptions = $moodle::params::dboptions,
){
  include moodle::params

  if $install {
    class{'moodle::install':
      install => $install_type,
  }}

  if $auto {
    include moodle::install::auto
  }

  if $database {
    class{'moodle::databases':
      database => $database_type,
  }}

  if $web {
    class{'moodle::web':
      web => $web_type,
  }}

  # set up cron
#  cron { 'moodle':
#    command => '/usr/bin/wget -O /dev/null http://localhost/mymoodle/admin/cron.php',
#    user    => root, # moodle user
#    minute  => '*/5',
#  }
}
