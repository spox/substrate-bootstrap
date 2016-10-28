#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-precise.deb"

apt-get update
apt-get -yq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install curl

rm -f /tmp/puppet.deb
curl -o /tmp/puppet.deb -L $REPO_DEB_URL
dpkg -i /tmp/puppet.deb

apt-get -yq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet
