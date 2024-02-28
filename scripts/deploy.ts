import { ethers } from "hardhat";

async function main() {
  const FactoryContractNFT = await ethers.deployContract("FactoryContractNFT");

  await FactoryContractNFT.waitForDeployment();

  const SocialMedia = await ethers.deployContract("SocialMedia", [FactoryContractNFT.target]);

  await SocialMedia.waitForDeployment();


  console.log(
    `SocialMedia contract deployed to ${SocialMedia.target}`
  );

  console.log(
    `Factory contract deployed to ${FactoryContractNFT.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
