import { BigNumberish, BytesLike, ethers } from "ethers";

export const LINK_TOKEN: string = "0x326C977E6efc84E512bB9C30f76E30c160eD06FB";
export const VRF_COORDINATOR: string =
  "0x8C7382F9D8f56b33781fE506E897a4F1e2d17255";
export const KEY_HASH: BytesLike =
  "0x6e75b569a01ef56d18cab6a8e71e6600d6ce853834d4a5748b720d06f878b3a4";
export const FEE: BigNumberish = ethers.utils.parseEther("0.0001");
export const abi: any[] = [];
