certik tx staking unbond $(certik keys show alice -a --bech=val --keyring-backend test) 1uctk --from bob --keyring-backend test --chain-id test -y -b block

certik query auth account $(certik keys show bob -a --keyring-backend test)


$(certik keys show alice -a --keyring-backend test)
$(certik keys show bob -a --keyring-backend test)