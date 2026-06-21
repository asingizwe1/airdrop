//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
contract MerkleAirdropTest is Test {
    //set up ,erkle tree and set up the proofs
    MerkleAirdrop private merkleAirdrop;
    address private airdropTokenAddress = 0x1234567890123456789012345678901234567890; // Replace with your ERC20 token address
    bytes32 private merkleRoot = 0x
    }