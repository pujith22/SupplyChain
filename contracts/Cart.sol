pragma solidity ^0.7.0;

contract Cart
{
    address customer;
    uint index;
    mapping(uint=>Items) public cartItems;
    constructor()
    {
        this.customer = msg.sender;
    }
    function addItem(uint item)
    {
        
    }
}
