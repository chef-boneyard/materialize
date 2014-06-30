materialize('ssh_known_hosts') do
  data = []
  search(:node, 'fqdn:* AND ipaddress:* AND keys_ssh_host_rsa_public:* AND host_dsa_public:*') do |n|
    data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_rsa_public']}"
    data << "#{n['fqdn']},#{n['ipaddress']} #{n['keys']['ssh']['host_dsa_public']}"
  end
  data
end
