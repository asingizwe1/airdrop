// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
//so that we can call claim

contract ClaimAirdrop is Script{
address public CLAIMING_ADDRESS = 0x6CA6d1e2D5347Bfab1d91e883F1915560e09129D;
uint256 public CLAIMING_AMOUNT = 25 * 1e18;
//proofs coinciding to the address from the output json
bytes32 public PROOF_ONE = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
bytes32 public PROOF_TWO=0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
//place then in proof array
bytes32[] public proof = [PROOF_ONE, PROOF_TWO];
bytes SIGNATURE= hex "//signature from running script ";
//0x- for hex

function claimAirdrop (address airdrop){vm.startBroadcast();
// the signature is basically the v,r,s so we break down the SIGNATURE to find them
(uint8 v,bytes32 r, bytes32 s)= splitSignature();

//we need to sign message with the account we need to claim to get the v,r,s
MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS,CLAIMING_AMOUNT,proof,v,r,s); 
vm.stopBroadcast();
}

function splitSignature(bytes memory sig) public returns (uint8 v, bytes32 r, bytes32 s)
{
//35+35+1 = 65
require(sig.length==65,"Invalid signature length");
//we use assembly yo break down the signatrue into v,r,s
assembly{//for a signature its r then s then v
r:=mload(add(sig,32))
s:=mload(add(sig,64))
v:=byte(0,mload(add(sig,96)))


}


}

function run(){

address mostRecentDeployed = DevopsTools.get_most_recent_deployment("MerkleAirdrop",block.chainid);

claimAirdrop(mostRecentDeployed);

}

}
//make deploy get address then cast call _address ,amount
//cast wallet sign --no-hash so that it doesnt sign the meassage
//pass the message to 