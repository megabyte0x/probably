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
        // address vrfCoordinator,
        // address linkToken,
        // bytes32 vrfKeyHash,
        // uint256 vrfFee,
        address probablyNFTAddress
    )
        // string memory _baseTokenURI
        IERC721Receiver()
    {
        setUp(probablyNFTAddress);
        deployer = _msgSender();
    }

    function setUp(address nftAddress) internal {
        probablyNFT = ProbablyNFT(payable(nftAddress));
    }

    // function getProbablyNFTAddress() public view returns (address) {
    //     return address(probablyNFT);
    // }

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
