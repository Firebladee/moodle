require 'spec_helper'

describe 'moodle::databases' do

  it { is_expected.to have_resource_count(0)}
  it { is_expected.to have_class_count(1)}

  describe 'database => mysql' do
    let(:facts) {{
      :osfamily => 'RedHat',
      :operatingsystemrelease => '7',
    }}
    let(:params) {{
      :database => 'mysql',
      :mysql => {
        'mysql::server' => {
          'users' => {
            "${::moodle::db_user}@localhost" => {
              'ensure'        => 'present',
              'password_hash' => '*185D87D3277588C7D8ABF3D1F2D3AA89B1D73416',
            }
          },
          'grants' => {
            "${::moodle::db_user}@localhost/${::moodle::db_name}.*" => {
              'ensure'     => 'present',
              'options'    => ['GRANT'],
              'privileges' => [
                'SELECT',
                'INSERT',
                'UPDATE',
                'DELETE',
                'CREATE',
                'CREATE TEMPORARY TABLES',
                'DROP',
                'INDEX',
                'ALTER',
              ],
              'table'      => "${::moodle::db_name}.*",
              'user'       => "${::moodle::db_user}@localhost",
            }
          },
          'databases' => {
            "${::moodle::db_name}" => {
              'ensure'  => 'present',
              'charset' => 'utf8',
              'collate' => 'utf8_unicode_ci',
            }
          },
        }
      }
    }}

    it { is_expected.to have_resource_count(15)}
    it { is_expected.to have_class_count(10)}

    it { is_expected.to contain_package('epel-release').with_ensure('installed')}
    it { is_expected.to contain_package('epel-release').that_comes_before('Package[php-pear-MDB2-Driver-mysqli]')}
  end

  describe 'database => postgresql' do
    let(:facts) {{
      :osfamily => 'RedHat',
      :operatingsystem => 'Centos',
      :operatingsystemrelease => '7',
    }}
    let(:params) {{
      :database => 'postgresql',
    }}

    it { is_expected.to have_resource_count(1)}
    it { is_expected.to have_class_count(1)}

    it { is_expected.to contain_class('moodle::databases::postgresql')}
  end

end
