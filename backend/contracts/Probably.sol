// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "./Interface/IProbablyNFT.sol";

contract Probably is Context, Ownable, IERC721Receiver {
    address deployer;

    address probablyNFTAddress;

    IProabablyNFT probablyNFT;

    constructor(address _probablyNFTAdress) IERC721Receiver() {
        probablyNFTAddress = _probablyNFTAdress;
        setUp(_probablyNFTAdress);
        deployer = _msgSender();
    }

    function setUp(address _probablyNFTAddress) internal {
        probablyNFT = IProabablyNFT(_probablyNFTAddress);
    }

    function getProbablyNFTAddress() public view returns (address) {
        return address(probablyNFT);
    }

    function buyTicket(string memory _uri) public payable {
        probablyNFT.safeMint(_msgSender(), _uri);
    }

    function deleteTicket(uint256 _tokenId) public {
        probablyNFT.burnNFT(_tokenId);
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
