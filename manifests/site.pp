node default {
        include nrpe
}
node 'nova-mm-235' {
	include nrpe,nova
}
