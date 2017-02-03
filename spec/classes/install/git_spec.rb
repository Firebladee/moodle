require 'spec_helper'

describe 'moodle::install::git' do
  #  it { is_expected.to compile }
  it { is_expected.to have_resource_count(3)}
  it { is_expected.to have_class_count(1)}

  it { is_expected.to contain_package('git').with(
    ensure: 'latest'
  )}

  it { is_expected.to contain_file('/var/www/html/moodle').with(
    ensure: 'directory',
    mode:   '0750',
    owner:  'root',
    group:  'apache',
  )}

  it { is_expected.to contain_exec('Base clone').with(
    command: 'git clone --depth=1 -b MOODLE_31_STABLE git://git.moddle.org/moodle.git',
    cwd:     '/var/www/html',
    path:    '/usr/bin',
    timeout: '600',
    creates: '/var/www/html/moodle/README.txt',
    group:   'apache',
  )}
end
