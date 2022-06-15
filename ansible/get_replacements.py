import json
import subprocess

query="ansible fork_net -m shell -a \"/opt/chain/certik tendermint show-validator --home /opt/chain/.certik && " \
      "/opt/chain/certik keys show nodekey -a --bech=val --keyring-backend test --home /opt/chain/.certik\" "

p = subprocess.Popen(query, stdout=subprocess.PIPE, shell=True)

res = p.communicate()

res_output = res[0]

res_str = res_output.decode('utf-8')
res_list = res_str.split("\n")

filelist = []
new_entry = {}
for line in res_list:
    line.rstrip()
    if "CHANGED" in line:
        continue
    elif "cosmos.crypto" in line:
        pubkey = json.loads(line)
        new_entry["pub_key"] = pubkey
    elif "certikvaloper" in line:
        new_entry["valoper"] = line
    if len(new_entry.keys()) == 2:
        filelist.append(new_entry)
        new_entry = {}

final = json.dumps(filelist)
print(final)