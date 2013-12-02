class nova {
    package {
        "nova":
        name => "openstack-nova",
        ensure => installed;
        "avahi":
        name => "avahi",
        ensure => installed;
    }
    service {
        "compute":
        name => "openstack-nova-compute",
        ensure => running;
        "volume":
        name => "openstack-nova-volume",
        ensure => running;
        "iscsi":
        name => "tgtd",
        ensure => running;
        "kvm":
        name => "libvirtd",
        ensure => running;
        "messagebus": 
        ensure => running;
        "avahi-daemon":
        ensure => running;       
    }
    file {
        "/etc/nova/policy.json":
        source => "puppet:///modules/nova/policy.json";
        "/etc/nova/api-paste.ini":
        source => "puppet:///modules/nova/api-paste.ini";
        "/etc/nova/libvirt.xml.template":
        source => "puppet:///modules/nova/libvirt.xml.template";
        "/etc/nova/nova.conf":
        content => template("nova/nova.conf.erb"),
        require => Package["nova"],
        notify => Service["compute","volume"];
        "/var/nova/instances":
        mode => 0755, owner => nova, group => nova,
        ensure => directory;
    }
}
