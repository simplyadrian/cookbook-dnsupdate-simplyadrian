#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: addprv.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

gem_package "aws-sdk-v1" do
	  action :install
end

ruby_block "create and update route53 dns record" do
  block do
    require 'rubygems'
    require 'aws-sdk-v1'

    aws = Chef::EncryptedDataBagItem.load("credentials", "aws")
    full_nodename = "#{node.name}-prv.#{node['dnsupdate-nativex']['int_domain']}"
    Chef::Log.info("The FQDN of this node is: #{full_nodename}.")

    r53 = AWS::Route53.new(
      :access_key_id => aws["aws_access_key_id"],
      :secret_access_key => aws["aws_secret_access_key"]
    )
    
    response = r53.client.list_resource_record_sets(
      :hosted_zone_id => node['dnsupdate-nativex']['int_zone_id'],
      :start_record_name => full_nodename, 
      :start_record_type => node['dnsupdate-nativex']['record_type'],
      :max_items => 1
    )
    puts response[:resource_record_sets]
    Chef::Log.info("r53 list response: #{response}.")

    change1 = {
      :action => 'UPSERT',
      :resource_record_set => {
        :name => full_nodename,
        :type => node['dnsupdate-nativex']['record_type'],
        :ttl => 60,
      :resource_records => [{:value => node['ipaddress']}]
    }}

    r53.client.change_resource_record_sets({
      :hosted_zone_id => node['dnsupdate-nativex']['int_zone_id'],
      :change_batch => {
        :changes => [change1]
      }
    })
    Chef::Log.info("Creating or updating the DNS record '#{full_nodename}' to the value of '#{node['ipaddress']}' ")
  end
end
