// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Script} from "forge-std/Script.sol";
import {JustAnotherPepeJpeg} from "../src/JustAnotherPepeJpeg.sol";
import {DeployJustAnotherPepeJpeg} from "../script/DeployJustAnotherPepeJpeg.s.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintJustAnotherPepeJpeg is Script {
    string public constant PEPE =
        "https://ipfs.io/ipfs/QmRmeQ9NRtmjFkMk1RgyJzpuuKaZ8ZsenQZQRp2JaY9Eb2?filename=pepe.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MintJustAnotherPepeJpeg",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        JustAnotherPepeJpeg(contractAddress).mintNft(PEPE);
        vm.stopBroadcast();
    }
}
