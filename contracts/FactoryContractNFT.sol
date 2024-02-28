// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "./NFTContract.sol";
import "./INFTContract.sol";


contract FactoryContractNFT{
    SogoNFT[] public contracts ;
    SogoNFT public userContract;
    mapping (address => address) nftContractAddress;


    function createContract() external{
         userContract = new SogoNFT(msg.sender);
         nftContractAddress[msg.sender] = address(userContract);
    }
    
    function safeMint(address _to, string memory uri) public{
       INFTContract(nftContractAddress[msg.sender]).safeMint(_to, uri);
    }

}
