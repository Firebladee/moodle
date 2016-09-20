require 'spec_helper'

describe 'moodle::databases::postgresql' do
  let(:facts) {{
    :osfamily => 'RedHat',
    :operatingsystemrelease => '7',
  }}

  it { is_expected.to have_resource_count(238)}
  it { is_expected.to have_class_count(60)}

end
