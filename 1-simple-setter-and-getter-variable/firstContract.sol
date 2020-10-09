pragma solidity 0.4.18 =< 0.6.0;

contract FirstContract{
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