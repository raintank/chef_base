#
# Cookbook Name:: chef_base
# Library: helpers
#
# Copyright (C) 2015 Raintank, Inc.
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

# This is rather GCE specific right now.

module RaintankBase
  module Helpers
    def find_haproxy
      return nil? unless node.attribute?('gce')
      zone = node['gce']['instance']['zone']
      haproxy = search("node", node['chef_base']['haproxy_search'])
      h = haproxy.select { |h| h['gce']['instance']['zone'] == zone }.first
      return (h) ? h.ipaddress : nil
    end
    def find_nsqd(port=4150)
      if node['chef_base']['k8_env']
	find_nsqd_k8(port)
      else
	find_nsqd_std(port)
      end
    end
    def find_nsqd_std(port=4150)
      if Chef::Config[:solo] || node['chef_base']['standalone']
	return [ "127.0.0.1:#{port}" ]
      end
      # eventually we'll want to limit this search to only the same zone
      nsqds = search("node", node['chef_base']['nsqd_search'])
      return nsqds.map { |n| "#{n.fqdn}:#{port}" }
    end
    def find_nsqd_k8(port=4150)
      # TODOs: some kind of way to look up the kubernetes clusters without
      # having to add it to the environment or node data would be nice.
      # Also: verify SSL instead of using VERIFY_NONE and having to provide a
      # user/password combo.
      require 'kubeclient'
      addrs = []
      node['chef_base']['k8_masters'].each do |k|
	client = Kubeclient::Client.new "https://#{k['addr']}/api/", "v1", ssl_options: { verify_ssl: OpenSSL::SSL::VERIFY_NONE }, auth_options: { password: "#{k['password']}", username: "#{k['username']}" }
	res = JSON.parse(client.rest_client["namespaces/#{node['chef_base']['k8_namespace']}/endpoints/nsqd"].get())
	addrs += res['subsets'].map { |x| x["addresses"].map { |y| y["ip"] } }.flatten
      end
      return addrs.map { |n| "#{n}:#{port}" }
    end
    def find_cassandras
      if Chef::Config[:solo]
         return [ "127.0.0.1" ]
      end
      cassandras = search("node", node['chef_base']['cassandra_search'])
      return cassandras.map { |c| c.fqdn }
    end
  end
end

Chef::Recipe.send(:include, ::RaintankBase::Helpers)
Chef::Resource.send(:include, ::RaintankBase::Helpers)
Chef::Provider.send(:include, ::RaintankBase::Helpers)
