#!/bin/bash

until apt install -y git 2>&1; do
        sleep 1
done

git clone -b monolith https://github.com/express42/reddit.git /opt/reddit
cd /opt/reddit
bundle install

systemctl enable reddit
