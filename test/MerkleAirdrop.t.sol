//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test,console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
    
    contract MerkleAirdropTest is Test {
MerkleAirdrop private airdrop;
BagelToken private bagel;
//creatd coz we dont want magic numbers in function calls
uint256 public AMOUNT_TO_SEND=AMOUNT_TO_CLAIM*4;
bytes32 public ROOT="0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4";
uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
//the values in the array must first be stored as intermediate bytes32
bytes32 proofOne=;
bytes32 proofTwo=;
bytes32[] public PROOF = [];//copy proofs into the test file
address public user = "0x6CA6d1e2D5347Bfab1d91e883F1915560e09129D";
uint256 userPrivkey;
//will run automatically when we run our script
function setUp() public {//if its a zksync chain we want to be using this then if it isnt we would use our deployment script
//you cant use scripts to deploy in a zksync environment
    bagel = new BagelToken();
    airdrop = new MerkleAirdrop(ROOT,token);
    token.mint(token.owner(),AMOUNT_TO_SEND);
    token.transfer(address(airdrop),AMOUNT_TO_SEND);//airdrop comtains all tokens for the airdrop
    //since airdrop is of type mERKLEROOT We must cast the airdrop above to address
    (user,userPrivkey) = makeAddrAndKey("user");//craete an address and private key
}

function testUsersCanClaim() public{
console.log("User address: %s", user);//you opy the address you get and put it in array of addresses
//we first store their initial address
uint256 startignBalance = token.balanceOf(user);
airdrop.claim(user,AMOUNT_TO_CLAIM,PROOF);

vm.prank(user);//prank pranks the next line
//we use the prank function to simulate the user calling the claim function
uint256 endingBalance = token.balanceOf(user);
console.log("User balance after claim: %s", endingBalance);
assertEq(endingBalance, startignBalance + AMOUNT_TO_CLAIM   , "User did not receive the correct amount of tokens");//to check that amount has been sent to the user
}
    }//6:02