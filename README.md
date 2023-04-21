# Install Networks 


## Install Foundry
Use the documentation here: https://github.com/foundry-rs/foundry


## Install Polygons

- Install Polygon using Go
```
go install github.com/0xPolygon/polygon-edge@develop
```

Do the local Setup :

- Create the node directories
```
polygon-edge secrets init --data-dir test-chain-1
polygon-edge secrets init --data-dir test-chain-2
polygon-edge secrets init --data-dir test-chain-3
polygon-edge secrets init --data-dir test-chain-4

```

- Format the multiaddress for the nodes to :
/ip4/<ip_address>/tcp/<port>/p2p/<node_id>

```
/ip4/127.0.0.1/tcp/10001/p2p/16Uiu2HAmNFmhJzV4RKDtyPQWndAWdWXiRPK5z6t6J1svB53foUwM
/ip4/127.0.0.1/tcp/20001/p2p/16Uiu2HAmSEm6wbiiXj2ZL7E9tDtNFcCTyJ6YDxCevXAWMtXfyvPb
```

- Generate Genesis file 
```
polygon-edge genesis --consensus ibft --ibft-validators-prefix-path test-chain- --bootnode /ip4/127.0.0.1/tcp/10001/p2p/NODE_ID_1 --bootnode /ip4/127.0.0.1/tcp/20001/p2p/NODE_ID_2 --ibft-validator-type ecdsa --premine ACCOUNT_ID --block-gas-limit 1000000000

```

The above command creates the following genesis.json. I am adding some more accounts to alloc
```
{
    "name": "polygon-edge",
    "genesis": {
        "nonce": "0x0000000000000000",
        "timestamp": "0x0",
        "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000f858f854949fb756eeb42dbf360725f07d23270e0fbc569c8e94eae90709b2737ffcfb4cfc2b8a3dd04369b4159994906635e43b89fe0e894bf3ac783948ec659aa3769498098178fa15008abfd0754f3b06122aef5e963280c0",
        "gasLimit": "0x3b9aca00",
        "difficulty": "0x1",
        "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
        "coinbase": "0x0000000000000000000000000000000000000000",
        "alloc": {
            "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266": {
                "balance": "0x1d14a0219e54822428000000"
            }
        },
        "number": "0x0",
        "gasUsed": "0x70000",
        "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
    },
    "params": {
        "forks": {
            "homestead": 0,
            "byzantium": 0,
            "constantinople": 0,
            "petersburg": 0,
            "istanbul": 0,
            "EIP150": 0,
            "EIP158": 0,
            "EIP155": 0
        },
        "chainID": 123456,
        "engine": {
            "ibft": {
                "epochSize": 100000,
                "type": "PoA",
                "validator_type": "ecdsa"
            }
        },
        "blockGasTarget": 0
    },
    "bootnodes": [
        "/ip4/127.0.0.1/tcp/10001/p2p/16Uiu2HAmNFmhJzV4RKDtyPQWndAWdWXiRPK5z6t6J1svB53foUwM",
        "/ip4/127.0.0.1/tcp/20001/p2p/16Uiu2HAmSEm6wbiiXj2ZL7E9tDtNFcCTyJ6YDxCevXAWMtXfyvPb"
    ]
}
```

- Run the polygon nodes
```
polygon-edge server --data-dir ./test-chain-1 --chain genesis.json --grpc-address :10000 --libp2p :10001 --jsonrpc :10002 --seal --log-level DEBUG

polygon-edge server --data-dir ./test-chain-2 --chain genesis.json --grpc-address :20000 --libp2p :20001 --jsonrpc :20002 --seal --log-level DEBUG 


polygon-edge server --data-dir ./test-chain-3 --chain genesis.json --grpc-address :30000 --libp2p :30001 --jsonrpc :30002 --seal --log-level DEBUG 


polygon-edge server --data-dir ./test-chain-4 --chain genesis.json --grpc-address :40000 --libp2p :40001 --jsonrpc :40002 --seal --log-level DEBUG 

```


## Issue 

The bugs/issues are documented [here](https://github.com/SantaHub/Foundry_NFT/blob/contractRegistry/Issue.md)
