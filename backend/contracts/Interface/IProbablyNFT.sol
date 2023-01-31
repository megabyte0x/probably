// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IProabablyNFT {
    function safeMint(address to, string memory uri) external payable;

    function setPaused(bool val) external;

    function burnNFT(uint256 _tokenId) external;

    function withdraw() external payable;
}
