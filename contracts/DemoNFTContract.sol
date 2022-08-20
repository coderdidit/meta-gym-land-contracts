// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract DemoNFTContract is ERC721URIStorage, Ownable {
    uint256 itemID = 1;

    constructor()
        ERC721("MetaGymLandDemoGymBuddy", "MGLDGB1")
    {
        // automatically mint tokens to the contract deployer
        createToken(
            "ipfs://bafkreiaeho7l2lojgzst2tro2dth6ocs2oqsfgxnqzv3rxw447hfavby5m"
        );
    }

    function createToken(string memory tokenURI) public returns (uint256) {
        _mint(msg.sender, itemID);
        _setTokenURI(itemID, tokenURI);
        return itemID;
    }
}
