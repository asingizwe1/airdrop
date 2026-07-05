//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
bytes32 public s_merkleRoot = "0x1f3e4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3g";//RETRIEVED FROM OUTPUT FILE
uint256 private s_amountToTransfer=4*25*1e18;
function deployMerkleAirdrop() public
{//deploy the bagel and airdrop contracts
    vm.startBroadcast();

        // Deploy BagelToken
        BagelToken bagelToken = new BagelToken();

        // Deploy MerkleAirdrop with the address of the BagelToken
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(s_merkleRoot,IERC20(token));
//mint deployer amount to airdrop
token.mint(token.owner(),s_amountToTransfer);
//we then transfer to the token contract
token.transfer(address(airdrop),s_amountToTransfer)
    vm.stopBroadcast();

//previously deployed smart contracts and handle deployment-related tasks.
}

    function run() external returns (MerkleAirdrop, BagelToken) {
    
        return deployMerkleAirdrop();
    }
}