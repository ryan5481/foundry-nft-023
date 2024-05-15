// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {stdJson} from "forge-std/StdJson.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Script, console2} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string private constant TOKEN_URI =
        "ipfs://bafybeibs7i5rrwz3tzvmjbuutuz2oo5ealwgrqra4k4dtcko6d37p4rcde/?filename=pepe.json";

    function run() external {
        address recentlyDeployedBasicNFTContract = getDeployedContractAddress();
        console2.log(
            "The returned address is: ",
            recentlyDeployedBasicNFTContract
        );
        mintBasicNft(recentlyDeployedBasicNFTContract);
    }

    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(),
            "/broadcast/DeployBasicNft.s.sol/",
            Strings.toString(block.chainid),
            "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(
            json,
            ".transactions[0].contractAddress"
        );
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(
        bytes memory bys
    ) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function mintBasicNft(address _basicNFTcontractAddress) public {
        vm.startBroadcast();
        console2.log(
            "Minting of the BasicNFT is about to commence on chain: ",
            block.chainid
        );
        console2.log("The passed in tokenURI is: ", TOKEN_URI);
        console2.log("The passed in address is: ", _basicNFTcontractAddress);

        BasicNft(_basicNFTcontractAddress).mintNft(TOKEN_URI);
        console2.log("I ran till this point");
        vm.stopBroadcast();

        // uint256 yourNFTId = BasicNft(_basicNFTcontractAddress)
        //     .getTokenCounter() - 1;

        // console2.log("The Id of your minted BasicNFT token is: ", yourNFTId);
    }
}
