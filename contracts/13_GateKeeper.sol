// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract GatekeeperOne {
    using SafeMath for uint256;
    address public entrant;

    // beat by calling from a contract rather than EOA
    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    // can brute force by calling in a loop with contract.func{gas: arg}()
    modifier gateTwo() {
        require(gasleft().mod(8191) == 0);
        _;
    }

    // _gateKey is player's address
    // 0x935902bC8136E3477Bfc420f68CA98297196c1C1 masked with 'ffffffff0000ffff' 
    // => '0x68CA98290000c1C1'
    modifier gateThree(bytes8 _gateKey) {
        // must be > 2^32 || < 2^16
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        // must be > 2^32   
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        // the 32 LSB must be equal to the 16bit repr of the EOA.
        require(
            uint32(uint64(_gateKey)) == uint16(tx.origin),
            "GatekeeperOne: invalid gateThree part three"
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
