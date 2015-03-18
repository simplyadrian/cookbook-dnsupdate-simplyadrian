#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: default
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

if platform_family?('debian')
  chef_gem "nokogiri" do
    action :install
    version "1.6.1"
  end
end

include_recipe "dnsupdate-nativex::addprv"
