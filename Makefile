GETH=./geth

init:
	$(GETH) -datadir ./blockchain init ./genesis.json

run:
	$(GETH) --datadir ./blockchain --networkid 777 --ws --wsorigins "*" --wsapi="eth,web3,personal,miner" --gasprice 1

runH:
	$(GETH) --datadir ./blockchain --networkid 1 --rpc --rpcapi="eth,web3,personal,miner,net,debug"  --gasprice 0 --mine

attach:
	$(GETH) attach ws://localhost:8546

attachH:
	$(GETH) attach http://localhost:8545

script:
	$(GETH) attach ws://localhost:8546 --preload ./lazyMine.js

scriptH:
	$(GETH) attach http://localhost:8545 --preload ./lazyMine.js

clean:
	rm -rf blockchain/
	rm -rf ~/.ethash


