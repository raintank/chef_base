#
# Cookbook Name:: chef_base
# Recipe:: users
#
# Copyright (C) 2015 Raintank Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# configure users on this system.

# Down the road, this should use chef-vault rather than encrypted databags.

users = data_bag(:users).map do |u|
  user = Chef::EncryptedDataBagItem.load(:users, u).to_hash
  user['username'] ||= user['id']
  user['shell'] ||= '/bin/bash'
  user['home'] ||= "/home/#{user['username']}"
  user['password'] ||= '*'
  user
end

sysadmins = []
users.each do |u|
  if u['action'] && u['action'].to_sym == :remove
    user u['username'] do
      action :remove
    end
    next
  end
  user u['username'] do
    shell u['shell']
    password u['password']
    supports :manage_home => true
    home u['home']
    action :create
  end
  
  directory "#{u['home']}" do
    owner u['username']
    group u['username']
    mode "0755"
  end

  directory "#{u['home']}/.ssh" do
    owner u['username']
    group u['username']
    mode "0700"
  end
  if u['keys']
    template "#{u['home']}/.ssh/authorized_keys" do
      source "authorized_keys.erb"
      owner u['username']
      group u['username']
      mode "0600"
      variables :keys => u['keys']
    end
  end
  if u['sysadmin']
    sysadmins << u['username']
  end
end

group 'sysadmin' do
  members sysadmins
end

include_recipe "sudo"

