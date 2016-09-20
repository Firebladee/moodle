require 'spec_helper'

describe 'moodle' do
  let(:facts) {{
    :osfamily => 'RedHat',
    :operatingsystemrelease => '7',
  }}

  it { is_expected.to have_resource_count(238)}
  it { is_expected.to have_class_count(60)}

  it { is_expected.to contain_class('moodle::params')}

  it { is_expected.to contain_class('moodle::install').with(
    :install => 'file',
  )}

  it { is_expected.to contain_class('moodle::web').with(
    :web => 'apache',
  )}

  it { is_expected.to contain_class('moodle::databases').with(
    :database => 'mysql',
  )}

  it { is_expected.to contain_class('moodle::install::auto')}
end
