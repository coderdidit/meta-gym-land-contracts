// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract TestGymBuddies is ERC721URIStorage, Ownable {
    address marketplaceAddress;

    // most recent address for marketplace
    constructor(address _marketplaceAddress)
        ERC721("MetaGymLAnd GymBuddy", "MGLGB")
    {
        marketplaceAddress = _marketplaceAddress;

        // mint 3 test tokens
        createToken(0);
        createToken(1);
        createToken(2);
        createToken(3);
    }

    function createToken(uint32 gbId) public {
        string memory cid = "QmVM2UpxbR1a9MdBSW7c4C6pZmhxcji8wsAsUEM2Jkezrt";
        string memory baseUri = "https://gateway.pinata.cloud/ipfs/";
        string memory tokenMetadataURI = string(abi.encodePacked(baseUri, cid, "/gb", Strings.toString(gbId), ".json"));

        _mint(msg.sender, gbId);
        _setTokenURI(gbId, tokenMetadataURI);
        setApprovalForAll(marketplaceAddress, true);
    }
}
