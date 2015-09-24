require 'rspec'
require 'chefspec'
require 'chefspec/server'

TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))
LIBDIR = File.expand_path(File.join(TOPDIR, 'libraries'))
$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << LIBDIR

RSpec.configure do |_c|
end
