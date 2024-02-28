import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config({ path: ".env" });


const ALCHEMY_MUMBAI_API_KEY_URL = process.env.ALCHEMY_MUMBAI_API_KEY_URL;

const ACCOUNT_PRIVATE_KEY = process.env.ACCOUNT_PRIVATE_KEY;

const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;

const POLYGON_API_KEY = process.env.POLYGON_API_KEY;

module.exports = {
  solidity: "0.8.24",
  networks: {
    mumbai: {
      url: ALCHEMY_MUMBAI_API_KEY_URL,
      accounts: [ACCOUNT_PRIVATE_KEY],
    }
  },
  etherscan: {
    apiKey: {
      polygonMumbai: POLYGON_API_KEY
    }
  },
  sourcify: {
    enabled: true
  },
  lockGasLimit: 200000000000,
  gasPrice: 10000000000,

};