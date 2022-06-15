#!/bin/bash
set -x

alice=$(certik keys show alice -a --keyring-backend test)
txflags=(--from alice --keyring-backend test -y -b block --chain-id test --gas auto --gas-adjustment 2)

######################## First round of txs

# create a pool
certik tx shield create-pool 1000000000uctk me $alice --shield-rate 5 $txflags

# deposit initial collateral
certik tx shield deposit-collateral 1000000000uctk $txflags

######################## Query

# query shield pool
certik query shield pool 1

# query shield provider alice
certik query shield provider $alice


######################## Second tx

# first purchase (shield goes over the collateral amount)
certik tx shield purchase 1 1000000000uctk "my first purchase" $txflags

######################## Query

# query purchase
certik query shield pool-purchases 1

######################## Third txs

# make some donations to the reserve
certik tx shield donate 10000uctk $txflags

# register Alice as a certified identity for claim proposal votings
certik tx cert issue-certificate identity certik1zexrzljmu3sups2fhw8j6w85ykksu8jvejzt2f $txflags

######################## Query

# query the reserve
certik query shield reserve

######################## Fourth txs

# submit a claim proposal within the coverage
certik tx gov submit-proposal shield-claim custom/claim_proposal.json $txflags

# vote yes to the proposal
certik tx gov vote 1 yes $txflags

######################## Query

# query the purchase (multiple times to see proposal and cooldown period going in effect)
certik query shield pool-purchases 1

# query the proposal
certik query gov proposal 1

######################## Fifth txs

# submit a claim proposal over the collateral amount
certik tx gov submit-proposal shield-claim custom/claim_proposal_over.json $txflags

# vote yes to the proposal
certik tx gov vote 2 yes $txflags

######################## Query

# query shield status (multiple times to see it goes to 0 when the proposal passes)
certik query shield status

# query provider
certik query shield provider $alice

# query reserve
certik query shield reserve

# query the proposal
certik query gov proposal 2

######################## Sixth txs

# top off the reserve to pay off any insufficient reimbursements
certik tx shield donate 1000000000uctk $txflags

######################## Query

# query the reserve to see if anything's left
certik query shield reserve

######################## Seventh txs

# top off the reserve to pay off any insufficient reimbursements
certik tx shield donate 1000000000uctk $txflags

######################## Query

# query the reserve to see if anything's left
certik query shield reserve

######################## Final txs

# submit a claim proposal after waiting for the previous proposal to finish.
certik tx gov submit-proposal shield-claim custom/claim_proposal.json $txflags

######################## Query

# wait until the proposal fails. query the proposal
certik query gov proposal 3

# additional queries
certik query shield status
certik query shield provider $alice
certik query shield reserve
