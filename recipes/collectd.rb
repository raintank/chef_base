#
# Cookbook Name:: chef_base
# Recipe:: collectd
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
# Somewhat annoyingly, this needs to run *after* everything else. Hmph. Thus,
# for any recipe here that installs a full set of services (which ought to be
# pretty much all of them), this recipe needs to be at the end.

# Set the prefix here. The basic information for collectd needs to be in the
# node's environment. Without it this will blow up, which is probably for the
# best so we don't get weird metrics showing up.

# give personality-less machines some kind of personality
if !node["collectd_personality"]
  node.set["collectd_personality"] = "general"
end

node.set["collectd"]["plugins"]["write_graphite"]["config"]["Prefix"] = "collectd.#{node["collectd_environment"]}.#{node["collectd_personality"]}."

node.set["collectd"]["name"] = node.name.sub /\.raintank\.io$/, ''

if node["use_collectd"]
  include_recipe "collectd-ng::default"
  include_recipe "collectd-ng::attribute_driven"
end
if node["use_statsd"] && node["use_collectd"]
  include_recipe "chef_base::statsd"
end
