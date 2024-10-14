// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from
    "@OpenZeppelin/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@OpenZeppelin/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from
    "@OpenZeppelin/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    // @custom: oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        // number = 0;
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}

    // function setNumber(uint256 _number) external {
    // number = _number;
    // }
}
