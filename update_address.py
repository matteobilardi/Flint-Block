#!/usr/bin/env python3
# Update gensis.json file with ethereum address specified in ~/.flint/flint_config.json

import json
from pathlib import Path

flint_config_file_path = Path(f"{Path.home()}/.flint/flint_config.json")
genesis_file_path = Path("genesis.json")

with open(flint_config_file_path, "r") as flint_config_file:
    flint_config_json = json.load(flint_config_file)
ethereum_address = flint_config_json["ethereumAddress"]

with open(genesis_file_path, "r") as genesis_file:
    genesis_config_json = json.load(genesis_file)


balance = "5000000" 
genesis_config_json["alloc"] = {ethereum_address : {"balance": balance}}

with open(genesis_file_path, "w") as genesis_file:
    json.dump(genesis_config_json, genesis_file, indent=2)

print(f"Configured genesis.json so that address {ethereum_address} is initialised with {balance} Wei")
