#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: addpub.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'route53'

aws = Chef::EncryptedDataBagItem.load("credentials", "aws")
full_nodename = "#{node.name}-pub.#{node['dnsupdate-nativex']['ext_domain']}"
route53_record "create A record" do
  name                   full_nodename
  value                  node[:ec2][:public_ipv4] 
  type                   "A"
  zone_id                node['dnsupdate-nativex']['ext_zone_id']
  aws_access_key_id      aws["aws_access_key_id"]
  aws_secret_access_key  aws["aws_secret_access_key"]
  ttl                    60
  overwrite		 true
  action :create
end
