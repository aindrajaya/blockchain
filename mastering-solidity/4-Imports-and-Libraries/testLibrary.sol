pragma solidity >=0.4.21 < 0.7.2;

import "4-Imports-and-Libraries/library.sol";
//you can import from github

contract TestLibrary{
    using IntExtended for uint;
    function testIncrement(uint _base)public pure returns(uint) {
        return IntExtended.increment(_base);
    }

    function testDecrement(uint _base)public pure returns(uint) {
        return IntExtended.decrement(_base);
    }

    function testIncrementByValue(uint _base, uint _value)public pure returns(uint){
        return _base.incrementByValue(_value);
    }

    function testDecrementByValue(uint _base, uint _value)public pure returns(uint){
        return _base.decrementByValue(_value);
    }
}

