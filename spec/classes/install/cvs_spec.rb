require 'spec_helper'

describe 'moodle::install::cvs' do

  it { is_expected.to have_resource_count(0)}
  it { is_expected.to have_class_count(1)}

end
