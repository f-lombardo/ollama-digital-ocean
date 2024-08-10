#!/bin/bash

DROPLET_NAME_OR_ID=$1

if [ -z "$DROPLET_NAME_OR_ID" ]; then
    echo "Usage: $0 <droplet-name-or-id>"
    exit 1
fi

echo "Deleting Droplet..."
doctl compute droplet delete "$DROPLET_NAME_OR_ID"
echo "Droplet deleted"
