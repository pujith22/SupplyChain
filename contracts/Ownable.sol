pragma solidity ^0.6.0;

contract Ownable{
    address public _owner;

    constructor() internal {
        _owner = msg.sender;
    }

    modifier onlyOwner(){

        require(isOwner(), "Caller is not the Owner");
        _;
    }

    function isOwner() public view returns(bool){
        return (msg.sender == _owner);
    }

}