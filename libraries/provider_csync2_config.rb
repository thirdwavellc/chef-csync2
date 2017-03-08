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
        new_resource.synced_dirs.each do |dir|
          template new_resource.synced_dir_config_path(dir) do
            cookbook 'csync2'
            source 'csync2_dir.cfg.erb'
            variables(
              group: dir[:name],
              hosts: new_resource.hostnames,
              synced_dir: dir[:path],
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
