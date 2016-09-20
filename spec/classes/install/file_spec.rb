require 'spec_helper'

describe 'moodle::install::file' do

  it { is_expected.to have_resource_count(5)}
  it { is_expected.to have_class_count(2)}

  it { is_expected.to contain_wget__fetch('https://download.moodle.org/download.php/direct/stable31/moodle-latest-31.tgz').with(
    :destination => '/tmp/moodle.tgz',
    :cache_dir   => '/var/cache/wget',
  )}

  it { is_expected.to contain_exec('tar -zxvf /tmp/moodle.tgz').with(
    :cwd     => '/var/www/html',
    :path    => '/bin',
    :creates => '/var/www/html/moodle/README.txt',
  )}

  it { is_expected.to contain_file('/var/www/html/moodle').with(
    :owner => 'apache',
    :group => 'apache',
  )}
end
