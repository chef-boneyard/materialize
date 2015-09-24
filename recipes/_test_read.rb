known_hosts_data = retrieve('ssh_known_hosts')

file '/tmp/known_hosts' do
  content known_hosts_data.join("\n")
end
