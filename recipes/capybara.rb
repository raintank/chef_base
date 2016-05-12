#
# Cookbook Name:: chef_base
# Recipe:: capybara
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

# For running tests.

package "xvfb"
package "qt4-qmake"
package "libqtwebkit-dev"
package "g++"

%w(gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x).each do |pkg|
  package pkg
end
