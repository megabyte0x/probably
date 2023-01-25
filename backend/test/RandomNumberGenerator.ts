import { ethers } from "hardhat";
import { LINK_TOKEN, KEY_HASH, FEE, VRF_COORDINATOR } from "../constants";

describe("RandomNumberGenerator.sol", function () {
  it("It should deploy the contract", async () => {
    const randomNumberGenerator = await ethers.getContractFactory(
      "RandomNumberGenerator"
    );

    const deployRandomNumberGenerator = await randomNumberGenerator.deploy(
      VRF_COORDINATOR,
      LINK_TOKEN,
      KEY_HASH,
      FEE
    );

    await deployRandomNumberGenerator.deployed().catch((error: Error) => {
      console.error(error);
    });

    const randomNumberGeneratorAddress = deployRandomNumberGenerator.address;

    console.log(randomNumberGeneratorAddress);
  });

  it("Should set Probably Contract Address", async () => {
    const randomNumberGenerator = await ethers.getContractFactory(
      "RandomNumberGenerator"
    );

    const randomNumberGeneratorDeployed = await randomNumberGenerator.deploy(
      VRF_COORDINATOR,
      LINK_TOKEN,
      KEY_HASH,
      FEE
    );

    await randomNumberGeneratorDeployed.deployed().catch((error: Error) => {
      console.error(error);
    });

    const probablyAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

    const setProbablyAddress =
      await randomNumberGeneratorDeployed.setProbablyContract(probablyAddress);

    await setProbablyAddress.wait().catch((error: Error) => {
      console.error(error);
    });
  });

  it("Should request a random number with probably contract signer", async () => {
    const randomNumberGenerator = await ethers.getContractFactory(
      "RandomNumberGenerator"
    );

    const randomNumberGeneratorDeployed = await randomNumberGenerator.deploy(
      VRF_COORDINATOR,
      LINK_TOKEN,
      KEY_HASH,
      FEE
    );

    await randomNumberGeneratorDeployed.deployed().catch((error: Error) => {
      console.error(error);
    });

    const probablyAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

    const setProbablyAddress =
      await randomNumberGeneratorDeployed.setProbablyContract(probablyAddress);

    await setProbablyAddress.wait().catch((error: Error) => {
      console.error(error);
    });

    const requestRandomNumber =
      await randomNumberGeneratorDeployed.generateRandomNumber();

    await requestRandomNumber
      .wait()
      .then((val) => {
        console.log(val);
      })
      .catch((error: Error) => {
        console.error(error);
      });
  });
});
