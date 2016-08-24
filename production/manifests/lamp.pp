#execute 'yum update'

exec { 'yum-update':                    # exec resource named 'yum-update'
  command => '/usr/bin/yum -y update'  # command this resource will run
}

# install apache package
package { 'httpd':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => 'installed',
}

# ensure apache service is running
service { 'httpd':
  ensure => 'running',
}

# install mysql-server package
package { 'mariadb-server':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => 'installed',
}

# ensure mysql service is running
service { 'mariadb':
  ensure => 'running',
}

# install php5 package
package { 'php':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => 'installed',
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => 'file',
  content => '<?php  phpinfo(); ?>',    # phpinfo code
  require => Package['httpd'],        # require 'apache2' package before creating
}
