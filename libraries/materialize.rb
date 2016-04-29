require 'chef/data_bag'
require 'chef/data_bag_item'

# materialize(KEY) do
# end
#
# return value of the block get stored in data_bags/materialize/keys
#
# fetch_view(KEY) < returns the latest

class Chef
  class Materialize
    def self.setup
      unless @materialize_setup
        m_bag = Chef::DataBag.new
        m_bag.name('materialize')
        m_bag.save
      end
      @materialize_setup = true
    end

    def self.resetup
      @materialize_setup = false
      setup
    end

    def materialize(key)
      dbag = Chef::DataBagItem.new
      dbag.data_bag('materialize')
      dbag.raw_data = {
        'id' => key,
        'data' => yield
      }
      dbag.save
      dbag
    end

    def retrieve(key)
      item = Chef::DataBagItem.load('materialize', key)
      item['data']
    end
  end
end

class Chef
  class Recipe
    def materialize(key, &block)
      Chef::Materialize.setup
      m = Chef::Materialize.new
      m.materialize(key, &block)
    end

    def retrieve(key)
      m = Chef::Materialize.new
      m.retrieve(key)
    end
  end
end
