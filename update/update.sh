#!/bin/bash

fonction_update() {
  sudo apt update
  sudo apt upgrade -y

  echo "Mise à jour effectuée."
}

fonction_update
