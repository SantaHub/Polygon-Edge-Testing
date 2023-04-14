pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/ContractRegistry.sol";
import "../src/AccessAction.sol";


contract DeployAllModulesScript is Script {

    string constant accessActionName = "ACCESS_ACTION";
    uint256 privateKey = vm.envUint("PRIVATE_KEY");
    address ownerAddress = vm.envAddress("ADDRESS");

    ContractRegistry contractRegistry;

   function run() external {
        vm.startBroadcast(privateKey);

        contractRegistry = new ContractRegistry(ownerAddress);
        deployAccessAction();
        vm.stopBroadcast();
    }

    function deployAccessAction() internal {
            AccessAction accessAction = new AccessAction(ownerAddress);
            contractRegistry.updateAddress(accessActionName, address(accessAction));
    }
    
}