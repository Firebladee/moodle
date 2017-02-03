require 'puppetlabs_spec_helper/module_spec_helper'
require 'coveralls'
require 'rspec-puppet-facts'

include RspecPuppetFacts

RSpec.configure do |config|
  config.formatter = :documentation
end

Coveralls.wear!
