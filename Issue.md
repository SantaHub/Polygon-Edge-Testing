
# Issue

## Deploy and Test the contract

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
    ```

3. Test the contract registry :
    ```bash
    forge script script/TestRegistry.s.sol  -vvvv
    ```

4. Test Contract Registry using foundry :

    ```bash
    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAccessActionAddress()(address)"

    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAddress(string)(address)" ACCESS_ACTION 
    ```

    if using `anvil` use
    ```bash
    export RPC_URL=http://localhost:8545
    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAccessActionAddress()(address)" --rpc-url ${RPC_URL}
    cast call ${CONTRACT_REGISTRY_ADDRESS} "getAddress(string)(address)" ACCESS_ACTION --rpc-url ${RPC_URL}

    ```


5. Verify

    Verify the `AccessAction` Address and it should be same as the one noted above or can be verified by referring to `broadcast/DeployAll.s.sol/100/run-latest.json`