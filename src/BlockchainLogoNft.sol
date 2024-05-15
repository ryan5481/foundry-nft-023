// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract BlockchainLogoNft is ERC721 {
    // ERRORS
    error BlockchainLogoNft__CantFlipBullishOnIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_bitcoinSvgImageUri;
    string private s_ethereumSvgImageUri;

    enum BullishOn {
        BITCOIN,
        ETHEREUM
    }

    mapping(uint256 => BullishOn) private s_tokenIdToBullishOn;

    constructor(
        string memory bitcoinSvgImageUri,
        string memory ethereumSvgImageUri
    ) ERC721("BlockchainLogo NFT", "BLOCK") {
        s_tokenCounter = 0;
        s_bitcoinSvgImageUri = bitcoinSvgImageUri;
        s_ethereumSvgImageUri = ethereumSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToBullishOn[s_tokenCounter] = BullishOn.BITCOIN;
        s_tokenCounter++;
    }

    function flipBullishOn(uint256 tokenId) public {
        // Only the owner should be able to change what to be bullish on
        if (!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
            revert BlockchainLogoNft__CantFlipBullishOnIfNotOwner();
        }
        if (s_tokenIdToBullishOn[tokenId] == BullishOn.BITCOIN) {
            s_tokenIdToBullishOn[tokenId] == BullishOn.ETHEREUM;
        } else if (s_tokenIdToBullishOn[tokenId] == BullishOn.ETHEREUM) {
            s_tokenIdToBullishOn[tokenId] == BullishOn.BITCOIN;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToBullishOn[tokenId] == BullishOn.BITCOIN) {
            imageURI = s_bitcoinSvgImageUri;
        } else {
            imageURI = s_ethereumSvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "Blockchain logos", "attributes": [{"trait_type": "logo", "color": "blue"}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
