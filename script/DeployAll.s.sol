pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/ContractRegistry.sol";
import "../src/AccessAction.sol";


contract DeployAllModulesScript is Script {
    event logAddress(string, address);
    event logName(string, string);


    string constant accessActionName = "ACCESS_ACTION";
    uint256 privateKey = vm.envUint("PRIVATE_KEY");
    address ownerAddress = vm.envAddress("ADDRESS");

    ContractRegistry contractRegistry;

    function run() external {
        vm.startBroadcast(privateKey);

        contractRegistry = new ContractRegistry(ownerAddress);
        deployAccessAction();
        vm.stopBroadcast();
        
        ContractRegistry contractRegistry2 = ContractRegistry(address(contractRegistry));

        emit logAddress("Contract Registry addr", address(contractRegistry2));
        
        emit logName("Contract Registry Name", contractRegistry2.getName());

        address accessAction = contractRegistry2.getAddress("ACCESS_ACTION");
        emit logAddress("Access Action ", accessAction);
        accessAction = contractRegistry2.getAccessActionAddress();
        emit logAddress("Access Action ", accessAction);
    }

    function deployAccessAction() internal {
            AccessAction accessAction = new AccessAction(ownerAddress);
            contractRegistry.updateAddress(accessActionName, address(accessAction));
    }
    
}