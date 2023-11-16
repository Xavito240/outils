#!/bin/bash

# Mise à jour du système
sudo apt update
sudo apt upgrade -y

# Installation d'Apache2
sudo apt install apache2 -y

# Installation de PHP
sudo apt install php -y


# Redémarrage du service Apache2
sudo service apache2 restart

echo "Installation terminée."
