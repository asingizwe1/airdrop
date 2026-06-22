//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test,console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
    
    contract MerkleAirdropTest is Test {
MerkleAirdrop private airdrop;
BagelToken private bagel;
bytes32 public ROOT="0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4";

address public user = "0x6CA6d1e2D5347Bfab1d91e883F1915560e09129D";
uint256 userPrivkey;
//will run automatically when we run our script
function setUp() public {
    bagel = new BagelToken();
    airdrop = new MerkleAirdrop(ROOT,token);
    (user,userPrivkey) = makeAddrAndKey("user");//craete an address and private key
}

function testUsersCanClaim() public{
console.log("User address: %s", user);//you opy the address you get and put it in array of addresses


}
    }