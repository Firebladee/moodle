class moodle::install::git (
  $git_clone_start = 'git clone --depth=1',
  $git_clone_middle = '-b MOODLE_31_STABLE',
  $git_clone_end   = 'git://git.moddle.org/moodle.git',
){
  # package git
  # add case for different os
  package { 'git': ensure => latest, }

  # create directory
  $dirtree = dirtree('/var/www/html/moodle', '/var/www/html')
  ensure_resource('File', $dirtree, {
    ensure => directory,
    mode   => '0750',
    owner  => 'root', # Needs to change
    group  => 'apache',
  })

  # git clone moodle
  # Add your github key from your own puppet module for this to work.
  exec { 'Base clone':
    command => "${git_clone_start} ${git_clone_middle} ${git_clone_end}",
    cwd     => '/var/www/html',
    path    => '/usr/bin',
    timeout => 600,
    creates => '/var/www/html/moodle/README.txt',
#    mode    => '0750',
#    user    => 'root', # Needs to change
    group   => 'apache',
  }
}
