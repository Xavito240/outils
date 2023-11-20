#!/bin/bash

# Mise à jour du système
sudo apt update
sudo apt upgrade -y

# Installation de Docker
sudo apt install docker.io -y

# Ajout de l'utilisateur actuel au groupe Docker
sudo usermod -aG docker $USER

# Ajout du volume pour Portainer
sudo docker volume create portainer_data

# Création de Portainer sur Docker port 8080
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Pour connaître l'adresse IP de la machine
ip_address=$(hostname -I)

echo "Installation de Docker et Portainer terminée. Accès à Portainer via $ip_address au port 9443"
