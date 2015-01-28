require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class Csync2Config < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do
        template new_resource.path do
          cookbook 'csync2'
          source 'csync2.cfg.erb'
          variables(
            hosts: new_resource.hostnames,
            synced_dirs: new_resource.synced_dirs,
            key_path: new_resource.key_path
          )
          action :create
        end

        new_resource.hostnames.each do |host|
          template new_resource.host_config(host) do
            cookbook 'csync2'
            source 'csync2_node.cfg.erb'
            variables(
              group: host,
              hosts: new_resource.hostnames,
              synced_dirs: new_resource.synced_dirs,
              key_path: new_resource.key_path
            )
            action :create
          end
        end

        new_resource.hosts.each do |host|
          hostsfile_entry host[:ip_address] do
            hostname host[:name]
            action :create_if_missing
          end
        end
      end
    end
  end
end
