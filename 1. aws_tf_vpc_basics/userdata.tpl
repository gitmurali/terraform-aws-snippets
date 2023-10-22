#!/bin/bash
sudo su
apt update
apt install -y apache2
echo "Hello from AWS Cloud Demos!!!" > /var/www/html/index.html