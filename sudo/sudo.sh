#!/bin/bash

fonction_sudo(){
  # Vérifiez si l'utilisateur est root
  if [ "$EUID" -ne 0 ]; then
    echo "Ce script nécessite des droits superutilisateur. Exécutez-le avec sudo."
    exit 1
  fi

  # Demandez le nom d'utilisateur
  read -p "Veuillez entrer le nom d'utilisateur auquel vous souhaitez accorder les droits sudo: " user

  # Installation du package sudo si ce n'est pas déjà fait
  sudo apt install sudo -y

  # Ajout de l'utilisateur aux droits sudo
  sudo usermod -aG sudo $user

  echo "$user a reçu les droits sudo."
}

fonction_sudo
