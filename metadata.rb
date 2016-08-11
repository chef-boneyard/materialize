name             'materialize'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache 2.0'
description      'Implements a materialized view pattern for searches'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

source_url 'https://github.com/chef-cookbooks/materialize' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/materialize/issues' if respond_to?(:issues_url)

chef_version '>= 11' if respond_to?(:chef_version)
