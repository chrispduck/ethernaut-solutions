pragma solidity ^0.6.0;


interface IMagicNumber {
    function setSolver(address _solver) external;
}

contract Solver{
    IMagicNumber challenge = IMagicNumber(0x0Fd8de537bd866f971CC3C26C0dd423F357F5be4);
function attack() public {
    bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
    bytes32 salt = 0;
    address solver;

    assembly {
        solver := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
    }

    challenge.setSolver(solver);
}
}
