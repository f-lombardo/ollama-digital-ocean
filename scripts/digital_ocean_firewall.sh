#!/bin/bash

# This script creates a firewall to expose Ollama service and ssh
# After having created the firewall put its id in the .env file

FIREWALL_NAME="ollama-firewall"
OUTBOUND_RULES="protocol:icmp,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:0,address:0.0.0.0/0,address:::/0 protocol:udp,ports:0,address:0.0.0.0/0,address:::/0"

echo "Creating firewall..."
FIREWALL_ID=$(doctl compute firewall create --name $FIREWALL_NAME --outbound-rules "$OUTBOUND_RULES"  --format ID | tail -1)

if [ $? -ne 0 ]; then
    echo "Failed to create firewall."
    exit 1
fi

INBOUND_ICMP="protocol:icmp,address:0.0.0.0/0,address:::/0"
INBOUND_HTTP="protocol:tcp,ports:11434,address:0.0.0.0/0,address:::/0"
INBOUND_SSH="protocol:tcp,ports:22,address:0.0.0.0/0,address:::/0"

doctl compute firewall add-rules $FIREWALL_ID --inbound-rules $INBOUND_ICMP
doctl compute firewall add-rules $FIREWALL_ID --inbound-rules $INBOUND_HTTP
doctl compute firewall add-rules $FIREWALL_ID --inbound-rules $INBOUND_SSH

doctl compute firewall get $FIREWALL_ID --format ID,Name,Status
