#!/bin/bash
read -p "Input new swap size (in megabyte): " makeSwap
swapoff -a
dd if=/dev/zero of=/swapfile bs=1M count=$makeSwap
mkswap /swapfile
swapon /swapfile
