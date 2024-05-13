// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {JustAnotherPepeJpeg} from "../src/JustAnotherPepeJpeg.sol";
import {Script} from "forge-std/Script.sol";

contract DeployJustAnotherPepeJpeg is Script {

    function run() external returns (JustAnotherPepeJpeg) {
        vm.startBroadcast();
        JustAnotherPepeJpeg justAnotherPepeJpeg = new JustAnotherPepeJpeg();
        vm.stopBroadcast();
        return justAnotherPepeJpeg;
    }
}
