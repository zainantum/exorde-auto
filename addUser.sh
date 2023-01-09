#!/bin/bash
echo -e "Add new user"
echo '================================================='
read -p "Enter new username: " username
read -p "Enter new password: " password
echo -e "Processing...."
echo '================================================='
adduser --gecos "" --disabled-password $username
yes $password | passwd $username
usermod -aG sudo $username
sleep 1
sed -i -e "s|^PasswordAuthentication no|PasswordAuthentication yes|" /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo '================================================='
echo -e "Successfull. You can try to login using new user now"
