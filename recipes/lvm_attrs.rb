#
# Cookbook Name:: chef_base
# Recipe:: lvm_attrs
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

# The lvm gem doesn't yet support the version of lvm2 in xenial. Plunking the
# right files in works though, so we do that here.

# grrrrr
gem_env = `#{Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')} environment`.split(/\n/)
gem_env.find{ |x| x =~ /- INSTALLATION DIRECTORY: (.*?)$/ } =~ /: (.*?)$/
gem_dir = $1
gem_versions = `#{Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')} list --local`.split(/\n/)
gem_versions.find { |x| x =~ /di-ruby-lvm-attrib/ } =~ / \((.*?)\)/
lvm_version = $1

if !lvm_version
  Chef::Application.fatal!("di-ruby-lvm-attrib gem is not installed")
end

lvm_attr_dir = "#{gem_dir}/gems/di-ruby-lvm-attrib-#{lvm_version}/lib/lvm/attributes/2.02.133(2)"

directory lvm_attr_dir do
  action :create
end

%w[lvs.yaml lvsseg.yaml pvs.yaml pvsseg.yaml vgs.yaml].each do |f|
  cookbook_file "#{lvm_attr_dir}/#{f}" do
    source f
    owner "root"
    group "root"
    action :create
  end
end
