#!/bin/bash

hosts=shentu_fullnodes

ansible $hosts -m shell -a "sed -i 's/seeds = .*/seeds = \"3fddc0e55801f89f27a1644116e9ddb16a951e80@3.80.87.219:26656,4814cb067fe0aef705c4d304f0caa2362b7c4246@54.167.122.47:26656,f42be55f76b7d3425f493e54d043e65bfc6f43cb@54.227.66.150:26656\"/g' /opt/chain/.certik/config/config.toml"
p2p=$(ansible $hosts -m shell -a 'echo $(/opt/chain/certik tendermint show-node-id --home /opt/chain/.certik)@$(dig +short myip.opendns.com @resolver1.opendns.com):26656' | grep 26656)

peer_list=
for p in $p2p; do
  if [ "$peer_list" == "" ]; then
    peer_list="$p"
  else
    peer_list="$peer_list,$p"
  fi
done

echo "$peer_list"

# ansible $hosts -m shell -a "sed -i 's/persistent_peers = .*/persistent_peers = \""$peer_list"\"/g' /opt/chain/.certik/config/config.toml"