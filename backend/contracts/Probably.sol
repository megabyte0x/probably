// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "./ProbablyNFT.sol";

contract Probably is Context, Ownable, IERC721Receiver {
    address deployer;

    ProbablyNFT probablyNFT;

    constructor(
        address vrfCoordinator,
        address linkToken,
        bytes32 vrfKeyHash,
        uint256 vrfFee,
        string memory _baseTokenURI
    ) IERC721Receiver() {
        setUp(vrfCoordinator, linkToken, vrfKeyHash, vrfFee, _baseTokenURI);
        deployer = _msgSender();
    }

    function setUp(
        address vrfCoordinator,
        address linkToken,
        bytes32 vrfKeyHash,
        uint256 vrfFee,
        string memory _baseTokenURI
    ) internal {
        probablyNFT = new ProbablyNFT(
            _baseTokenURI,
            vrfCoordinator,
            linkToken,
            vrfKeyHash,
            vrfFee
        );
    }

    function getProbablyNFTAddress() public view returns (address) {
        return address(probablyNFT);
    }

    function buyTicket() public payable {
        probablyNFT.mint();
    }

    function deleteTicket(uint256 _tokenId) public {
        probablyNFT.burn(_tokenId);
    }

    function pauseGame(bool _val) public onlyOwner {
        probablyNFT.setPaused(_val);
    }

    function withdrawFunds() public onlyOwner {
        probablyNFT.withdraw();
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}
