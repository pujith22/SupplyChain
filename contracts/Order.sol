pragma solidity ^0.7.0;
import "./MarketPlace.sol";

contract Order
{
    string customerName;    //customer name
    string add;             //customer address
    mapping(uint32=>uint32) public itemsWithQuantity;  //Item requirement with their quantity
    address customer;   // customer's wallet address
    constructor(string memory _customerName,string memory _add)
    {
        this.customer = msg.sender;
        this.customerName = _customerName;
        this.add = _add;

    }

    function changeAddress(string memory _add) public{
        require(msg.sender==this.customer,"Only OrderCreator can change his address");
        this.add = _add;
    }

    function addItem(uint32 itemid,uint32 itemQuant) public
    {
        require(msg.sender==this.customer,"Only OrderCreator can change the cart items");
        MarketPlace M = new MarketPlace();
        this.itemsWithQuantity[itemid] = itemQuant;
    }

    function removeItem(uint32 itemid) public
    {
        require(msg.sender==this.customer,"You are not the Order Creator");
        require(this.itemsWithQuantity[itemid]!=0,"The item you wanted to remove is not in the order");
        delete(itemsWithQuantity[itemid]); //to check if valid syntax or not
    }

    function editOrder(uint32 itemid,uint32 quant)
    {
        require(msg.sender==this.customer,"You are not the Order Creator!");
        require(this.itemsWithQuantity[itemid]!=0,"The item you wanted to modify is not existed");
        uint32 quantityAvailable = MarketPlace.getAvailableQuantity(itemid);
        require(quantityAvailable<=quant,"Only "+string(quantityAvailable)+"is available. Try changing the quantity"));
        this.itemsWithQuantity[itemid] = quant;
    }

}