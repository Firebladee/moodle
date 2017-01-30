class moodle::install::file (

  $download    = 'https://download.moodle.org/download.php/direct/stable31/moodle-latest-31.tgz',
  $destination = '/tmp/moodle.tgz',
  $cache_dir   = '/var/cache/wget',

  $tar     = 'tar -zxvf /tmp/moodle.tgz',
  $cwd     = '/var/www/html',
  $path    = '/bin',
  $creates = '/var/www/html/moodle/README.txt',

){

  wget::fetch { $download:
    destination => $destination,
    cache_dir   => $cache_dir,
  }

  exec{ $tar :
    cwd         => $cwd,
    path        => $path,
    creates     => $creates,
    subscribe   => Wget::Fetch[$download],
    refreshonly => true,
  }

  case $::operatingsystem {
    'Ubuntu': {
      $owner = 'www-data'
      $group = 'www-data'
    }
    default: {
      $owner = 'apache'
      $group = 'apache'
    }
  }

  file{"${cwd}/moodle":
    owner => $owner,
    group => $group,
  }
}
