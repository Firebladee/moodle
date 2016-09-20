require 'spec_helper'

describe 'moodle::install' do

  it { is_expected.to have_resource_count(2)}
  it { is_expected.to have_class_count(1)}

  describe 'install => git' do
    let(:params) {{
      :install => 'git'
    }}

    it { is_expected.to contain_class('moodle::install::git')}
  end

  describe 'install => file' do
    let(:params) {{
      :install => 'file'
    }}

    it { is_expected.to contain_class('moodle::install::file')}
  end

  describe 'install => web' do
    let(:params) {{
      :install => 'web'
    }}

    it { is_expected.to contain_class('moodle::install::web')}
  end

  describe 'install => cvs' do
    let(:params) {{
      :install => 'cvs'
    }}

    it { is_expected.to contain_class('moodle::install::cvs')}
  end

  describe 'install => auto' do
    let(:params) {{
      :install => 'auto'
    }}

    it { is_expected.to contain_class('moodle::install::auto')}
  end

  it { is_expected.to contain_notify('Build type  not yet known')}

  it { is_expected.to contain_file('/opt/moodle').with(
    :ensure => 'directory',
    :mode   => '0755',
    :owner  => 'apache',
    :group  => 'apache',
  )}
end
