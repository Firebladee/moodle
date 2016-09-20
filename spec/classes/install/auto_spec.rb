require 'spec_helper'

describe 'moodle::install::auto' do

  it { is_expected.to have_resource_count(1)}
  it { is_expected.to have_class_count(2)}

  it { is_expected.to contain_exec('moodle_auto').with(
    :command => "/usr/bin/php admin/cli/install.php \
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
    :cwd     => '/var/www/html/moodle',
    :creates => '/var/www/html/moodle/config.php',
    :group   => 'apache',
  )}
end
