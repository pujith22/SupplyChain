pragma solidity ^0.6.0;

import "./ItemManager.sol";

contract Item{
    uint public priceInWei;
    uint public paidWei;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public{
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable{
        require(msg.value == priceInWei, "Partial Payments are not Allowed! Sorry!");
        require(paidWei == 0, "Item is already paid!");
        paidWei += msg.value;
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",index));
        require(success,"Delivery UnSuccessful");
    }

    fallback() external{
        
    }
}