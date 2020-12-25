pragma solidity ^0.7.0;
import "./Manufacturer.sol";

contract Item
{
    string name;
    uint128 priceInWei;
    uint32 quantity;
    address payable owner;
    uint128 moneyWithHold;
    Manufacturer manu;
    uint32 itemIdentifier;

    event withDrawl(address owner,uint128 money,string message);
    constructor(string memory _name,uint128 price,uint32 _itemIdentifier,Manufacturer _manu) public
    {
        this.name = _name;

        this.priceInWei = price;
        this.manu = _manu;
        this.itemIdentifier = _itemIdentifier;
    }
    function withDrawMoney() public payable
    {
        require(msg.sender==this.owner,"You are not eligible to withdraw the amount");
        require(this.moneyWithHold>0,"Hello Owner! No money to withdraw");
        uint128 money = this.moneyWithHold;
        this.moneyWithHold = 0;
        this.owner.send(money);
        emit withDrawl(msg.sender,money,"WithDrawl Successful");
    }
    function setQuantity(uint64 _quantity) public
    {
        require(msg.sender==this.owner,"Only owner can modify the quantity");
        this.quantity = _quantity;
    }
    function incrementQuantity() public
    {
        require(msg.sender==this.owner,"Only owner can modify the quantity");
        this.quantity += 1;
    }
    function getQuantity() public view returns(uint64)
    {
        return this.quantity;
    }

    function getPrice() public view returns(uint128)
    {
        return this.priceInWei;
    }

    function setPrice(uint128 price) public
    {
        require(msg.sender==this.owner,"Only owner can modify the quantity");
        this.priceInWei = price;
    }

}