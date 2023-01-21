// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ProbablyNFT is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    ERC721Burnable,
    Ownable
{
    using Counters for Counters.Counter;
    using Strings for uint256;

    address probablyContractAddress;

    Counters.Counter private _tokenIdCounter;

    string public baseTokenURI;

    uint256 public price;
    bool public paused;

    constructor(
        string memory _baseTokenURI,
        uint256 _price
    ) ERC721("ProbablyNFT", "PN") {
        baseTokenURI = _baseTokenURI;
        price = _price;
    }

    modifier onlyProbablyContract() {
        require(msg.sender == probablyContractAddress, "ERR:NA");
        _;
    }

    function setProbablyContract(address _probablyContractAdrress) public {
        probablyContractAddress = _probablyContractAdrress;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function safeMint(
        address to,
        string memory uri
    ) external payable onlyProbablyContract {
        require(msg.value >= price, "ERR:WV");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function burnNFT(uint256 _tokenId) external onlyProbablyContract {
        _burn(_tokenId);
    }

    function setPaused(bool val) external onlyProbablyContract {
        paused = val;
    }

    function withdraw() external payable onlyProbablyContract {
        uint256 _amount = address(this).balance;

        require(_amount > 0, "ERR:ZB");
        address _owner = owner();

        (bool sent, ) = _owner.call{value: _amount}("");
        require(sent, "ERR:WT");
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    receive() external payable {}

    fallback() external payable {}
}
