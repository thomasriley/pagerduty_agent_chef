#
# Cookbook Name:: pagerduty_agent_chef
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

pagerduty_agent_install 'install' do
  action :create
end
