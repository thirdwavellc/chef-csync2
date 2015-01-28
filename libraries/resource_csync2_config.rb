require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class Csync2Config < Chef::Resource::LWRPBase
      self.resource_name = :csync2_config
      actions :create
      default_action :create

      attribute :path, kind_of: String, name_attribute: true
      attribute :hosts, kind_of: Array, required: true
      attribute :synced_dirs, kind_of: Array, required: true
      attribute :key_path, kind_of: String, required: true

      def hostnames
        hosts.map { |h| h[:name] }
      end

      def host_config(host)
        path.gsub('csync2', "csync2_#{host}")
      end
    end
  end
end
