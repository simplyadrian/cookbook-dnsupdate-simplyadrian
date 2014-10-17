#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: deleteprv.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'route53'

aws = Chef::EncryptedDataBagItem.load("credentials", "aws")
full_nodename = "#{node.name}-prv.#{node['dnsupdate-nativex']['int_domain']}"
route53_record "delete A record" do
  name                   full_nodename
  value                  node[:ec2][:ipaddress] 
  type                   "A"
  zone_id                node['dnsupdate-nativex']['int_zone_id']
  aws_access_key_id      aws["aws_access_key_id"]
  aws_secret_access_key  aws["aws_secret_access_key"]
  action :delete
end
