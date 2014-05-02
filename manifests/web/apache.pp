

class moodle::web::apache {

  class { 'apache':}
  apache::vhost {'moodle':
    port    => '80',
    docroot => '/var/www/html/moodle',
    aliases => {
    alias   => '/mymoodle',
    path    => '/var/www/html/moodle',
    }
  }
  class { 'apache::mod::php':}

}
