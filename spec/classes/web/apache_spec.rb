require 'spec_helper'

describe 'moodle::web::apache' do
  let(:facts) {{
    :osfamily => 'RedHat',
    :operatingsystemrelease => '7',
  }}

  it { is_expected.to have_resource_count(217)}
  it { is_expected.to have_class_count(43)}

  it { is_expected.to contain_class('apache')}
  it { is_expected.to contain_apache__vhost('moodle').with(
    :port    => '80',
    :docroot => '/var/www/html/moodle',
    :aliases => {
      'alias' => '/mymoodle',
      'path'  => '/var/www/html/moodle', }
  )}

  it { is_expected.to contain_class('apache::mod::php')}

  it { is_expected.to contain_class('php').with(
    :extensions =>
      {
        'gd'               => {},
        'mbstring'         => {},
        'xmlrpc'           => {},
        'soap'             => {},
        'intl'             => {},
        'pecl-zendopcache' => {},
      }
  )}

  # Below is to remove these from the 'Untouched resources' list.
  it { is_expected.to contain_php__extension('gd')}
  it { is_expected.to contain_php__extension('intl')}
  it { is_expected.to contain_php__extension('mbstring')}
  it { is_expected.to contain_php__extension('pecl-zendopcache')}
  it { is_expected.to contain_php__extension('soap')}
  it { is_expected.to contain_php__extension('xmlrpc')}
  it { is_expected.to contain_php__fpm__pool('www')}
  it { is_expected.to contain_apache__listen('80')}
end
