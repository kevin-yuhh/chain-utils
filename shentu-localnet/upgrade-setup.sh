
txflags="--from alice -y -b block --fees 5000uctk"

certik tx gov submit-proposal software-upgrade 'Shield-V2' --upgrade-height 18 --upgrade-info "TEST!" --title 'test' --description 'test upgrade on local env' $txflags

# certik tx gov submit-proposal software-upgrade test --upgrade-height 15 --upgrade-info="test upgrade" --title=testupgrade --description="testing" --from alice --keyring-backend test --chain-id test -y -b block
certik tx gov vote 1 yes $txflags
certik tx gov vote 1 yes $txflags
certik tx gov vote 1 yes $txflags

#sleep 3
certik tx gov submit-proposal --type text --title test --description test $txflags
certik tx gov vote 2 yes $txflags
#certik tx gov submit-proposal software-upgrade 'v2_1_0' --upgrade-height 4421700 --upgrade-info "Shentu v2.1.0 upgrade." --from alice --keyring-backend test -y -b block --title 'shentu-2.1' --description 'Shentu chain upgrade to bump the SDK to 0.42.9 and re-enable ' --chain-id test

#
#build/certik tx gov submit-proposal software-upgrade 'Shentu-v240' --upgrade-height 300 --upgrade-info "TEST" --from alice --keyring-backend test -y -b block --title 'test' --description "test upgrade on local env" --chain-id test
#build/certik tx gov vote 8 yes --from alice --keyring-backend test --chain-id test -y -b block
#build/certik tx gov vote 8 yes --from alice --keyring-backend test --chain-id test -y -b block
#build/certik tx gov vote 8 yes --from alice --keyring-backend test --chain-id test -y -b block
#
#build/certik tx gov submit-proposal --type text --from alice --keyring-backend test -y -b block --title test --description test --chain-id test
#build/certik tx gov vote 7 yes --from alice --keyring-backend test --chain-id test -y -b block