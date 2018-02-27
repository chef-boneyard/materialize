require 'spec_helper'
require 'materialize'

describe 'Chef::Materialize' do
  let(:m) { Chef::Materialize.new }
  let(:key) { 'ssh_known_hosts' }
  let(:data) do
    {
      'node1' => 'karma',
      'node2' => 'is dope',
    }
  end

  before(:each) do
    ChefSpec::Server.create_client('me', admin: true)
    Chef::Config[:client_key]      = ChefSpec::Server.client_key
    Chef::Config[:client_name]     = 'chefspec'
    Chef::Config[:node_name]       = 'chefspec'
    Chef::Config[:file_cache_path] = Dir.mktmpdir
    Chef::Config[:solo]            = false
  end

  describe 'self.setup' do
    it 'sets up the databag' do
      Chef::Materialize.resetup
      expect(Chef::DataBag.load('materialize')).to be_a_kind_of(Hash)
    end
  end

  describe 'materialize' do
    before(:each) do
      Chef::Materialize.resetup
    end

    it 'stores the blocks return value in a data bag' do
      m.materialize(key) do
        data
      end

      bag = Chef::DataBagItem.load('materialize', key)

      expect(bag.data_bag).to eql 'materialize'
      expect(bag.raw_data).to eql('id' => key, 'data' => data)
    end
  end

  describe 'retrieve' do
    before(:each) do
      ChefSpec::Server.create_data_bag('materialize', key => { 'data' => data })
    end

    it 'returns the data for the key' do
      expect(m.retrieve(key)).to eql(data)
    end
  end
end
