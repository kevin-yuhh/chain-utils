#!/bin/bash

ansible fork_net -m copy -a "src=tmp/new.json dest=/opt/chain/.certik/config/genesis.json"
ansible fork_net -m shell -a "sudo systemctl stop certik && ./certik unsafe-reset-all && sudo systemctl start certik" --become-user ubuntu