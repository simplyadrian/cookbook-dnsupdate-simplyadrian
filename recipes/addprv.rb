#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: addprv.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe "route53"
chef_gem "aws-sdk"

ruby_block "create and update route53 dns record" do
  block do
    require 'rubygems'
    require 'aws-sdk'

    aws = Chef::EncryptedDataBagItem.load("credentials", "aws")
    full_nodename = "#{node.name}-prv.#{node['dnsupdate-nativex']['int_domain']}"

    r53 = AWS::Route53.new(
      :access_key_id => aws["aws_access_key_id"],
      :secret_access_key => aws["aws_secret_access_key"]

    response = r53.client.list_resource_record_sets(
      :hosted_zone_id => node['dnsupdate-nativex']['int_zone_id'],
      :start_record_name => full_nodename,
      :start_record_type => node['dnsupdate-nativex']['record_type'],
    )
    puts response[:resource_record_sets].map{|r| r[:name]}

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
  end
  #not_if { response[:resource_record_sets].map{|r| r[:value].exist?("#{node['ipaddress']}") }
end