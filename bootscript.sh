#!/bin/bash

# disabling firewall

sudo systemctl stop ufw
sudo systemctl disable ufw

# Installing Docker

sudo apt update -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt-cache policy docker-ce

sudo apt install docker-ce=5:24.0.0-1~ubuntu.20.04~focal -y

sudo systemctl enable docker

sudo usermod -aG docker vagrant

# updating sysctl settings

echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf >/dev/null

sudo sysctl -p

# Disabling swap 

sudo swapoff -a
