pragma solidity >=0.4.22 < 0.7.1;

contract FirstContract{
    string private name;
    uint private age;

    //set and get method to set and get name/age
    //name
    function setName(string memory newName)public{
        name = newName;
    }

    function getName()view public returns (string memory){
        return name;
    }

    //age
    function setAge(uint newAge)public{
        age = newAge;
    }

    function getName() view public returns(uint){
        return age;
    }
}