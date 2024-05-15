// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;
import {Script, console} from "forge-std/Script.sol";
import {BlockchainLogoNft} from "../src/BlockchainLogoNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployBlockchainLogoNft is Script {
    function run() external returns (BlockchainLogoNft) {
        string memory bitcoinSvg = vm.readFile("./img/bitcoin-logo.svg");
        string memory ethereumSvg = vm.readFile("./img/ethereum-logo.svg");
        console.log(bitcoinSvg);

        vm.startBroadcast();
        BlockchainLogoNft blockchainLogoNft = new BlockchainLogoNft(
            svgToImageURI(bitcoinSvg),
            svgToImageURI(ethereumSvg)
        );
        vm.stopBroadcast();
        return blockchainLogoNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
