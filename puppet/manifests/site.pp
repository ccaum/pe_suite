node default {
  class { 'postgresql::globals':
      manage_package_repo => true,
      version             => '9.2',
  } ->
  class { 'postgresql::server':
    ip_mask_allow_all_users => '0.0.0.0/0',
    listen_addresses        => '*',
    service_name            => 'postgresql-9.2',
  }

  postgresql::server::db { 'puppetdb':
    user     => 'puppet',
    password => postgresql_password('puppet', 'puppet'),
  }

  postgresql::server::db { 'console':
    user     => 'puppet',
    password => postgresql_password('puppet', 'puppet'),
  }

  postgresql::server::db { 'rbac':
    user     => 'puppet',
    password => postgresql_password('puppet', 'puppet'),
  }

  postgresql::server::db { 'nc':
    user     => 'puppet',
    password => postgresql_password('puppet', 'puppet'),
  }

  postgresql::server::db { 'activity':
    user     => 'puppet',
    password => postgresql_password('puppet', 'puppet'),
  }
}
