app=certik

export DAEMON_NAME=certik
export DAEMON_HOME=/home/ylee/.$app
export DAEMON_RESTART_AFTER_UPGRADE=true

upgradename=Shield-V2

mkdir ~/.$app/cosmovisor
mkdir ~/.$app/cosmovisor/upgrades
mkdir ~/.$app/cosmovisor/upgrades/$upgradename
mkdir ~/.$app/cosmovisor/upgrades/$upgradename/bin
cp build/$DAEMON_NAME ~/.$app/cosmovisor/upgrades/$upgradename/bin/$DAEMON_NAME

mkdir ~/.$app/cosmovisor/genesis
mkdir ~/.$app/cosmovisor/genesis/bin
cp ~/go/bin/$DAEMON_NAME ~/.$app/cosmovisor/genesis/bin/$DAEMON_NAME

killall $DAEMON_NAME
cosmovisor start