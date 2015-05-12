#
# Cookbook Name:: dnsupdate-simplyadrian
# Recipe:: default
#
# Copyright 2014, simplyadrian
#
# All rights reserved - Do Not Redistribute
#

chef_gem "nokogiri" do
  action :install
  version "1.6.1"
end

include_recipe "dnsupdate-simplyadrian::addprv"
