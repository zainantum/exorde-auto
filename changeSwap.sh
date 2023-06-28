#!/bin/bash
read -p "Create swap? y or n " makeSwap
swapoff -a
dd if=/dev/zero of=/swapfile bs=1M count=$makeSwap
mkswap /swapfile
swapon /swapfile
