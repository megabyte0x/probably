// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumberGenerator is VRFConsumerBase, Ownable {
    uint256 public fee;

    bytes32 public keyHash;

    address private probablyContract;

    constructor(
        address vrfCoordinator,
        address linkToken,
        bytes32 vrfKeyHash,
        uint256 vrfFee
    ) VRFConsumerBase(vrfCoordinator, linkToken) {
        keyHash = vrfKeyHash;
        fee = vrfFee;
    }

    function setProbablyContract(
        address _probablyContractAddress
    ) public onlyOwner {
        probablyContract = _probablyContractAddress;
    }

    function generateRandomNumber() external returns (bytes32 requestId) {
        // require(msg.sender == probablyContract, "ERR:NA");
        require(LINK.balanceOf(address(this)) >= fee, "ERR:LB");

        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(
        bytes32 requestId,
        uint256 randomness
    ) internal virtual override {}
}
