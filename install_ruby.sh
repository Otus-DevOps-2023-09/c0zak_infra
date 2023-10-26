#!/bin/bash

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
ruby_success=$(ruby -v)
bundler_success=$(bundler -v)
echo

if [[ $ruby_success == *"ruby"* ]]; then
  echo "Ruby is installed successfully!"
else
  echo "Ruby installation failed!"
fi

if [[ $bundler_success == *"Bundle"* ]]; then
  echo "Bundler is installed successfully!"
else
  echo "Bundler installation failed!"
fi
