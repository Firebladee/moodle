class moodle::web::apache (
  $vhost_port    = '80',
  $vhost_docroot = '/var/www/html/moodle',

# $apache_mod = array
# $php_mod = array
){

  case $::operatingsystem {
    'Ubuntu': {
      $mpm = 'prefork'
      package{'software-properties-common':}
    }
    default: { $mpm = undef }
  }

  class { '::apache':
    mpm_module => $mpm,
  }
  apache::vhost {'moodle':
    port    => $vhost_port,
    docroot => $vhost_docroot,
    aliases => {
      alias => '/mymoodle',
      path  => '/var/www/html/moodle',
    },
  }

  class { 'apache::mod::php':}

#  class { 'apache::mod::ssl':}

  class {'php':
    extensions => {
      gd               => {},
      mbstring         => {},
      xmlrpc           => {},
      soap             => {},
      intl             => {},
    #  pecl-zendopcache => {}, # done to test ubuntu 14.04
      mysql            => {},
      curl             => {},
      zip              => {}
    }
  }
}
