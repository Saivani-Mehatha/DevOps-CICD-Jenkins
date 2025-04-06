#!/bin/bash

echo "📦 Installing Java 11..."
sudo apt update
sudo apt install openjdk-17-jdk -y

echo "🧹 Removing any existing Jenkins installation..."
sudo apt-get remove --purge jenkins -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/jenkins
sudo rm -rf /usr/share/jenkins
sudo rm -f /etc/apt/sources.list.d/jenkins.list

echo "🔐 Adding Jenkins LTS repo key..."
sudo mkdir -p /usr/share/keyrings
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "📁 Adding Jenkins LTS repo to sources list..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating package index..."
sudo apt-get update

echo "⚙️ Installing Jenkins LTS..."
sudo apt-get install jenkins -y

echo "🚀 Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "✅ Jenkins LTS installed successfully and running!"
