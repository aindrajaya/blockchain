pragma solidity 0.4.18 =< 0.6.0;

interface Regulator{
    function checkValue(uint amount) returns(bool);
    function bool() returns(bool);
}

contract Bank is Regulator{
    uint private value;

    function Bank(uint amount){
        value = amount;
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

    function loan()returns(bool){
        return value > 0;
    }
}

contract FirstContract is Bank(10){
    string private name;
    uint private age;

    //set and get method to set and get name/age
    //name
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