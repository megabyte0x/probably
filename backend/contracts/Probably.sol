// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Importing Context Smart Contract
import "@openzeppelin/contracts/utils/Context.sol";

contract probably is Context {
    address deployer;

    constructor() {
        deployer = _msgSender();
    }
}
