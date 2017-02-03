require 'spec_helper'

describe 'moodle::databases' do
  it { is_expected.to have_resource_count(0)}
  it { is_expected.to have_class_count(1)}

  describe 'database => mysql' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        let(:params) {{
          database: 'mysql',
          mysql: {
            'mysql::server' => {
              'users' => {
                'fred@localhost' => {
                  'ensure'        => 'present',
                  'password_hash' => '*185D87D3277588C7D8ABF3D1F2D3AA89B1D73416',
                }
              },
              'grants' => {
                'fred@localhost/moodledb.*' => {
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
                  'table'      => 'moodledb.*',
                  'user'       => 'fred@localhost',
                }
              },
              'databases' => {
                'moodledb' => {
                  'ensure'  => 'present',
                  'charset' => 'utf8',
                  'collate' => 'utf8_unicode_ci',
                }
              },
            }
          }
        }}

        it { is_expected.to contain_package('epel-release').with_ensure('installed')}
        it { is_expected.to contain_package('epel-release').that_comes_before('Package[php-pear-MDB2-Driver-mysqli]')}

        case facts[:operatingsystem]
        when 'Ubuntu'
          case facts[:operatingsystemrelease]
          when '14.04'
            it { is_expected.to have_resource_count(16)}
          end
        else
          it { is_expected.to have_resource_count(15)}
          it { is_expected.to have_class_count(10)}
        end
      end
    end
  end

  describe 'database => postgresql' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        let(:params) {{
          database: 'postgresql',
        }}

        case facts[:osfamily]
        when 'RedHat'
          case facts[:operatingsystemrelease]
          when '6'
            it { is_expected.to have_resource_count(68) }
          when '7'
            it { is_expected.to have resource_count(65) }
          end
        else
          it { is_expected.to have_resource_count(63) }
        end
        it { is_expected.to have_class_count(12) }

        it { is_expected.to contain_class('moodle::databases::postgresql') }
      end
    end
  end
end
