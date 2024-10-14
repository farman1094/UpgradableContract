// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@OpenZeppelin/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress);
        proxy.upgradeToAndCall(address(newBox), ""); // Proxy contract now point to this new address
        vm.stopBroadcast();
        return address(proxy);
    }

    function run() public returns (address) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2(); // Logic
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
        return proxy;
    }
}
