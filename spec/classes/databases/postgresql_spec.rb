require 'spec_helper'

describe 'moodle::databases::postgresql' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
        case facts[:operatingsystem]
        when 'CentOS'
          case facts[:operatingsystemrelease]
          when '7'
            it { is_expected.to have_resource_count(68)}
          when '6'
            it { is_expected.to have_resource_count(68)}
          end
          it { is_expected.to have_class_count(11)}
        end
      end

      it { is_expected.to contain_class('postgresql::server')}
      it { is_expected.to contain_postgresql__server__db('moodledb').with(
        user:     'fred',
        password: 'md5df557e80bf2053aaaf9ce2d85dbb4f05',
        grant:    'ALL',
      )}
      it { is_expected.to contain_postgresql__server__role('fred').with(
        password_hash: 'md5df557e80bf2053aaaf9ce2d85dbb4f05',
      )}
    end
  end
end
