// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

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
    ) {
        deployer = _msgSender();
        probablyNFT = new ProbablyNFT(
            _baseTokenURI,
            vrfCoordinator,
            linkToken,
            vrfKeyHash,
            vrfFee
        );
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
}
