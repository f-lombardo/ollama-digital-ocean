#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"
DIR="$(readlink -f "${DIR}")"

source "$DIR"/.env

echo "Creating Droplet..."
DROPLET_ID=$(doctl compute droplet create $DROPLET_NAME --region $REGION --size $SIZE --image $IMAGE --ssh-keys $SSH_KEY_FINGERPRINT --user-data-file "${DIR}"/droplet_init.sh --format ID | tail -1)

if [ $? -ne 0 ]; then
    echo "Failed to create Droplet."
    exit 1
fi

max_retry=5
counter=0
until doctl compute droplet get $DROPLET_ID --format Name,ID,Status,PublicIPv4 | grep active; do
   ((counter++))

   if [[ $counter -eq $max_retry ]]; then
      echo "Droplet is stil not active after $max_retry attempts. Exiting" >&2
      exit 1
   fi

   sleep 6

   echo "Droplet is still not active. Retrying..."
done


sleep 5


echo "Assigning Firewall..."
doctl compute firewall add-droplets $FIREWALL_ID --droplet-ids $DROPLET_ID

