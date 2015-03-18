#
# Cookbook Name:: dnsupdate-nativex
# Recipe:: default
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

gem_package "nokogiri" do
  action :install
  version "1.6.1"
end

include_recipe "dnsupdate-nativex::addprv"
