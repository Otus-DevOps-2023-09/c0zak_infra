#!/bin/bash

sudo apt update
sudo apt install -y mongodb
sudo systemctl enable mongodb
sudo systemctl start mongodb
mongodb_success=$(systemctl status mongodb)
echo

if [[ $mongodb_success == *"active (running)"* ]]; then
  echo "MongoDB is installed successfully!"
else
  echo "MongoDB installation failed!"
fi
