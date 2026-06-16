//SPDX-Licence-Identifier: MIT
pragma  solidity ^0.8.24;
import {IERC20,SafeERC20} from "openzeppelin-contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleAirdrop} from "./MerkleAirdrop.sol";

contract MerkleAirdrop{
    using SafeERC20 for IERC20;
error MerkleAirdrop__InvalidProof();

//some list of addresses
//allow someone in the list to claim ERC20 tokens
address[] claimers;
//constructor where we can pass in our erc20 token and merkle root to compare against
IERC20 private immutable i_airdropToken;
bytes32 private immutable i_merkleRoot;
//we are going to store the parameters as storage values
event Claim(address account, uint256 amount);
//takes merkle root and token we wish to airdrop to our users
constructor(bytes32 merkleRoot, IERC20 airdropToken){
i_merkleRoot = merkleRoot;
i_airdropToken = airdropToken;
}
//takes address enabling people claim and amount , array to store - call datd
//inrermediate hashes required for the proof - merkleProof
function claim(address account, uint256 amount, bytes32[] calldata) external{
///calculate the hash- leaf node

//hashes twice to prevent collison
bytes32 leaf=keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
//second preimage attack
//using merkle proofs we want to hash twice
//to avoid colisions
//we verify that the leaf node provides a valid proof to the merkle root
if (!MerkleAirdrop.verify(merkleProof,i_merkleRoot,leaf)){
//revert is followed by atleast contract name
revert MerkleAirdrop__InvalidProof();

}
emit Claim(account, amount);
i_airdropToken.safeTransfer(account, amount);
//if we cant send tokens safe erc20 will handle that for us


}





}