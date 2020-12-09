pragma solidity ^0.6.0;

contract Ownable{
    address public _owner;

    // this is to initialize owner who has deployed the smart contract.
    constructor() internal {
        _owner = msg.sender;
    }

    // only creator can make changes.
    modifier onlyOwner(){
        
        require(isOwner(), "Caller is not the Owner");
        _;
    }

    function isOwner() public view returns(bool){
        return (msg.sender == _owner);
    }

}