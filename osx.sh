#!/bin/sh

gem install json_pure -v '~> 1.0' --no-ri --no-rdoc
gem install puppet -v '~> 3.0' --no-ri --no-rdoc

mkdir -p /vagrant/substrate-assets
/vagrant/substrate/run.sh /vagrant/substrate-assets