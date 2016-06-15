#
# Cookbook Name:: chef_base
# Recipe:: apt_clean
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

# Add `apt-get autoremove -y` to run as a cron, to avoid having ridiculous
# amounts of old packages (particularly old kernels & kernel headers) building
# up over time.

cron "apt-get_autoremove" do
  time :weekly
  command "/usr/bin/apt-get autoremove -y"
end
