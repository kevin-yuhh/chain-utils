#!/bin/bash

cur=$(pwd)

cd ~/work/tmp
cat new.json | jq '.chain_id = "testing"' > tmp.json
cat tmp.json | jq '.app_state.cert.certifiers = [{"address": "certik1zfpv5k7gerc4yd8jhup8dr9ykq8c65dn0ppcqn", "alias": "", "description": "", "proposer": ""}]' > tmp2.json
cat tmp2.json | jq '.app_state.gov.voting_params.voting_period = "300s"' > new.json
cd $cur