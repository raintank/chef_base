#
# Cookbook Name:: chef_base
# Recipe:: hostname
#
# Copyright (C) 2016 Raintank, Inc.
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

file "/etc/hostname" do
  owner "root"
  group "root"
  content node.hostname
  action :create
  notifies :run, "bash[update_hostname]", :delayed
end

bash "update_hostname" do
  cwd "/tmp"
  code "hostname -F /etc/hostname"
  action :nothing
end
