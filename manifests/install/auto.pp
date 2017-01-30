class moodle::install::auto () inherits moodle::params {

  case $::operatingsystem {
    'Ubuntu': {
      case $::operatingsystemrelease {
        '16.04': {
          $group = 'root'
          case $::moodle::web {
            true:
              {
                $require = [Class['Apache::Mod::Php'], Class['Apache::Service']]
                case $::moodle::install {
                  true: { $require1 = Class['moodle::install'] }
                  default: { $require1 = undef }
                }
              }
            default: {}
            }
          }
        default: { $group = 'apache'}
        }
      }
    default: { $require = undef }
  }

  exec{'moodle_auto':
    command => "/usr/bin/php /var/www/html/moodle/admin/cli/install.php \
      --dbtype=mysqli \
      --dbname=moodledb \
      --dbuser=fred \
      --dbpass=fredblogs \
      --adminpass=fredblogs \
      --agree-license \
      --lang=en \
      --non-interactive \
      --wwwroot=http://127.0.0.1:4568/moodle \
      --dataroot=/opt/moodle \
      --fullname='test site' \
      --shortname=testsite",
    creates => '/var/www/html/moodle/config.php',
    cwd     => '/var/www/html/moodle',
    group   => $group,
    require => [$require, $require1],
  }
}
