
class moodle::databases (
  $database = '',
){

  if $database != '' {
    case $database {
      mysql:    {
        package{'epel-release': ensure => installed} ->
        package{'php-pear-MDB2-Driver-mysqli': ensure => installed}
        create_resources('class', $::moodle::params::moodle_mysql)
      }
      postgresql: { include moodle::databases::postgresql }
      default: { notify{"${database} is not yet supported":}}
    }
  }
}
