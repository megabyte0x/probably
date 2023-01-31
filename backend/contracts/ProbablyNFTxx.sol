// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract ProbablyNFT is VRFConsumerBase, ERC721Enumerable, Ownable {
    using Strings for uint256;

    string public baseTokenURI;

    uint256 public price;

    bool public paused;

    uint256 public tokenIds;

    uint256 public fee;

    bytes32 public keyHash;

    constructor(
        string memory _baseTokenURI,
        address vrfCoordinator,
        address linkToken,
        bytes32 vrfKeyHash,
        uint256 vrfFee
    ) VRFConsumerBase(vrfCoordinator, linkToken) ERC721("ProbablyNFT", "PN") {
        keyHash = vrfKeyHash;
        fee = vrfFee;
        baseTokenURI = _baseTokenURI;
    }

    modifier whenNotPaused() {
        require(!paused, "ERR:P");
        _;
    }

    function mint() public payable whenNotPaused {
        require(msg.value >= price, "ERR:WV");

        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function burn(uint256 _tokenId) public {
        require(_exists(_tokenId), "ERR:NE");
        _burn(_tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override(ERC721) returns (string memory) {
        require(_exists(tokenId), "ERR:NE");

        string memory baseURI = _baseURI();

        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    function setPaused(bool val) external onlyOwner {
        paused = val;
    }

    function withdraw() public payable onlyOwner {
        uint256 _amount = address(this).balance;

        require(_amount > 0, "ERR:ZB");
        address _owner = owner();

        (bool sent, ) = _owner.call{value: _amount}("");
        require(sent, "ERR:WT");
    }

    function fulfillRandomness(
        bytes32 requestId,
        uint256 randomness
    ) internal virtual override {}

    receive() external payable {}

    fallback() external payable {}
}
