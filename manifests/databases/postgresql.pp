class moodle::databases::postgresql {

  class {'postgresql::server':}

  postgresql::server::db {'moodledb':
    user     => 'fred',
    password => postgresql_password('fred', 'fredblogs'),
    grant    => 'ALL',
  }

  postgresql::server::role {'fred':
    password_hash => postgresql_password('fred', 'fredblogs'),
  }

}
