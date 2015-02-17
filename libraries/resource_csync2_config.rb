#
# Cookbook:: csync2
# Resource:: csync2_config
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
