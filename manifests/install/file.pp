class moodle::install::file (
#  $download    = 'http://downloads.sourceforge.net/project/moodle/Moodle/stable27/moodle-2.7.tgz?r=http%3A%2F%2Fdownload.moodle.org%2Fdownload.php%2Fstable27%2Fmoodle-2.7.tgz&ts=1400159836&use_mirror=heanet',

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

  file{"${cwd}/moodle":
    owner => 'apache',
    group => 'apache',
  }
}
