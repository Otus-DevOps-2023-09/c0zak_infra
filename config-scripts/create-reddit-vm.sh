#!/bin/bash

cd ../packer

folder_id_var=$(jq -r '.folder_id_var' variables.json)

packer build -var-file=variables.json immutable.json

yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=$folder_id_var,image-family=reddit-full \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--zone ru-central1-a \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=files/metadata.yaml
