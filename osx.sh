#!/bin/sh

gem install json_pure -v '~> 1.0' --no-ri --no-rdoc
gem install puppet -v '~> 3.0' --no-ri --no-rdoc
TRAVIS=1 su vagrant -l -c 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install")'
mkdir -p /vagrant/substrate-assets
/vagrant/substrate/run.sh /vagrant/substrate-assets
