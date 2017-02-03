require 'spec_helper'

describe 'moodle::web' do
  it { is_expected.to have_resource_count(0)}
  it { is_expected.to have_class_count(1)}

  describe 'web => apache' do
    let(:facts) {{
      osfamily: 'RedHat',
      operatingsystemrelease: '7',
    }}
    let(:params) {{
      web: 'apache'
    }}

    it { is_expected.to contain_class('moodle::web::apache')}
  end
end
