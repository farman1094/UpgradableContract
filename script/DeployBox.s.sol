// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@OpenZeppelin/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    function deployeBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1(); // Logic
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), ""); // In empty data we can put for initializer
        vm.stopBroadcast();
        return address(proxy);
    }

    function run() external returns (address) {
        // deployImpl("BoxV1");
        address proxy = deployeBox();
        return proxy;
    }
}
