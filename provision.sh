#!/bin/sh

# Paranoia mode
set -e
set -u

# Je récupere le hostname du serveur
HOSTNAME="$(hostname)"

export DEBIAN_FRONTEND=noninteractive

# Mettre à jour le catalogue des paquets debian
apt-get update --allow-releaseinfo-change

# Installer les prérequis pour puppet
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    git \
    curl \
    wget \
    vim \
    gnupg2 \
    software-properties-common

# J'utilise /etc/hosts pour associer les IP aux noms de domaines
# sur mon réseau local, sur chacune des machines
sed -i \
	-e '/^## BEGIN PROVISION/,/^## END PROVISION/d' \
	/etc/hosts
cat >> /etc/hosts <<MARK
## BEGIN PROVISION
192.168.50.250      control
192.168.50.10       revproxy
192.168.50.20       app1
192.168.50.30       app2
192.168.50.40       db
192.168.50.50       cache
## END PROVISION
MARK

# Désactive l'update automatique du cache apt + indexation (lourd en CPU)
cat >> /etc/apt/apt.conf.d/99periodic-disable <<MARK
APT::Periodic::Enable "0";
MARK


echo "SUCCESS."