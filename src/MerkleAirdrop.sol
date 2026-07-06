//SPDX-Licence-Identifier: MIT
pragma  solidity ^0.8.24;
import {IERC20,SafeERC20} from "openzeppelin-contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleAirdrop} from "./MerkleAirdrop.sol";
import {EIP712} from "openzeppelin-contracts/utils/cryptography/draft-EIP712.sol";
contract MerkleAirdrop{
    using SafeERC20 for IERC20;
error MerkleAirdrop__InvalidProof();
error MerkleAirdrop__AlreadyClaimed();
error MerkleAirdrop__InvalidSignature();
//some list of addresses
//allow someone in the list to claim ERC20 tokens
address[] claimers;
//constructor where we can pass in our erc20 token and merkle root to compare against
IERC20 private immutable i_airdropToken;
mapping(address claimer => bool claimed) private s_hasClaimed;//storage variableto verify that the person claimed
bytes32 private immutable i_merkleRoot;
//we are going to store the parameters as storage values


struct AirDropClaim{
    address account;
    uint256 amount;
}

event Claim(address account, uint256 amount);
//takes merkle root and token we wish to airdrop to our users
constructor(bytes32 merkleRoot, IERC20 airdropToken) EIP721("MerkleAIRDROP","1"){
i_merkleRoot = merkleRoot;
i_airdropToken = airdropToken;
}


//signature creation , veirfication 







//keeping track of who has claimed

//takes address enabling people claim and amount , array to store - call datd
//inrermediate hashes required for the proof - merkleProof

//we parse our signature to claim so that one can sign and say i claimed for this account
//we pass into v,r,s
function claim(address account, uint256 amount, bytes32[] calldata merkleProof, uint8 v, bytes32 r, bytes32 s) external{
///calculate the hash- leaf node
if(s_hasClaimed[account]){//implemented a signature such that someone an initiate call with our address
revert MerkleAirdrop__AlreadyClaimed();//revert with this error message if already claimed

}
//check signature
//if not valid we get an error
//we use an internal function to check whether the signature is valid
if(!_isValidSignature(account, getMessage(account,amount), v, r, s)){revert MerkleAirdrop__InvalidSignature();}
//message is digest and we get it from method which hashes

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

function _isValidSignature(address account, bytes32 digest, uint8 v, bytes32 r, bytes32 s) internal pure returns(bool){
    //ecrecover returns the address that signed the message
    //ECDSA-> RECOVER signer from the signature
(address actualSigner,,)=ECDSA.recover(digest, v, r, s);
    return actualSigner == account;

}

function getMessage(address account, uint256 amount) public view returns(bytes32){
    //_hashTypedDataV4 from openzeppelin EIP712.sol
    return _hashTypedDataV4(keccak256(abi.encode(
        keccak256("Claim(address account,uint256 amount)"),
        AirDropClaim{
            account,
            amount
        }
        // account,//better if they are in a struct
        // amount
    )));
}

emit Claim(account, amount);
i_airdropToken.safeTransfer(account, amount);
//if we cant send tokens safe erc20 will handle that for us
//just adding the has claimed would be following the CEI -check,effect,interaction pattern

}

function getMessageHash(address account,uint256 amount) public returns (bytes32)
return _hashTypedDataV4
{
keccack256(abi.encode(MESSAGE_TYPEHASH,AirdropClaim({account:account,amount:amount})));


}

//adding getters
function getmerkleRoot() external view returns(bytes32){
    return i_merkleRoot;}
function getAirdropToken() external view returns(IERC20){
    return i_airdropToken;}//sp that we can get to know the airdrop address

}