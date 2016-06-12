#
# Cookbook Name:: chef_base
# Recipe:: raintank_apt
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

include_recipe "apt"
bash "update_raintank_apt" do
  cwd "/tmp"
  code <<-EOH
    apt-get update -o Dir::Etc::sourcelist="sources.list.d/raintank_raintank_.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0" || true
    EOH
end
