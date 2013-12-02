class nrpe {
      package {
                "nrpe"                  :       ensure => installed;
                "nagios-plugins-nrpe"   :       ensure => installed;
		"nagios-plugins-all"	: 	ensure => installed;
      }
      file {
	"/usr/lib64/nagios/plugins/check_mem":
        mode => 0755, owner => root, group => root,
        source => "puppet:///modules/nrpe/check_mem",
	ensure => present;
	"/usr/bin/dc":
	mode => 0755, owner => root, group => root,
	source => "puppet:///modules/nrpe/dc",
	ensure => present;
           "/etc/nagios/nrpe.cfg":
           mode => 0644, owner => root, group => root,
	   content => template ("nrpe/nrpe.cfg.erb"),
	   ensure => present,
           require => Package["nrpe","nagios-plugins-nrpe", "nagios-plugins-all"],
           notify  => Service['nrpe'],
      }
      service {
              "nrpe":
              ensure => running;
      }
}
