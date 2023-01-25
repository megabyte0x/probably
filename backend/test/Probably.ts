import { ethers } from "hardhat";

describe("Probably", function () {
  it("Should deploy Probably.sol", async () => {
    const probably = await ethers.getContractFactory("Probably");

    const probablyDeployed = await probably.deploy("");

    await probablyDeployed.deployed().catch((error: Error) => {
      console.error(error);
    });

    const probablyAddress = probablyDeployed.address;

    console.log(probablyAddress);
  });
});
