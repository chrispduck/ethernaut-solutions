// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {
    address public entrant;

    // send from a contract
    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    // EOA or contract constructor - must be the latter
    modifier gateTwo() {
        uint256 x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }

    // Must know address of contract.
    // Easiest to compute this on the fly
    // uint64(0) - 1 = I
    // x^gateKey = I
    // => gatekey = x^I
    modifier gateThree(bytes8 _gateKey) {
        require(
            uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^
                uint64(_gateKey) ==
                uint64(0) - 1
        );
        _;
    }

    function enter(bytes8 _gateKey)
        public
        gateOne
        gateTwo
        gateThree(_gateKey)
        returns (bool)
    {
        entrant = tx.origin;
        return true;
    }
}
