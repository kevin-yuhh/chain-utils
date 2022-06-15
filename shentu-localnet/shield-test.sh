#!/bin/bash
set -x

txflags="--from alice -y -b block --fees 5000uctk"

legacy test
certik tx shield deposit-collateral 1000000uctk $txflags
certik tx shield create-pool 100000uctk "asdf" $(certik keys show alice -a --keyring-backend test) --shield-limit 300000000000 $txflags --native-deposit 1000000uctk
certik tx shield withdraw-collateral 10000uctk  $txflags

#certik tx shield create-pool 100000000000uctk me $(certik keys show alice -a --keyring-backend test) --shield-rate 5 --chain-id test --from alice --keyring-backend test -y -b block
#certik tx shield deposit-collateral 1000000000000uctk --from alice --keyring-backend test -y -b block --chain-id test
#certik tx shield purchase 1 1000000000000uctk "my first purchase" --from alice --keyring-backend test --chain-id test -y -b block