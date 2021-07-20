pragma solidity >=0.4.21 < 0.7.2;

contract Transaction{
    event SenderLogger(address);
    event ValueLogger(uint);

    address private owner;

    modifier validValue{
        assert(msg.value >= 1 ether); _;
    }
    
    modifier isOwner{
        require(owner == msg.sender); _;
    }

    function Transaction(){
        owner = msg.sender;
    }

    function() payable isOwner validValue {
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
    }
}