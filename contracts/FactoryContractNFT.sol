// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "./NFTContract.sol";


contract FactoryContractNFT{
    SogoNFT[] public contracts ;
    SogoNFT public userContract;

    function createContract() external   returns (address){
         userContract = new SogoNFT(msg.sender);
         address nftcontractaddress = address(userContract);
         return nftcontractaddress;
    }
    
    function safeMint(address _to, string memory uri) public{
       safeMint(_to, uri);
    }

}
