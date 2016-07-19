name             'chef_base'
maintainer       'Raintank, Inc.'
maintainer_email 'cookbooks@raintank.io'
license          'Apache 2.0'
description      'Installs/Configures raintank-base'
long_description 'Installs/Configures raintank-base'
version          '0.1.8'

depends "sudo", '~> 2.7.1'
depends 'collectd-ng', '~> 2.0.0'
depends 'packagecloud', '~> 0.2.0'
depends 'logstash-forwarder', '~> 0.2.4'
depends 'ulimit2', '~> 0.2.0'
depends 'apt', '~> 2.7.0'
depends 'sysctl', '~> 0.7.0'
