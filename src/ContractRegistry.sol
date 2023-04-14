// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ContractRegistry is Ownable {
    error BlankContractName();
    error ZeroAddress();
    error ContractAddressNotFound();

    mapping(string => address) public registry;
    event Register(string contractName, address contractAddress);


    constructor(address _address) Ownable() {
        transferOwnership(_address);
    }

    function updateAddress(string calldata _contractName, address _contractAddress) public onlyOwner {
        if (bytes(_contractName).length == 0) revert BlankContractName();

        if (_contractAddress == address(0)) revert ZeroAddress();
        registry[_contractName] = _contractAddress;
        emit Register(_contractName, _contractAddress);
    }

    function getAddress(string calldata _contractName) external view returns (address) {
        if (registry[_contractName] == address(0)) {
            revert ContractAddressNotFound();
        }
        return registry[_contractName];
    }

    function getAccessActionAddress() external view returns (address) {
        if (registry["ACCESS_ACTION"] == address(0)) {
            revert ContractAddressNotFound();
        }
        return registry["ACCESS_ACTION"];
    }
}
