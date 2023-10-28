#!/bin/bash

sudo apt update
sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
reddit_success=$(ps aux | grep puma)
echo

if [[ $reddit_success == *"9292"* ]]; then
  echo "Reddit is installed successfully, listen tcp port 9292!"
else
  echo "Reddit installation failed!"
fi
