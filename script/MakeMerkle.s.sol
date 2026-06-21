//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
contract MakeMerkle is Script {
    function run() external {
        //we want to deploy the merkle airdrop contract
        //we need to pass in the merkle root and the token address
        bytes32 merkleRoot = 0x1234567890123456789012345678901234567890123456789012345678901234; // Replace with your Merkle root
        address airdropTokenAddress = 0x1234567890123456789012345678901234567890; // Replace with your ERC20 token address
        vm.startBroadcast();
        new MerkleAirdrop(merkleRoot, airdropTokenAddress);
        vm.stopBroadcast();
    }