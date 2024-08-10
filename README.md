# Ollama on Digital Ocean
With these scripts you can create a [Digital Ocean droplet](https://www.digitalocean.com/products/droplets) running [Ollama](https://ollama.com/).
Be careful: **these script are just for development purposes**, since they can have security problems, 
such as not having encrypted http traffic!

## How to use these scripts
0. Install and configure [doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/)
1. Copy the [/scripts/.env.sample](/scripts/.env.sample) in `/scripts/.env` 
2. Create a firewall with [/scripts/digital_ocean_firewall.sh](/scripts/digital_ocean_firewall.sh) and copy its ID in `.env`
3. Create your ssh key on Digital Ocean or use and already existing one, and put its fingerprint in `.env`
4. Run the [/scripts/digital_ocean.sh](/scripts/digital_ocean.sh). If everything is OK, you will see the ID and IP address assigned to your new droplet.
5. Connect to your dropled using ssh or the connection console provided inside Digital Ocean dashboard. Inside it start your LLM model with `ollama run model_name`
6. At this point you should be able to connect to Ollama API at `http://ip_address:11434/api/`
7. When you no longer need your droplet remember to delete it, otherwise you'll be pay for it even if it is not active. To do that you can use [/scripts/digital_ocean.sh](/scripts/digital_ocean_delete.sh) passing the name or the ID of the droplet.
