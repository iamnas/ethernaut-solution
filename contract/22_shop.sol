
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBuyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}


contract Buyer is IBuyer {

    Shop public shop;
    constructor(Shop _shop){
        shop = _shop;
    }
    

  function price() external view returns (uint){
    if(!shop.isSold()){
    return 100;
    }else{
        return 0;
    }
  }

  function buyShop() public {
        shop.buy();
  }


}