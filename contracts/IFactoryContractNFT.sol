// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;


interface IFactoryContractNFT {
  function createContract() external ;
  function safeMint(address _to, string memory uri) external;
}