// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract AccessAction is Ownable {
    error ZeroAddress();

    constructor(address _address) Ownable() {
        if (_address == address(0)) revert ZeroAddress();
        transferOwnership(_address);
    }

}
