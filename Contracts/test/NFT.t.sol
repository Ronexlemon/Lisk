// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Test} from "forge-std/Test.sol";
import {LISKNFT} from "../src/NFT.sol";
import "forge-std/console.sol";
contract LISKNFTTest is Test{
    
LISKNFT public lisknft;
address alice = makeAddr("Alice");
address bob = makeAddr("Bob");
 
function setUp()public{
   
    lisknft = new LISKNFT();     
   
}

function test_canMintNFT()public {
   pushData();
   
    assertEq(lisknft.balanceOf(bob),1);

}

function pushData()private{
  vm.prank(bob);
  lisknft.mint(10,"https://1");

}

function test_getAllUserNFTS()public {
  pushData();
   
  LISKNFT.UserNFT[] memory nfts = lisknft.getAllUserNFTS(bob);
  console.log("%d:%d",nfts[0].tokenURI );
 // assertEq(nfts.length,1);
  assertEq(nfts[0].listPrice,10);
  assertEq(nfts[0].tokenURI,"https://1");


}


}