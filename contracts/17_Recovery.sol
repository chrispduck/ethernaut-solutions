// Recovery 0xFBcD418896d42974E32318EaC360122CE8172C28
// SimpleToken 0x28B17c0dcb7284F5deCF78cAAC77E979d8E21674

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    using SafeMath for uint256;
    // public variables
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(
        string memory _name,
        address _creator,
        uint256 _initialSupply
    ) public {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value.mul(10); // OVERWRITES THE PREVIOUS BALANCE
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = _amount; // MISTAKE SHOULD BE +=. THIS WILL RESET THE BALANCE OF THE PERSON YOU SEND TO.
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}
