#!/bin/bash
set -x

alice=$(shentud keys show alice -a --keyring-backend test)
txflags=(--from alice --keyring-backend test -y -b block --chain-id test --gas auto --gas-adjustment 2)

######################## First round of txs

# create a pool
shentud tx shield create-pool 1000000000uctk me $alice --shield-rate 5 $txflags

# deposit initial collateral
shentud tx shield deposit-collateral 1000000000uctk $txflags

######################## Query

# query shield pool
shentud query shield pool 1

# query shield provider alice
shentud query shield provider $alice


######################## Second tx

# first purchase (shield goes over the collateral amount)
shentud tx shield purchase 1 1000000000uctk "my first purchase" $txflags

######################## Query

# query purchase
shentud query shield pool-purchases 1

######################## Third txs

# make some donations to the reserve
shentud tx shield donate 10000uctk $txflags

# register Alice as a certified identity for claim proposal votings
shentud tx cert issue-certificate identity certik1zexrzljmu3sups2fhw8j6w85ykksu8jvejzt2f $txflags

######################## Query

# query the reserve
shentud query shield reserve

######################## Fourth txs

# submit a claim proposal within the coverage
shentud tx gov submit-proposal shield-claim custom/claim_proposal.json $txflags

# vote yes to the proposal
shentud tx gov vote 1 yes $txflags

######################## Query

# query the purchase (multiple times to see proposal and cooldown period going in effect)
shentud query shield pool-purchases 1

# query the proposal
shentud query gov proposal 1

######################## Fifth txs

# submit a claim proposal over the collateral amount
shentud tx gov submit-proposal shield-claim custom/claim_proposal_over.json $txflags

# vote yes to the proposal
shentud tx gov vote 2 yes $txflags

######################## Query

# query shield status (multiple times to see it goes to 0 when the proposal passes)
shentud query shield status

# query provider
shentud query shield provider $alice

# query reserve
shentud query shield reserve

# query the proposal
shentud query gov proposal 2

######################## Sixth txs

# top off the reserve to pay off any insufficient reimbursements
shentud tx shield donate 1000000000uctk $txflags

######################## Query

# query the reserve to see if anything's left
shentud query shield reserve

######################## Seventh txs

# top off the reserve to pay off any insufficient reimbursements
shentud tx shield donate 1000000000uctk $txflags

######################## Query

# query the reserve to see if anything's left
shentud query shield reserve

######################## Final txs

# submit a claim proposal after waiting for the previous proposal to finish.
shentud tx gov submit-proposal shield-claim custom/claim_proposal.json $txflags

######################## Query

# wait until the proposal fails. query the proposal
shentud query gov proposal 3

# additional queries
shentud query shield status
shentud query shield provider $alice
shentud query shield reserve
