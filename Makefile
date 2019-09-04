GETH=./geth
OS=$(shell uname -s | tr A-Z a-z)

$(GETH):
	wget -c https://gethstore.blob.core.windows.net/builds/geth-$(OS)-amd64-1.8.27-4bcc0a37.tar.gz -O - | tar -xz
	mv geth-$(OS)-amd64-1.8.27-4bcc0a37/geth .
	rm -rf geth-$(OS)-amd64-1.8.27-4bcc0a37

	

init: $(GETH)
	./update_address.py
	$(GETH) -datadir ./blockchain init ./genesis.json

run: $(GETH)
	$(GETH) --datadir ./blockchain --networkid 777 --ws --wsorigins "*" --wsapi="eth,web3,personal,miner" --gasprice 1

runH: $(GETH)
	$(GETH) --datadir ./blockchain --networkid 1 --rpc --rpcapi="eth,web3,personal,miner,net,debug"  --gasprice 0 --mine

attach: $(GETH)
	$(GETH) attach ws://localhost:8546

attachH: $(GETH)
	$(GETH) attach http://localhost:8545

script: $(GETH)
	$(GETH) attach ws://localhost:8546 --preload ./lazyMine.js

scriptH: $(GETH)
	$(GETH) attach http://localhost:8545 --preload ./lazyMine.js

clean:
	rm -rf blockchain/
	rm -rf ~/.ethash


