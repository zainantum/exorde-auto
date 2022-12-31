#!/bin/bash
fallocate -l 38G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
