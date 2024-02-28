// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface INFTContract{
  function safeMint(address to, string memory uri) external;
}