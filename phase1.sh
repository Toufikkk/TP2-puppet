
#!/bin/sh

# Je récupere le hostname du serveur
HOSTNAME="$(hostname)"

# Si la machine s'appelle control
if [ "$HOSTNAME" = "control" ]; then
	# J'installe puppet dessus
	apt-get install -y \
		puppet-master
else
	# J'installe puppet dessus
	apt-get install -y \
		puppet

	systemctl restart puppet

	cat > /etc/puppet/puppet.conf <<-MARK
    [main]
    ssldir = /var/lib/puppet/ssl
    certname = $HOSTNAME
    server = control
    environment = production
    [master]
    vardir = /var/lib/puppet
    cadir = /var/lib/puppet/ssl/ca
    dns_alt_names = puppet
	MARK

	puppet agent --test
fi