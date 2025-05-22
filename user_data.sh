#!/bin/bash
# This file is currently commented out as Ansible is being used for configuration
# Uncomment if needed for direct cloud-init configuration

# # Update system packages
# apt-get update -y
# apt-get upgrade -y
# 
# # Install some basic utilities
# apt-get install -y \
#     curl \
#     wget \
#     vim \
#     git \
#     htop \
#     fail2ban \
#     unattended-upgrades
# 
# # Configure automatic security updates
# cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
# APT::Periodic::Update-Package-Lists "1";
# APT::Periodic::Unattended-Upgrade "1";
# APT::Periodic::AutocleanInterval "7";
# EOF
# 
# # Set up swap space if none exists
# if [ ! -f /swapfile ]; then
#     fallocate -l 2G /swapfile
#     chmod 600 /swapfile
#     mkswap /swapfile
#     swapon /swapfile
#     echo '/swapfile none swap sw 0 0' >> /etc/fstab
# fi
# 
# # Setup basic firewall with UFW
# apt-get install -y ufw
# ufw default deny incoming
# ufw default allow outgoing
# ufw allow ssh
# ufw allow http
# ufw allow https
# ufw --force enable
# 
# # Set timezone
# timedatectl set-timezone UTC
# 
# # System hardening
# sed -i 's/^PermitRootLogin yes/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
# sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
# systemctl restart sshd
# 
# # Optionally install Docker
# # apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
# # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# # echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
# # apt-get update -y
# # apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# 
# echo "Server initialization completed!" > /root/init_complete.log 