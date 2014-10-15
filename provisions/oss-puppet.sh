if ! [ -d /etc/puppet ]; then
  wget http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  sudo rpm -i /home/vagrant/puppetlabs-release-el-6.noarch.rpm
  sudo yum makecache
  sudo yum install -y puppet
fi
