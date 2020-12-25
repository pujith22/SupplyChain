pragma solidity ^0.7.0;

contract Manufacturer
{
    string name;
    string phno;
    string emailId;
    address payable wallet;    

    constructor(string name,string phno,string emailId,uint avaialbleItems)
    {
        this.name = name;
        this.phno = phno;
        this.emailId = emailId;
        this.wallet = msg.sender;
    }

    
    function insertItem(string memory name, uint quantity, uint128 price) external
    {
        require(msg.sender==wallet,"Only owner has the capability of updating inventory");
        items[index] = new Item(name,quantity,price);
        index++;
    }
}