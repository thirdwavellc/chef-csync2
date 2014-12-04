#
# Cookbook Name:: csync2
# Definition:: csync2_config
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#
#
#

define :csync2_config, :hosts => [], :template_cookbook => 'csync2' do
  hosts = params[:hosts]
  hostnames = hosts.map { |h| h[:name] }
  template_cookbook = params[:template_cookbook]

  template '/etc/csync2.cfg' do
    cookbook template_cookbook
    source 'csync2.cfg.erb'
    variables(
      hosts: hostnames
    )
    action :create
  end

  hostnames.each do |host|
    template "/etc/csync2_#{host}.cfg" do
      cookbook template_cookbook
      source 'csync2_node.cfg.erb'
      variables(
        group: host,
        hosts: hostnames
      )
      action :create
    end
  end

  hosts.each do |host|
    hostsfile_entry host[:ip_address] do
      hostname host[:name]
      action :create_if_missing
    end
  end
end
