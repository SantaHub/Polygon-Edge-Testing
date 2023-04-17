// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ContractRegistry is Ownable {
    error BlankContractName();
    error ZeroAddress();
    error ContractAddressNotFound();

    mapping(string => address) public registry;
    event Register(string contractName, address contractAddress);
    event logAddress(string, address);
    event logName(string, string);

    string public name = "Sulphur";

    function getStaticValue() public pure returns (string memory) {
        return "A static value";
    }

    function setName(string calldata _newName) public {
        emit logName("Name : ", name);
        name = _newName;
    }

    function getName() public returns (string memory) {
        emit logName("Name : ", name);
        return name;
    }

    constructor(address _address) Ownable() {
        transferOwnership(_address);
    }

    function updateAddress(string calldata _contractName, address _contractAddress) public onlyOwner {
        if (bytes(_contractName).length == 0) revert BlankContractName();
        setName(_contractName);
        if (_contractAddress == address(0)) revert ZeroAddress();
        registry[_contractName] = _contractAddress;
        emit Register(_contractName, _contractAddress);
    }

    function getAddress(string calldata _contractName) external returns (address) {
        emit logName("Contract Name", _contractName);
        emit logAddress("Contract Address", registry[_contractName]);

        if (registry[_contractName] == address(0)) {
            revert ContractAddressNotFound();
        }
        return registry[_contractName];
    }

    function getAccessActionAddress() external returns (address) {
        emit logAddress("Contract Address", registry["ACCESS_ACTION"]);

        if (registry["ACCESS_ACTION"] == address(0)) {
            revert ContractAddressNotFound();
        }
        return registry["ACCESS_ACTION"];
    }
}
