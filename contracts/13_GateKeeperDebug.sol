pragma solidity ^0.6.0;

contract GateKeeperDebug {
    uint32 public gateOneLHS;
    uint16 public gateOneRHS;

    uint32 public gateTwoLHS;
    uint64 public gateTwoRHS;

    uint32 public gateThreeLHS;
    uint16 public gateThreeRHS;

    function gateThree(bytes8 _gateKey) public {
        gateOneLHS = uint32(uint64(_gateKey));
        gateOneRHS = uint16(uint64(_gateKey));
        
        gateTwoLHS = uint32(uint64(_gateKey));
        gateTwoRHS = uint64(_gateKey);
    
        gateThreeLHS = uint32(uint64(_gateKey));
        gateThreeRHS = uint16(tx.origin);
    } 
}