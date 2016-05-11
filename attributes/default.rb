# packagecloud repo
default[:raintank_base][:packagecloud_repo] = "raintank/raintank"

# find_* searches
default[:raintank_base][:haproxy_search] = "tags:haproxy AND chef_environment:#{node.chef_environment}"
default[:raintank_base][:nsqd_search] = "tags:nsqd AND chef_environment:#{node.chef_environment}"
default[:raintank_base][:cassandra_search] = "tags:cassandra AND chef_environment:#{node.chef_environment}"

# image building
default[:raintank_base][:is_img_build] = false

# env_load
default[:raintank_base][:env_load_url] = "https://github.com/raintank/env-load/releases/download/20151103/env-load_linux_amd64"

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
