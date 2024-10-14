// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@OpenZeppelin/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployAndUpgrade is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public proxy;
    address owner = makeAddr("owner");

    function setUp() public {
        // vm.startBroadcast(owner);
        // vm.stopBroadcast();
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); // right now points to boxV1
    }

    function testProxyStartsBoxV1() public {
        uint256 expectedValue = 1;
        uint256 actualValue = BoxV1(proxy).version();
        assertEq(actualValue, expectedValue);

        vm.expectRevert();
        BoxV2(proxy).setNumber(10);
    }

    function testUpgradesWithoutScript() public {
        BoxV2 newBox = new BoxV2();
        upgrader.upgradeBox(proxy, address(newBox));
        uint256 expectedValue = 2;
        uint256 actualValue = BoxV2(proxy).version();
        assertEq(actualValue, expectedValue);

        //MORE
        BoxV2(proxy).setNumber(10);
        assertEq(10, BoxV2(proxy).getNumber());
    }
    // function testUpgradesWithScript() public {
    //     upgrader.run();
    //     uint256 expectedValue = 2;
    //     uint256 actualValue = BoxV2(proxy).version();
    //     assertEq(actualValue, expectedValue);

    //     //MORE
    //     BoxV2(proxy).setNumber(10);
    //     assertEq(10, BoxV2(proxy).getNumber());
    // }
}
