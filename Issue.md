# Issue

The Contract Registry is a contract that stores the addresses of all the contracts deployed on the blockchain. It is used to get the address of a contract by its name. 

The Issue :
 - Contract Registry is giving a zero address for the `ACCESS_ACTION` contract when queried using `getAddress(string)(address)` function.

 The contract though works when queried using cast command `cast call ${CONTRACT_REGISTRY_ADDRESS} "getAccessActionAddress()(address)"`
 
## Steps to Reproduce

1. Deploy the sample contract : 

    ```bash
    export FOUNDRY_PROFILE=local
    export PRIVATE_KEY=0x0
    export ADDRESS=0x0
    forge script script/DeployAll.s.sol -vvvv --legacy --broadcast
    ```

2. Export env variables : 

    Use the contract registry address from output above. 
    #### Note down the AccessAction Address to verify later
    ```bash
    export CONTRACT_REGISTRY_ADDRESS=0x0
    export ACCESS_ACTION_ADDRESS=0x0
    ```

3. Test the contract registry :
    ```bash
    forge script script/TestRegistry.s.sol  -vvvv
    ```

4. Verify the contract registry using cast :

    ```bash
    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAccessActionAddress()(address)"

    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAddress(string)(address)" ACCESS_ACTION 
    ```
5. Verify the contract registry using python:

    ```bash
    export WEB3_PROVIDER_URI = 'http://localhost:10002'
    export ETH_ACCOUNT_PRIVATE_KEY = '0x0'

    python script/python/verifyCR.py
    ```

## Logs 

```
user@macbook % forge script script/TestRegistry.s.sol  -vvvv
[⠢] Compiling...
No files changed, compilation skipped
Traces:
  [252193] → new TestRegistry@0x5b73C5498c1E3b4dbA84de0F1833c4a029d90519
    └─ ← 1149 bytes of code

  [98] TestRegistry::setUp()
    └─ ← ()

  [37148] TestRegistry::run()
    ├─ [0] VM::envAddress(CONTRACT_REGISTRY_ADDRESS)
    │   └─ ← <env var value>
    ├─ emit log(: CONTRACT_REGISTRY_ADDRESS, : 0x5FbDB2315678afecb367f032d93F642f64180aa3)
    ├─ [0] VM::envAddress(CONTRACT_REGISTRY_ADDRESS)
    │   └─ ← <env var value>
    ├─ [7651] 0x5FbDB2315678afecb367f032d93F642f64180aa3::getAddress(ACCESS_ACTION)
    │   ├─  emit topic 0: 0x8f648de01e7a9b8bbd89b9dcd07631ba853403981a5cdcb6ddb86473240824f5
    │   │           data: 0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000d436f6e7472616374204e616d6500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d4143434553535f414354494f4e00000000000000000000000000000000000000
    │   ├─ emit logAddress(: Contract Address, : 0x0000000000000000000000000000000000000000)
    │   └─ ← 0x2ecfa8ed
    └─ ← 0x2ecfa8ed


Error:
Script failed.
```

When ran using cast call

```
user@macbook % cast call ${CONTRACT_REGISTRY_ADDRESS} "getAddress(string)(address)" ACCESS_ACTION

0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
```

### Error Codes

0x2ecfa8ed : Contract address not found