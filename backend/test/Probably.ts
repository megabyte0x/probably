import { ethers } from "hardhat";
import { LINK_TOKEN, KEY_HASH, FEE, VRF_COORDINATOR } from "../constants";

describe("Probably", function () {
  it("Should deploy Probably.sol and ProbablyNFT.sol", async () => {
    const probably = await ethers.getContractFactory("Probably");
    console.log(
      VRF_COORDINATOR +
        "----" +
        LINK_TOKEN +
        "-------" +
        KEY_HASH +
        "---------" +
        FEE
    );
    const probablyDeployed = await probably.deploy(
      VRF_COORDINATOR,
      LINK_TOKEN,
      KEY_HASH,
      FEE,
      "uri/"
    );
    await probablyDeployed.deployed().catch((error: Error) => {
      console.error(error);
    });

    const probablyAddress = probablyDeployed.address;

    console.log(probablyAddress);
  });
});
