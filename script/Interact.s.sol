//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {script} from "forge-std/Script.sol";
import {DevopsTools} from "lib/foundry-devops/src/Devs.sol";
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
function claimAirdrop (address airdrop){vm.startBroadcast();
//we need to sign message with the account we need to claim to get the v,r,s
MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS,CLAIMING_AMOUNT,proof,v,r,s); 
vm.stopBroadcast();
}


function run(){

address mostRecentDeployed = DevopsTools.get_most_recent_deployment("MerkleAirdrop",block.chainid);

claimAirdrop(mostRecentDeployed);

}

}