pragma solidity ^0.7.0;
import "./Item.sol";
import "./Order.sol";

contract MarketPlace
{
    // All available items at one place
    mapping(uint32=>uint32) items;
    uint32 itemsCounter;
    constructor()
    {
        this.itemsCounter = 0;
        this.ordersCounter = 0;
    }
    function insertItem(Item item) public
    {
        if(items[item.itemIdentifier]!=0)
        {
            require(msg.sender==items[item.itemIdentifier].owner,"only owner is able to update the item");
        this.items[itemsCounter] = new Item(item);
        this.itemsCounter++;
        }
    }

    function getAvailableQuantity(uint32 itemid) public view
    {
        return this.items[itemid];
    }
    

    function processOrder(Order ord)
    {
        
    }

}