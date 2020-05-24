#!/bin/sh

# 1. update os
sudo apt update && sudo apt upgrade -y

# 2. install mongodb
sudo apt-get install -y mongodb
systemctl --no-pager -l status mongodb
mongod --version

# 3. install node
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v

# 4. start server
#cd Books/
#npm install
#sudo node server.js 

