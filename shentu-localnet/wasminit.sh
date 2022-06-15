set -x

RES=$(certik tx wasm store ~/work/cw-contracts/contracts/nameservice/target/wasm32-unknown-unknown/release/cw_nameservice.wasm --from alice --gas auto --gas-adjustment 1.5 --gas-prices 0.025uctk -y -b block --output json)
txflags="--from alice --gas auto --gas-adjustment 1.5 --gas-prices 0.025uctk -y -b block"
certik q wasm lco
CODE_ID=$(echo $RES | jq -r '.logs[0].events[-1].attributes[0].value')
INIT='{"purchase_price":{"amount":"100","denom":"uctk"},"transfer_price":{"amount":"999","denom":"uctk"}}'
certik tx wasm instantiate $CODE_ID "$INIT" --from alice --label "awesome name service by yoongbok lee" --gas auto --gas-prices 0.025uctk --gas-adjustment 1.5 -y -b block --admin certik1zexrzljmu3sups2fhw8j6w85ykksu8jvejzt2f
CONTRACT=$(certik query wasm list-contract-by-code $CODE_ID --output json | jq -r '.contracts[-1]')
REGISTER='{"register":{"name":"fred"}}'
certik tx wasm execute $CONTRACT "$REGISTER" --amount 100uctk --from alice --gas auto --gas-adjustment 1.5 --gas-prices 0.025uctk -y -b block
NAME_QUERY='{"resolve_record": {"name": "fred"}}'
certik query wasm contract-state smart $CONTRACT "$NAME_QUERY" --output json