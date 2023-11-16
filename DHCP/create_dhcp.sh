#!/bin/bash

# Vérifie si l'utilisateur est root
if [ "$EUID" -ne 0 ]; then
  echo "Ce script nécessite des droits superutilisateur. Exécutez-le avec sudo."
  exit 1
fi

# Mise à jour des paquets
sudo apt update

# Installation du serveur DHCP
sudo apt install isc-dhcp-server -y

# Demande des informations DHCP à l'utilisateur
read -p "Veuillez entrer le réseau DHCP (par exemple, 10.192.10.0): " dhcp_network
read -p "Veuillez entrer le masque de sous-réseau (par exemple, 255.255.255.0): " dhcp_netmask
read -p "Veuillez entrer la plage d'adresses IP disponibles (par exemple, 10.192.10.10 10.192.10.100): " dhcp_range
read -p "Veuillez entrer l'adresse IP du routeur par défaut : " dhcp_router
read -p "Veuillez entrer les serveurs DNS (séparés par des virgules, par exemple, 8.8.8.8, 8.8.4.4) : " dhcp_dns
read -p "Veuillez entrer le nom de domaine (par exemple, example.com) : " dhcp_domain

# Configuration du serveur DHCP
sudo tee -a /etc/dhcp/dhcpd.conf <<EOF
subnet $dhcp_network netmask $dhcp_netmask {
  range $dhcp_range;
  option routers $dhcp_router;
  option domain-name-servers $dhcp_dns;
  option domain-name "$dhcp_domain";
}
EOF

# Démarrez le service DHCP
sudo systemctl start isc-dhcp-server

# Activez le démarrage automatique du service au démarrage du système
sudo systemctl enable isc-dhcp-server

# Vérifiez l'état du service
sudo systemctl status isc-dhcp-server
