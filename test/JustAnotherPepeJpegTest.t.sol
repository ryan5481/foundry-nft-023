// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {JustAnotherPepeJpeg} from "../src/JustAnotherPepeJpeg.sol";
import {DeployJustAnotherPepeJpeg}  from "../script/DeployJustAnotherPepeJpeg.s.sol";
import {Test} from "forge-std/Test.sol";

contract JustAnotherPepeJpegTest is Test {
    JustAnotherPepeJpeg public justAnotherPepeJpeg;
    DeployJustAnotherPepeJpeg public deployer;

    address public USER = makeAddr("user");
    string public constant PEPE = "https://ipfs.io/ipfs/QmRmeQ9NRtmjFkMk1RgyJzpuuKaZ8ZsenQZQRp2JaY9Eb2?filename=pepe.json";

    function setUp() public {
        deployer = new DeployJustAnotherPepeJpeg();
        justAnotherPepeJpeg = deployer.run();

        // vm.prank(msg.sender);
        // string memory tokenUri = justAnotherPepeJpeg.tokenURI(tokenId);
        // return justAnotherPepeJpeg.mintNft(tokenUri);
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Just Another Pepe Jpeg";
        string memory actualName = justAnotherPepeJpeg.name();

        // We can't do assert(expectedName == actualName), 
        // because == can't be applied to type string memory 
        // String are special types, are array of bytes
        // We can't compare arrays to arrays (only premitive/ elementary types eg uint256, bool, address, byte32 etc)
        // 
        // We can loop through and compare at each iteration
        // or we compare the hash
        // => abi.encodePack the arrays and compare the hashs of them
        
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));

    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        justAnotherPepeJpeg.mintNft(PEPE);

        assert(justAnotherPepeJpeg.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PEPE)) ==keccak256(abi.encodePacked(justAnotherPepeJpeg.tokenURI(0))));
    }
}
