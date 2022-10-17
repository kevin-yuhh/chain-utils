#!/bin/bash
set -x

txflags="--from alice -y -b block --fees 5000uctk"

legacy test
shentud tx shield deposit-collateral 1000000uctk $txflags
shentud tx shield create-pool 100000uctk "asdf" $(shentud keys show alice -a --keyring-backend test) --shield-limit 300000000000 $txflags --native-deposit 1000000uctk
shentud tx shield withdraw-collateral 10000uctk  $txflags

#shentud tx shield create-pool 100000000000uctk me $(shentud keys show alice -a --keyring-backend test) --shield-rate 5 --chain-id test --from alice --keyring-backend test -y -b block
#shentud tx shield deposit-collateral 1000000000000uctk --from alice --keyring-backend test -y -b block --chain-id test
#shentud tx shield purchase 1 1000000000000uctk "my first purchase" --from alice --keyring-backend test --chain-id test -y -b block