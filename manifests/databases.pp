
class moodle::databases (
  $database = '',
  $mysql    = $::moodle::params::moodle_mysql,
){

  if $database != '' {
    case $database {
      mysql:    {

        case $::osfamily {
          'RedHat': {
            package{'epel-release': ensure => installed} ->
            package{'php-pear-MDB2-Driver-mysqli': ensure => installed}
          }
          'Debian': {
#            package{'php5.6-mysql': ensure => installed}
          }
          default: {}
        }
        create_resources('class', $mysql)
      }
      postgresql: { include moodle::databases::postgresql }
      default: { notify{"${database} is not yet supported":}}
    }
  }
}
