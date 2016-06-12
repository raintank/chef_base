#
# Cookbook Name:: chef_base
# Recipe:: logstash_forwarder
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

ssl = Chef::EncryptedDataBagItem.load(node['logstash-forwarder']['secrets_data_bag'], 'secrets').to_hash
cert_file = node['logstash-forwarder']['ssl_cert']
key_file = node['logstash-forwarder']['ssl_key']
file cert_file do
  owner 'root'
  group 'root'
  mode '0600'
  content Base64.decode64(ssl['certificate'])
  action :create
end
file key_file do
  owner 'root'
  group 'root'
  mode '0600'
  content Base64.decode64(ssl['key'])
  action :create
end

include_recipe "logstash-forwarder"

node['logstash-forwarder']['config']['files'].each do |k, v|
  lf_paths = []
  v["paths"].each { |x,| lf_paths << x }
  log_forward k do
    paths lf_paths
    fields v["fields"]
  end
end
