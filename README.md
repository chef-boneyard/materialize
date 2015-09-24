# materialize

[![Build Status](https://travis-ci.org/chef-cookbooks/materialize.svg?branch=master)](http://travis-ci.org/chef-cookbooks/materialize)

This cookbook provides a way to materialize a data-structure into a Chef databag, and then easily
retrieve it on another node. This can be useful if, for example, you want to amortize the cost of
a large search one time, rather than repeat it on a thousand nodes.

## Usage

1. Make this cookbook a dependency of the cookbook that will use either the read or write functions.
2. Call the functions.
3. There is no step three.

## Write

Lets say you have a cookbook with a big search, to build something like ssh_known_hosts. In a typical
Chef cookbook, you might write the following:

```ruby
data = []
search(:node, 'fqdn:* AND ipaddress:* AND keys_ssh_host_rsa_public:* AND host_dsa_public:*') do |n|
  data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_rsa_public']}"
  data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_dsa_public']}"
end
data = data.sort
```

To build up your data for the ssh_known_hosts file. This woudl result in a global search across
every node in your infrastructure on every convergence, which, as you get larger, will be pretty
brutal.

With this cookbook, you would do the following instead:

```ruby
materialize('ssh_known_hosts') do
  data = []
  search(:node, 'fqdn:* AND ipaddress:* AND keys_ssh_host_rsa_public:* AND host_dsa_public:*') do |n|
    data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_rsa_public']}"
    data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_dsa_public']}"
  end
  data.sort
end
```

This would take the output of your search query and store it in a data bag called 'materialize', with
the key of 'ssh_known_hosts'. You want to make sure this happens _on one node only_, rather than on
every node. (For example, move it to another recipe, or have a node attribute, or check on node name - 
whatever. Just don't run it every time.)

## Read

To get your value back out, you would do something like this:

```ruby
begin
  ssh_known_hosts_content = retrieve('ssh_known_hosts').join("\n")
rescue
  # Protect against empty cache
  ssh_known_hosts_content = IO.read('/etc/ssh/ssh_known_hosts')
end

file "/etc/ssh/ssh_known_hosts" do
  owner "root"
  mode "0644"
  content ssh_known_hosts_content
end
```

## Development

This cookbook comes with unit tests! 

```bash
$ bundle install
$ bundle exec rspec
```

And with functional tests!

```bash
$ kitchen test default
```

License & Authors
-----------------

**Author:** Cookbook Engineering Team (<cookbooks@chef.io>)

**Copyright:** 2011-2015, Chef Software, Inc.
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
