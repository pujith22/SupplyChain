pragma solidity ^0.6.0;

import "./Ownable.sol";
import "./Item.sol";

contract ItemManager is Ownable{
    enum SupplyChainSteps{Created, Paid, Delivered}
    // S_Item is to define item ready for trading.
    struct S_Item{
        Item _item;
        ItemManager.SupplyChainSteps _step;
        string _identifier;
    }
    // for handling multiple items from same supplier.
    mapping(uint => S_Item) public items;
    // variable pointing to new slot to be added to items.
    uint index;
    // event for emitting later for display purposes.
    event SupplyChainStep(uint _itemIndex,uint _step, address _address);

    // function to create a item by the supplier
    function createItem(string memory _identifier, uint _priceInWei) public{
        Item item = new Item(this, _priceInWei, index);
        items[index]._item = item;
        //initialize with created state.
        items[index]._step = SupplyChainSteps.Created;
        items[index]._identifier = _identifier;
        // emitting once even occured successfully.
        emit SupplyChainStep(index, uint(items[index]._step), address(item));
        index++;
    }

    function triggerPayment(uint _index) public payable{
        Item item = items[_index]._item;
        require(address(item) == msg.sender,"Only items are allowed to update themselves");
        require(item.priceInWei() == msg.value, "Payment is not complete yet");
        require(items[index]._step == SupplyChainSteps.Created,"Item is in the Supply Chain");
        items[_index]._step = SupplyChainSteps.Paid;
        emit SupplyChainStep(_index, uint(items[_index]._step), address(item));
    }

    function triggerDelivery(uint _index) public onlyOwner{
        require(items[_index]._step == SupplyChainSteps.Paid, "Item is already in the Supply Chain");
        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(_index,uint(items[_index]._step), address(items[_index]._item));
    }
}