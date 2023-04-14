pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/ContractRegistry.sol";
import "../src/AccessAction.sol";


contract TestRegistry is Script {
    event log(string, address);
    function setUp() public {}

    function _logEnvVars() private {
        emit log("CONTRACT_REGISTRY_ADDRESS", vm.envAddress("CONTRACT_REGISTRY_ADDRESS"));
    }

    function run() public {
        _logEnvVars();

        ContractRegistry contractRegistry = ContractRegistry(vm.envAddress("CONTRACT_REGISTRY_ADDRESS"));
        address accessAction;

        accessAction = contractRegistry.getAddress("ACCESS_ACTION");
        emit log("Access Action ", accessAction);
        accessAction = contractRegistry.getAccessActionAddress();
        emit log("Access Action ", accessAction);
    }
}