// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

error AlreadyInitialized();
error NeedMoreCryptoSent();
error RangeOutOfBounds();

// Smart contract ot mint a short collections 
// that has links to snapchat lenses
// a lens includes coresponding GymBuddy
contract RandomGymBuddyWithSnap is ERC721URIStorage, VRFConsumerBaseV2, Ownable {
    // Chainlink VRF Variables
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    // NFT Variables
    uint256 private i_mintFee;
    using Counters for Counters.Counter;
    Counters.Counter private s_tokenCounter;

    uint256 internal constant MAX_ID_OF_METADATA_FILE = 2;
    bool private s_initialized;

    // VRF Helpers
    mapping(uint256 => address) public s_requestIdToSender;

    // Events
    event NftRequested(uint256 indexed requestId, address requester);
    event NftMinted(uint256 gymBuddyId, address minter);

    constructor(
        address vrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint256 mintFee,
        uint32 callbackGasLimit
    )
        VRFConsumerBaseV2(vrfCoordinatorV2)
        ERC721("MetaGymLAnd GymBuddy", "MGLGB")
    {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_mintFee = mintFee;
        i_callbackGasLimit = callbackGasLimit;
        _initializeContract();
    }

    function requestNft() public payable returns (uint256 requestId) {
        if (msg.value < i_mintFee) {
            revert NeedMoreCryptoSent();
        }
        requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );

        s_requestIdToSender[requestId] = msg.sender;
        emit NftRequested(requestId, msg.sender);
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords)
        internal
        override
    {
        s_tokenCounter.increment();
        address nftOwner = s_requestIdToSender[requestId];
        uint256 newItemId = s_tokenCounter.current();
        uint256 uriMetadataFileID = randomWords[0] % MAX_ID_OF_METADATA_FILE;

        _safeMint(nftOwner, newItemId);
        string memory tokenUri = _getTokenUriWithItemId(uriMetadataFileID);
        _setTokenURI(newItemId, tokenUri);

        emit NftMinted(newItemId, nftOwner);
    }

    function _initializeContract() private {
        if (s_initialized) {
            revert AlreadyInitialized();
        }
        s_initialized = true;
    }

    function _getTokenUriWithItemId(uint256 uriMetadataFileID)
        private
        pure
        returns (string memory)
    {
        string
            memory cid = "bafybeigtxk3hoji67vd5gi66jxe774pdtfagdc7bb6mwdgfirv5zhdtorm";
        string memory baseUri = "ipfs://";
        string memory tokenMetadataURI = string(
            abi.encodePacked(
                baseUri,
                cid,
                "/gb",
                Strings.toString(uriMetadataFileID),
                ".json"
            )
        );
        return tokenMetadataURI;
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    function getMintFee() public view returns (uint256) {
        return i_mintFee;
    }

    function getInitialized() public view returns (bool) {
        return s_initialized;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter.current();
    }
}
