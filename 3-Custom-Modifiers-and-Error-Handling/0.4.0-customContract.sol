pragma solidity ^0.4.0;

interface Regulator{
    function checkValue(uint amount) returns(bool);
    function bool() returns(bool);
}

contract Bank is Regulator{
    uint private value;
    address private owner;

    modifier ownerFunc{
        require(owner == msg.sender);
        _;
    }

    function Bank(uint amount){
        value = amount;
        owner = msg.sender;
    }

    function deposit(uint amount){
        value += amount;
    }

    function withdraw(uint amount){
        if(checkValue(amount)){
            value -= amount;
        }
    }

    function balance() returns(uint){
        return value;
    }

    function checkValue(uint amount) returns(bool){
        //classic mistake in the tutorial value should above the amoutn
        return value >= amount;
    }

    //if we have positive value we can make a loan
    function loan()returns(bool){
        return value > 0;
    }
}

//any functional is exist in bank will also exist in FirstContract
contract FirstContract is Bank{
    //define some variable
    string private name;
    uint private age;

    //set and get method to set and get name/age
    //set value of name
    function setName(String newName){
        name = newName;
    }

    function getName() returns(string){
        return name;
    }

    //age
    function setAge(uint newAge){
        age = newAge;
    }

    function getName() returns(uint){
        return age;
    }
}

contract TestThrows{
    function testAssert(){
        assert(1==2);
    }

    function testRequire(){
        require(2==1);
    }

    function testRevert(){
        revert();
    }

    function testThrow(){
        throw;
    }
}