require 'beaker'
require 'beaker-rspec'
require 'beaker/i18n_helper'

RSpec.configure do |c|
  c.before :suite do
    hosts.each do |host|
      install_package(host, 'facter')
    end
  end
end
