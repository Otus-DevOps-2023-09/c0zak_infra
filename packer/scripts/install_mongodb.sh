#!/bin/bash

until apt install -y mongodb 2>&1; do
        sleep 1
done
sudo systemctl enable mongodb
sudo systemctl start mongodb
