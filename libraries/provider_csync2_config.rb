#
# Cookbook:: csync2
# Provider:: csync2_config
#
# Copyright 2014 Adam Krone <adam.krone@thirdwavellc.com>
# Copyright 2014 Thirdwave, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
            key_path: new_resource.key_path,
            lock_timeout: new_resource.lock_timeout
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
              key_path: new_resource.key_path,
              lock_timeout: new_resource.lock_timeout
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
