shentud tx staking unbond $(shentud keys show alice -a --bech=val --keyring-backend test) 1uctk --from bob --keyring-backend test --chain-id test -y -b block

shentud query auth account $(shentud keys show bob -a --keyring-backend test)


$(shentud keys show alice -a --keyring-backend test)
$(shentud keys show bob -a --keyring-backend test)