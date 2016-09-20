class moodle::install (
  $install = ''
){
  case $install {
    git:     {include moodle::install::git}
    file:    {include moodle::install::file}
    web:     {include moodle::install::web}
    cvs:     {include moodle::install::cvs}
    auto:    {include moodle::install::auto}
    default: {notify{"Build type ${install} not yet known":}}
  }

  # create data directory
  $dirtree1 = dirtree('/opt/moodle', '/opt')
  ensure_resource('File', $dirtree1, {
    ensure => directory,
    mode   => '0755',
    owner  => 'apache',
    group  => 'apache',
  })
}
