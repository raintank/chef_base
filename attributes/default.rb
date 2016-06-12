# packagecloud repo
default[:chef_base][:packagecloud_repo] = "raintank/raintank"

# find_* searches
default[:chef_base][:haproxy_search] = "tags:haproxy AND chef_environment:#{node.chef_environment}"
default[:chef_base][:nsqd_search] = "tags:nsqd AND chef_environment:#{node.chef_environment}"
default[:chef_base][:cassandra_search] = "tags:cassandra AND chef_environment:#{node.chef_environment}"

# image building
default[:chef_base][:is_img_build] = false

# env_load
default[:chef_base][:env_load_url] = "https://github.com/raintank/env-load/releases/download/20151103/env-load_linux_amd64"

# logstash-forwarder
default['logstash-forwarder']['secrets_data_bag'] = 'elkstack'
default['logstash-forwarder']['enable_ssl'] = true
default['logstash-forwarder']['ssl_ca'] = '/etc/lumberjack.crt'
default['logstash-forwarder']['ssl_cert'] = '/etc/lumberjack.crt'
default['logstash-forwarder']['ssl_key'] = '/etc/lumberjack.key'

# ulimit
default['ulimit']['params']['@sysadmin']['nofile']['hard'] = 900000
default['ulimit']['params']['@sysadmin']['nofile']['soft'] = 900000

# sudo
default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['groups'] = [ 'sysadmin' ]

# statsd
default[:chef_base][:statsd][:listen_addr] = ':8125'
default[:chef_base][:statsd][:admin_addr] = ':8126'
default[:chef_base][:statsd][:profile_addr] = ':6060'
default[:chef_base][:statsd][:graphite_addr] = '127.0.0.1:2003'
default[:chef_base][:statsd][:flush_interval] = 60
default[:chef_base][:statsd][:flush_rates] = false
default[:chef_base][:statsd][:flush_counts] = true
default[:chef_base][:statsd][:legacy_namespace] = false
default[:chef_base][:statsd][:processes] = 4
default[:chef_base][:statsd][:instance] = '${HOST}'
default[:chef_base][:statsd][:prefix_rates] = 'stats.'
default[:chef_base][:statsd][:prefix_timers] = 'stats.timers.'
default[:chef_base][:statsd][:prefix_gauges] = 'stats.gauges.'
default[:chef_base][:statsd][:prefix_counters] = 'stats.counters.'
default[:chef_base][:statsd][:percentile_thresholds] = '90,75'
default[:chef_base][:statsd][:max_timers_per_s] = 10000
default[:chef_base][:statsd][:prof][:path] = "/tmp"
default[:chef_base][:statsd][:prof][:cpu_freq] = "1s"
default[:chef_base][:statsd][:prof][:cpu_min_diff] = "60m"
default[:chef_base][:statsd][:prof][:cpu_dur] = "5s"
default[:chef_base][:statsd][:prof][:cpu_thresh] = 50

# rc.local
default[:chef_base][:rc_local_items] = [ "/usr/bin/chef-client" ]
