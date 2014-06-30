require 'rspec'
require 'chefspec'
require 'chefspec/server'

TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), ".."))
LIBDIR = File.expand_path(File.join(TOPDIR, "libraries"))
$: << File.expand_path(File.dirname(__FILE__))
$: << LIBDIR

RSpec.configure do |c|
end
