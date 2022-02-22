LEVEL 6 - SOLIDITY
------------------------------------
In this module you will learn what is Solidity and its basics

#What is Solidiy?
--> Solidity is an object-oriented, high-level language for implementing smart contracts. It is designed to target Ethereum Virtual Machine (EVM)
--> It is statically typed, supports inheritances, libraries and comple user-define types among other features.

#Building in Solidity
1. Initializing Smart Contract
```sol
//Define the compiler version you would be using
pragma solidity ^0.8.10;

//Start by creating a contrat named HelloWorld
contract HelloWorld{
  //your code shuold be here
}
```
====
2. Variables and Types
There are 3 types of variables in Solidity
--> Local: Declared inside a function and are not stored on blockchain
--> State: Declared outside a function to maintain the state of the smart contract, stored on the Blockchain
--> Global: Provide information about the blockhain. They are injedted by the Ethereum Virtual Machine during runtime. Includes things like transaction sender, block timestamp, block hash, etc.
Examples of Global Variables
The scope of variables is defined by where they are declared, note their value. Setting a local variable's value to a global variable does not make it a global variable, as it is still only accessible within it's scope.
```sol
//Define the compiler version you would be using
pragma solidity ^0.8.10;

//Start by creating a contract named Variables
contract Variables {
  /*
  State Variables
  */ 

  /*
  unit stands for unsigned integer, meaning non negative integers different sizes  avariable
  -> uint8 ranges from 0 to 2**8-1
  -> uint256 ranges from 0 to 2**256-1
  `public` means that the variable can be accesed internaly by the contract and can also read by the external world
  */
  uint8 public u8 = 10;
  uint public u256 = 600;
  uint public u = 1230; //uint is an alias for uint256

  /*
  Negative number are allowed for int types. Eg -int256 ranges from -2 **255 to 2**255-1\
  */

  int public i = -123; //int is same as int256

  //address stands for an ethereum address
  address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

  //bool stands for boolean
  bool public defaultBoo1 = false;

  //Default values
  //Unassigned variables have a defauult value in Solidity
  bool public defatulBoo2; //false
  uint public defaultUint; //0
  int public defaultInt; //0
  addres public defaultAddr; //0x0000....

  function doSomething() public {
    //Local variable
    uint ui = 456;

    //global Variable
    /*
    block.timestamp tells us whats the timestamp for the current block
    msg.sender tells us which address called the doSomething function
    */
    uint timestamp = block.timestamp; //current block timestamp
    address sender = msg.sender; //address of the contract/function caller
  }
}

---------------------------------------
### Functions, Loops and If/Else
//define the compiler version you would be using
pragma solidity 0.8.10;

//Start by creating a contract named Conditions
contract Conditions{
  //state variable to store a number
  uint publi num;

  /*
  Name of the function is set. It takes in a uint and sets the global variable num. It is a declared as a public function meaning it can be called from within the contract and also externally.
  */
  function set(uint _num) public{
    num = _num;
  }

  /*
  Name of the function is get. It returns the value of num. It is declared as a view function meaning that the funvtion doesn't change the state of any variable. View functions in Solidity do not require gas.
  */
  function get() public view returns (uint){
    return num;
  }

  /*
  Name of the function is foo. It takes in uint and returns an uint. It compares the avlue of x using if/else
  */
  function foo(uint x) public returns (uint){
    if(x < 10){
      return 0;
    } else if(x < 20){
      return 1;
    } else {
      return 2;
    }
  }

  /*
  Name of the function is loop. It runs a loop till 10
  */
  function loop() public {
    //for loop
    for (uint i = 0; i<10; i++){
      if(i == 3){
        //skip to next iteration with continue
        continue;
      }
      if(i == 5){
        //exit loop with break
        break;
      }
    }
  }
}
```

===-
3. Arrays and Strings
Array can have a compile-time fixed size or a dynamic size.
```sol
pragma solidity 0.8.10;

contract Array{
  //declare a string variable which is public
  string public greet = "hello world";

  //several ways to intialzie an array
  //Arrays initialized here are considered state variables that get stored on the blockchain
  //These are called storage variables
  uint[] public arr;
  uint[] public arr2 = [1,2,3];
  //Fixed sized array, all elements initialize to 0;
  uint[10] public myFixedSizeArr;
  
  /*
  Name of the function is get
  It gets the value of element stored in an arrays's index.
  */
  function get(uint i) public view returns(uint){
    return arr[i];
  }

  /*
  Solidity can return the entire array.
  This function gets called with and returns a uint[] memory.
  memory- the value is stored only in memory, and not on the blockchain. it only exists during the time the function is being executed.

  Memory variables and Storage variables can be thought of as similar to RAM vs Hard Disk. Memory variables exist temporarily, during function execution, whereas storage variables are persistent across function calls for the lifetime of the contract. 
  
  Here are the array is only needed for the duration while the function executes and thus is declared as a memory variable
  */
  function getArr(unit [] memory _arr) public view returns (uint[] memory){
    return _arr;
  }

  /*
  This function returns string memory.
  The reason memory keyword is added is because string internally works as an array.
  Here the string is only needed while the function executes.
  */
  function foo() public returns(string memory){
    return "C";
  }

  function doStuff(uint i) public{
    //Append to aray
    //This will increase the array length by 1.
    arr.push(i);

    //Remove the last element from array
    //This will decrease the array length by 1
    arr.pop();

    //get the length of the array
    uint length = arr.length;
  
    //Delete does not change the array length
    //It resets the avlue at index to it's default value
    //in this case will be 0
    delete arr[index];

    //Create array in memory, only fixed size can be created
    uint[] memory a = new uint[](5);

    //create string in memory
    string memory hi = "hi";
  }
}
```

==========================================================
# SOLIDITY 0.8 FROM SMART COTRACT PROGRAMMER
New Features
-> safemath
before 0.8 numbers overflowed and underflowed without any errors, this means that when a number goes out of range then it wraps around so if it goes below the minimum number then it wraps around to the maximum number and if it goes over the maximum number then it overflows to become the minimum number.

-> custom errors
Which means is that you'll be able to define a custom error and then use it with the rebirth function. This is why the custom errors is the better option that to return a string for the error message.

-> functions outside contract
we can write functions outside the contract
```file1.sol
pragma solidity 0.8.10;

error Unauthorized();

function helper(uint x) view returns(uint){
  return x * 2;
}

contract TestHelper{
  function test() external view returns (uint){
    return helpder(9); //return 18
  }
}
```
```file2.sol -> Import the custom error and outside functions
pragma solidity 0.8.10;

//* import {symbol as alies, symbol2} from "filename.sol";
import {Unoauthorized, helper as h1} from "./file2.sol";

function helper(uint x) view returns (uint){

}

contract import{}
```

-> import {symbol as alieas, symbol2} from 'filename'

-> salted contract creations/ create2
==========================================================

# Hello World
Most first smart contract
```sol
//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract HelloWorld{
  //Case 1
  string public hellostring = "Hello world";
  string public greet = "Hello again";
 
  //Case 2
  function hello() public view returns{
    return hellostring
  } 
}
```

# Values and References/Types
1. Data Types - values and types references
Here are some data types available in Solidity. When they are used as function arguments or variable assignments, their values are copied over to the new variable.
(boolean, int, uint, address, bytes32)
```sol
contract ValueTypes{
  bool public b = true;
  //only 0 and + numbers
  uint public u = 123 //uint have ranges, is depends on the type that you used, 128, 256 or 16, cannot contain negative numbers
 
  //if you want to use negative number, you can use int
  int public i = -123//the ranges can be negative

  //find out the minium value of int
  int public minInt = type(int).min;
  int public maxInt = type(int).max;

  //declare type address and byte32
  address public addr = 0x43odn2948ykdnsf984nesdf9824tkljnsd;
  bytes32 public b32 = 0xasdlkfndsgosg0835igk.sfdngo2h4q09ghnasfdklgn0a3wr58gnasfkj
}
```

# Function in Solidity
The basic syntax of writing a function in Solidity.
What are `external` and `pure`?
--> `external` tells Solidity that this function  can only be called from outside this contract.
--> `pure` tells Solidity that this function does not write anything to the blockchain
--> `external` will be fully explained in the section about function visibility
Functions are the executable units of code. Functions are usually defined inside a contract, but they can also be defined outside of contracts. Function Calls can happen internally or externally and have different levels of visibility towards other contracts. Function accept parameters and return variables to pass parameters and values between them.
Type of the Function Calls
1. Internal Function Calls
Functions of the current contract can be called directly ("internally"), also recursively, as seen in this nonsensical example:
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//this will report a warning
contract C {
  function g(uint a) public pure returns (uint ret){return a + f();}
  function f() internal pure returns (uint ret){return g(7)+ f();}
}
```
These function calls are translated into simple jumps inside the EVM. This has the effect that the current memory is not cleared, ie., passing memory references to internally-called functions is very efficient. Only functions of the same contract instance can be called internally. You should still avoid excessive recursion, as every internal function call uses up at leas one stack slot and there are only 1024 slots available.
====
2. External Function Calls
Functions can also be called using the `this.g(8);` and c.g(2)l; notation, where c is a contract instance and g is a function belonging to c. Calling the function g via either way results in it being called "ecternally", using a message call and not directly via jumps. Pleas note that function calls on `this` cannot be used in the constrcutor, as the actual contract has not been created yet. Functions of other contracts have to be called externally. For an external call, all function arguments have to be copied to memory.
{NOTE: A function call from one contract to another does not create its own transction, it is a message call as part of the overall transaction}
When calling functions of other contracts, you can specify the amount of Wei or gas sent with the call with the sepcial options `{value: 10, gas: 10000}`. Note that it is discouraged to specify gas values explicitly, since the gas costs of opcodes can change in the future. Any Wei you send ot the contract is added to the total balance of that contract:
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract InfoFeed{
  function info() public payable returns (uint ret) {return 42;}
}

contract Consumer{
  InfoFeed feed;
  function setFeed(InfoFeed addr) public {feed = addr;}
  function callFeed() public {feed.info(value: 10, gas: 800)();}
}
```
You need to use the modifier `payable` with the `info` function because otherwise, the `value` option would not be available.
====
### input and returns some
Function.sol
```sol
pragma solidity 0.8.10;

contract FunctionIntro{
  //Externall -> when we deploy this contract, we were able to call this function
  //Pure -> means that this function is read only it does not write anything to the blockchain
  function add(uint x, uint y) external pure returns (uint){
    return x + y;
  }

  function sub(uint x, uint y) external pure returns(uint){
    return x - y;
  }
}
```

# Variables (Local, State and Global)
1. State Variables
State variables are variables that stored data on the blockchain, if you store data in this state variable your data will be there for the next week, month even a year. State variable declare inside the contract but placed outside the function, if you declared outside the contract it won't be compiled and stored to the blockchain.
```sol
pragma solidity 0.8.10;

contract StateVariable{
  //The data stored inside this variable will be stored on the blockchain
  uint public myUint; 
}
```

2. Local Variable
Local state only use inside on the function
```sol
pragma solidity 0.8.10;

contract StateVariable{
  uint public myUint;
  uint public i;
  bool public b;
  address public myAddress;

  function foo() external{
    uint notStateVariable = 222; //this is local variable, it will exist only the function executed
  }

  //doesn't need pure or view function, because this functions is not read function but directly change the state of the variable
  function goo() external {
    uint x = 211;
    bool f = false;
    //more code
    x += 456;
    f = true
    //After the function execute, the variable just change to the new value just once. After that it will back to default value

    //The code below will updated the state variable
    i = 222;
    b = true;
    myAddress = address(1);
  }
}
```

3. Global variables
Global variables store information such as blockchain transaction and the account that call the function. If you used the global variable you should change your functions from `pure` to `view`.
```sol
pragma solidity 0.8.10;

contract GlobalVariable{
  //view just like the pure functions, but unlike pure funcionts, the view can read data from state variables and global variables
  function globalVars() external view returns (addres, uint, uint){
    address sender msg.sender; //this is the global variable that stored the addres that called this function, the data type of this variable is address
    uint timestamp = block.timestamp; //this variable stores the unix timestamp of when this function was called of. the data tye is uint
    uint blockNumb = block.number; //this stores current block number, the data type is uint
    return(sender, timestamp, blockNumb)
  }
}
```

4. View and Pure Functions
All of it is read-only functions, but the differences Pure functions do not read anything from the blockchain
```sol
pragme solidity 0.8.10;

contract ViewAndPureFunctions{
  uint public numb;

  function viewFunc() external view returns (uint){
    return num; //because it read the state variable
  }

  function pureFunc() external pure returns (uint){
    return 1; //because not read the state variable
  }

  function addToNum(uint x) external view returns (uint){
    return num + x;
  }

  function add(uint x, uint y) external pure returns (uint){
    return x + y;
  }
}
```

5. Counter dapp [CASE #1]
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Counter{
  //store the variable to the blockchain
  uint public count;

  functions increment() external {
    count = count + 1;
  }  

  //doesn't need pure or view function, because this functions is not read function but directly change the state of the variable
  functions decrement() external {
    count = count - 1;
  }
}
```

6. Default Variables
State and local variable have default value if you don't assign any value on it at first.
```sol
pragma solidity ^0.8.10;

contract defaultVariable{\
  //variable types
  bool public b; //default value is false
  uint public u; //default value is 0
  int public i; //default value is 0
  address public addr; //default value is 0x0000000000000000000000000000000000
  byes32 public b32; //default value is 0x0000000000000000000000000000000000000000000000000000000000000000000000000

  //there also default value of another data types mapping, structs, enums, fized sized arrays
}
```

7. Constants
the variable value that can't be changed
```sol
pragma solidity ^0.8.10;
11
//21442 gas -> more cheap/reduce the gas by using const
contract Constants {
  //Address
  address public constant MY_ADDRESS = 0x98asflndsfg089kljdfg0sasdfa; //using constant

  //Uint
  uint public constant MY_UINT = 123; //using constant
}

//23553 -> regular state variable
contract Var {
  //Address
  address public myAddr = 0xadasd90fusdofgnsdfga08yhvsodnv //not using constant
}
```

8. IF ELSE in Solidity
Just like you write conditionals on JavaScript
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract IFElse{
  function example(uint _x) external pure returns (uint){
    if(_x < 10){
      return "rather than 10";
    } else if(_x < 20){
      return "rather than 20";
    } else {
      return "another"
    }
  }

  function ternary(uint _x) external pure returns(uint){
    if(_x < 10){
      return 1;
    } return2;
    // return _x 10 ? 1 : 2;
  }
}
```

9. FOR and WHILE in Solidity
like a javascript syntax. Notes: the bigger number of loops that runs will be consumer more gas, make the loops small and the gas cost low
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ForAndWhile{
  function loop() external pure {
    for(uint i = 0; i<10; i++){
      //code will run if the condition below 'true'
      if(i == 3){
        continue; //will skipp the looping i equal 3, go direct to i equal 4
      }
      //code will run if the condition above 'false' and the main for loop condition true
      if(i == 5){
        break; //will end the looping when value for the i reach 5
      }
    }
  }

  function sumAllNumberUntilN(uint _n) external pure returns(uint){
    uint s; //to store the total number
    for(uint i = 1; i <= _n; i++){
      s += i; //will add all of the i value until the for loop condition false
    } 
    return s; //the result will be the amount of the value until the n value
  }
}
```

10. Error handling in Solidity
An error will undo all changes made to the state during a transaction. You can throw an error by calling require, revert, or assert. Errors allow you to define descriptive names and data for failure situations. Errors can be used in revert statements. In comparison to string descriptions, errors are much cheapter and alow you to encode additional data. Errors can be defined inside and outside of contrcats (including interfaces and libraries).
--> require is used to validate inputs and conditions before execution
--> revert is similar to require. See the code below
--> assert is used to check for code that should never be false. Failing assertion probably means tha tthere is a bug.
You can use custom error to save gas.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Error{
  function testRequire(uint _i) public pure{
    //Require should be used to validate conditions such as:
    //- inputs
    //- conditions before execution
    //- return values from calls to other functions
    require(_i > 10, "input must be greater than 10");
  }

  function testRevert(uint _i) public pure{
    //Revert is useful when the condition to check is complex
    //This code does the exact same thing as the example above
    if(_i <= 10){
      revert("Input must be greater than 10");
    }
  }

  uint public sum;
  function testAssert() public view{
    //Assert should only be used to test for internal errors,
    //and to check invariants
    
    //Here we assert that num is always equal to 0
    //since it is impossible to update the value of num
    assert(num == 0);
  }

  //Custom Error
  error InsufficientBalance(uint balance, uint withdrawAmount);
  function testCustomError(uint _withdrawAmount) public view{
    uint bal = address(this).balance;
    if(bal < _withdrawAmount){
      revert InsufficientBalance({
        balance: bal,
        withdrawAmount: _witdrawAmount
      });
    }
  }

  //Custom error With Actual Example
  error NotEnoughFunds(uint requested, uint available); //not enough funds for transfer. 
  mapping(address => uint) balances;
  function transfer(address to, uint amount) public{
    uint balance = balances[msg.sender];
    if(balance < amount)
      revert NotEnoughFunds(amount, balance);
    balances[msg.sender] -= amount;
    balances[to] += amount;
    //...
  }
}
```
Another example
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Account{
  uint public balance;
  uint public constant MAX_UINT = 2**256-1;
  
  function deposit(uint _amount) public{
    uint oldBalance = balance;
    uint newBalance = balance + _amount;

    //balance + _amount does not overflow if balance + _amount >= balance
    require(newBalance >= oldBalance, "overflow");

    balance = newBalance;

    assert(balance >= oldBalance);
  }

  function withdraw(uint _amount) public{
    uint oldBalance = balance;
    
    //balance - _amount does not underflow if balance >= _amount
    require(balance >= _amount, "Underflow");
  
    if(balance < _amount){
      revert("Underflow");
    }

    balance -= _amount;

    assert(balance <= oldBalance);
  }
}
```

===============
11. Functions Modifier
Function modifiers can be usde to amend the semantics of functions in a declarative way. Overloading, that is, having the same modifier name with different parameters, is not possible. Like functions, modifier can be overridden.
Modifiers can be used to change the behavour of functions in a declarative way. For example, you can use a modifier to automatically check a condition prior to executing the function. Modifiers are inheritable properties of contracts and may be overridden by derived contracts, but only if they are marked `virtual`. {Modifier Overridding} Functions modifiers can override each other. This words in the same way as functions overriding (except that there is no overloading for modifiers). The `virtual` keyword must be used on the overridden modifier and the `override` keyword must be used in the overridding modifier.
Modifiers are code that can be run before and/or after a function call.
Modifiers can be used to:
--> Restrict access
--> Validate inputs
--> Guard against reentrancy hack
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionModifier{
  //we will use these variables to demonstrate how to use modifiers
  address public owner;
  uint public x = 10;
  bool public locked;

  constructor(){
    //set the transaction sender as the owner of the contract
    owner = msg.sender;
  }

  //modifier to check that the caller is the owner of the contract
  modifier onlyOwner(){
    require(msg.sender == owner, "Not owner");
    //underscore is a special character only used inside a function modifier and it tells solidity to execute the rest of the code.
    _;
  }

  function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
    owner = _newOwner;
  }

  //Modifiers can be called before and/or after a function
  //This modifier prevents a function from being called while it is still executing.
  modifier noReentrancy(){
    require(!locked, "No Reentrancy");
    locked = true;
    _; //underscore is a special character only used inside a function modifier and it tells solidity compiler to execute the rest of the code
    locked = false;
  }

  function decrement(uint i) public noReentrancy {
    x -= 1;
    if(i > 1){
      decrement(i -1);
    }
  }
}
```
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//Function modifier - reuse code before and/or after function
//Basic
contract FunctionModifier{
  bool public paused;
  uint public count;

  function setPause(bool _paused) external{
    paused = _paused; //_paused is the parameter that get from external event
  }

  //Using modifier - Basic usage
  modifier whenNotPaused(){
    require(!paused, "paused");
    _; //to execulte the rest of the code
  }

  //Basic usage
  function inc() external whenNotPaused {
    count += 1;
  }

  function dec() external whenNotPaused {
    count -= 1;
  }

  //Passing an input using modifier
  //Using modifier - Passing input
  modifier cap(uint _x){
    require(_x < 100, "x >= 100");
  }

  function incBy(uint _x) external whenNotPaused cap {
    //require(_x < 100, "x >= 100"); //before using modifier
    count += _x
  }

  //Sandwich - Modifiers can execute code before and after the function
  modifier sandwich(){
    //Code run first 1st
    count += 10;
    _; //this line is used to call the main function (in this case will run foo() function)
    //Code run third 3rd, after run the main code
    count *= 2;
  }

  function foo() external sandwich {
    //Code run second 2nd, after the +=10 and before the *=2
    count += 1;
  }
}
```

===============
12. Constructor
A constructor is an optional function declared witht he `constructor` keyword which is executed upon contract creation, and where you can run contract initialisation code. Before the constructor code is exectued, state variables are initialised to their specified value if you initialise them inline, or their default value if you do not. The constructor is only called once when we deployed the contract amd it allows you to initialise the state variable of the contract.
After the constructor has run, the final code of the contract is deployed to the blockchain. The deployment of the code costs additional gas linear to the length of the code. This code includes all functions that are part of the public interface and all functions that are reachable from there through function calls. It does not include the constructor code or internal functions that are only called from the constructor. If there is no constructor, the contract will assume the default constructor, which is equivalent to `constructor(){}`. We can say more simple, a contstructor is an optional function that is executed upon contract creation. T
Here's the example:
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

//Base contract X
contract X {
  string public name;
  constructor(string memory _name){
    name = _name
  }
}

//Base Contract Y
contract Y {
  string public text;
  constructor(string memory _text){
    text = _text;
  }
}

//There are 2 ways to initialize parent contract with parameters

//Pass the parameters here in thhe inheritance list.
contract B is X("Input to X"), Y("Input to Y"){

}

contract C is X, Y{
  //pass the parameters here in the constructor, similiar to function modifiers
  constructor(string memory _name, string memory _text) X(_name)Y(_text){}
}

//Parent constructors are always called in the order of inheritance regardless of the order of parent contracts listed in the constructor of the child contract

//Order of constructore called: 
//1. X
//2. Y
//3. D
contract D is X, Y {
  constructor() X("X was called") Y("Y was called"){}
}

//Order of constructor called:
//1. X
//2. Y
//3. E
contract E is X, Y{
  constructor() Y("W was called") X("X was called"){}
}
```
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Constructor{
  address public contracOwner;
  uint public x;

  constructor(uint _x){
    contractOwner = msg.sender; //initialise that the public address is the address that deploy the contract
    x = _x; //and initialise that the x variable is the input _x
  }
}
```

===============
13. Ownable Smart Contract (Case #2)
This smart contract is used to claim the ownership  of the contract. This contract will have owner and only the owner will be able to set a new owner and there will be some functions where only the owner can call.
Step-by-step
1. declare a state variable called owner
2. initialize the owner to the caller that deployed this contract (initlialize the owner to msg.sender on constructor)
3. create a function modifier that only the owner can call the function (write the required that make sure the msg.sender is equal owner, and if not equal with the owner variable it will return a message "not owner", and then execute the rest)
4. Create a function to set the new owner that can only be called by the current owner (function setOwner, need single input that the input _newOwner address) and don't forget to attach the onlyOwner modifier function to make sure that this functions is only the current owner of this contract that can call/execute (make sure that the input _newOwner not the deployer address, which mean the address(0)/ zero address).
5. Next one, set/assign the current owner to the input _newOwner.
6. This contract is useful when you have some functions where anyone can call and some functions only the owner can call
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Ownable{
  address public owner;
 
  constructor(){
    owner = msg.sender; //assign/set that the owner is the deployer of this contract
  }

  //this modifier created to prevent another address can run/execute the code except the owner/currentowner
  modifier onlyOwner(){
    require(msg.sender == owner, "not owner");
    _; //execute the code after this modifier
  }

  //create the function set new owner that only the current owner that can run/execute
  function setOwner(address _newOwner) external onlyOwner{
    require(_newOwner != address(0), "invalid address");
    owner = _newOwner //assign/set the new owner with the input _newOwner addresss
  }

  //Create the function that can only run by owner and can run by anyone
  function onlyOwnerCanCallThisFunction() external onlyOwner {
    //code here
  }

  function anyoneCanCallThisFunction() external {
    //code here
  }
}
```

===============
14. Functions Outputs
There are several ways to return the functions output such as:
--> Return Multiple Outputs
--> Named Outputs
--> Desctructuring Assignment
Public functions cannot accept certain data types as inputs or outputs
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Function{
  //Functions can return multiple values
  function returnMany()
    public
    pure
    returns(
      uint, 
      bool,
      uint
    )
  {
    return (1, true, 3);
  }

  //Return values can be named.
  function named()
    public
    pure
    returns (
      uint x,
      bool b, 
      uint y
    )
  {
    return(1, true, 2);
  }

  //Return values can be assigned to their name. In this case the return statement can be omitted.
  function assigned()
    public
    pure
    returns(
      uint x,
      bool b,
      uint y
    )
  {
    x = 1;
    b = true;
    y = 3;
  }

  //Use desctructuring assignment whne calling another function that returns multiple values
  function destructuringAssignments()
    public
    pure
    returns (
      uint, 
      bool,
      uint, 
      uint, 
      uint 
    )
  {
    (uint i, bool b, uint j) = returnMany();

    //values can be left out.
    (uint x, , uint y) = (4,5,6);

    return(i, b, j,x,y);
  }

  //Cannot use map for either input or output

  //Can use array for input
  function arrayInput(uint[] memory _arr) public {}

  //Can use array for output
  uint[] public arr;

  function arrayOutput() public view returns (uint[] memory){
    return arr;
  }
}
```
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionOutputs{
  //1. Return Multiple Outputs
  function returnMultiple() public pure returns(uint, bool){
    return (1, true); //this return 2 variable uint 1 and bool true
  }

  //2. Return Named outputs
  function returnNamedOutputs() public pure returns(uint x, bool b){ //declaring the name after data type
    return (1, true); //this return 2 variable uint x = 1 and bool b = true
  }
  
  //2. Return Named Outputs by assigned -> save little bit of gas
  function returnNamedOutputsByAssignedTheValue() public pure returns(uint x, bool b){
    //this assigned code will save a little bit of gas because we help the compiler to make easier assign the value
    x = 1;
    b = true'
  }

  //3. Destructuring Assignment - Capture multiple outputs and then assign variables to it
  function destructuringAssignments() public pure {
    (uint x, bool b) = returnMultiple(); //this is a very basic way of capturing the output from a function by destructuring them.

    //Only need second output, not the first
    (, bool _b) = returnMultiple(); //you can do this by not declaring data ty eor the name of variable
  }
}
```

===============
15. Arrays
Arrays can have a compile-time fixed size, or they can have a dynamic size. The type of an array of fixed size k and element type T is written as `T[k]`, and and array of dynamic size as `T[]`. For example, and array of 5 dynamic arrays of `uint` is written `uint[][5]`. The notation is reversed compared to some other languages. In Solidity, `X[3]` is always an array containing three elements of type X, even if X is itself an array. This is not the case in other languages such as C.
Indices are zero-based, and access is in the opposite direction of the declaration. For example. if you have a variable `uint[][5] memory x`, you access the seventh uint in the third dynamic array using `x[2][6]`, and to access the third dynamic array, use `x[2]`. Again, if you have an array `T[5] a` for a type T that can also be an array, then `a[2]` always has type T.
Array elements can be of any type, including mapping or struct. The general restrictions for types apply, in that mappings can only be stored in the `storage` data location and publicly-visible functions need parameters that are ABY types. It is possible to mark state variable arrays `public` and have Solidity create a getter. The numeric index becomes a required parameter for the getter.
Accessing an array past its end causes a failing assertion. Methods `.push()` and `.push(value)` can be used to append a new element at the end of the array, where `.push()` appends a zero-initialized element and returns a reference to it.
====
## `bytes` and `string` as Arrays
Variables of type `bytes` and `string` are special arrays. The `bytes` type is similar to `bytes[]`, but it is packed tightly in calldata and memory. `string` is equal to `bytes` but does not allow length or index access. Solidity does not have string manipulation functions, but there are third party string libraries. You can also compare two strings by their keccak256-hash using `keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2))` and concatenate two strings using `string.concat(s1,s2)`. You should use `bytes` over `bytes[]` because it is cheaper, since using `bytes[]` in `memory` adds 31 padding bytes between the elements. Note that in `storage`, the padding is absent due to tight packing, see bytes and string. As a general rule, use `bytes` for arbitrary-length raw byte data and `string` for arbitrary-length string (UTF-8) data. If you can limit the length to a certain number of bytes, always use one of the value types `bytes1` to `bytes32` because they are much cheaper.
====
## The functions `bytes.concat` and `string.concat`
You can concatenate an arbitrary number of `string` values using `string.concat`. The function returns a single `string memory` array that contains the contents of the arguments without padding. If you want to use parameters of other types that are not implicitly convertible to `string`, you need to convert them into `string` first.
Analogously, the `bytes.concat` function can concatenate an arbitrary number of `bytes` or `bytes ... bytes32` values. The function returns a single `bytes memory` array that contains the content of the arguments without padding. If you want to use string parameters or other types that are not implicitly convertible to `bytes`, you need to convert them to `bytes` or `bytes1 /.../ bytes32` first.
```sol
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

contract C {
    string s = "Storage";
    function f(bytes calldata bc, string memory sm, bytes16 b) public view {
        string memory concat_string = string.concat(s, string(bc), "Literal", sm);
        assert((bytes(s).length + bc.length + 7 + bytes(sm).length) == bytes(concat_string).length);

        bytes memory concat_bytes = bytes.concat(bytes(s), bc, bc[:2], "Literal", bytes(sm), b);
        assert((bytes(s).length + bc.length + 2 + 7 + bytes(sm).length + b.length) == concat_bytes.length);
    }
}
```
If you call string.concat or bytes.concat without arguments they return an empty array.
====
## Allocating Memory Arrays
Memory arrays with dynamic length can be created using the `new` operator. As opposed to stroage arrays, it is not possible to resize memory arrays (e.g. the `.push` member functions are not available). You either have to calculate the required size in advance or create a new memory array and copy every element. As all variables in Solidity, the elements of newly allocated arrays are always initialized with the default value.
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract C {
  function f(uint len) public pure{
    uint[] memory a = new uint[](7);
    bytes memory b = new bytes(len);
    assert(a.length == 7);
    assert(b.length == len);
    a[6] = 8
  }
}
```
====
## Array - solidity by example
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Array{
  //Several wasy to initialize an array
  uint[] public arr;
  uint[] public arr2 = [1,2,3];
  
  //Fixed sized array, all elements initialize to 0 (default value)
  uint[5] public myFixedSizedArr;

  function get(uint i) public view returns(uint){
    return arr[i];
  }

  //Solidity can return the entire array. But this function should be avoided for arrays that can grow indefinitely in length, it will cost you more gas.
  function getArr() public view returns (uint[] memory){
    return arr;
  }

  function push(uint i) public{
    //Append to array, this will increase the array length by 1.
    arr.push(i);
  }

  function pop() public{
    //Remove last element from array, this will decrease the array length by 1.
   arr.pop();
  }

  function getLength() public view returns (uint){
    return arr.length;
  }

  function remote (uint index) public {
    //Delete does not change the array length. It reset the value at index to it's default value. In this case 0 (uint)
    delete arr[index];
  }

  function examples() external{
    //Create array in memory, only fixed size can be created
    uint[] memory a = new uint[](5); //with 5 sized
  }
}
```
============================
//Examples of removing array element, remove array element by shifting elements from right to left
============================
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ArrayRemoveByShifting{
  // [1,2,3] -- remove(1) >>> [1,3,3] --> [1,3]
  // [1,2,3,4,5,6] -- remove(2) >>> [1,2,4,5,6,6] --> [1,2,4,5,6]
  // [1,2,3,4,5,6] -- remove(3) >>> [1,2,3,5,6,6] --> [1,2,3,5,6]
  // [1] -- remove(0) >>> [1] --> []

  uint[] public arr;
  function remove(uint _index) public{
    require(_index < arr.length; "index out of bound");
    for(uint i = _index; i < arr.length - 1; i++){
      arr[i] = arr[i + 1]; //change the value after choosen index
    }
    arr.pop();
  }

=======================MEKANISME KERJA====================================
CONTOH #1
  [1,2,3].remove(1) -> _index = 1
  function remove(1) public{
    requrie(1 < 3; "index out of bound"); ==> hasilnya true, lanjut jalan proses berikutnya
    //Lap 1 -> Jalan
    for(uint i = 1; 1 < 3; i=2){  //condition true
       arr[1] = arr[1+1] // Nilai 2 diganti dengan 3 =hasilnya=> [1,3,3]
    }
    //Lap 2 -> Jalan
    for(uint i = 2; 2<3); i=3){  //condition true
       arr[2] = arr[2+1] // Nilai 3 diganti dengan 0, dimana 0 adalah value (default value) dari index ke-3 =hasilnya> [1,3,3]
    }
    //Lap 3 -> Tidak jalan
    for(uint i = 3; 3<3; i=4){  //condition false
      //Tidak jalan karena kondisi false
    }
    //Lalu menjalankan kode di bawah ini
    arr.pop() //[1,3,3].pop(); =hasilnya=> [1,3]
  }

CONTOH #2
  [1,2,3,4,5,6].remove(2) -> _index = 2
  function remove(2) public{
    require(2 < 6; "index out of bound"); ==> hasilnya true, lanjut jalan proses berikutnya
    //Lap 1 -> Jalan
    for(uint i = 2; 2<6; i=3){ //condition true
      arr[2] = arr[2+1] //Nilai 3 diganti dengan 4 =hasilnya=> [1,2,4,4,5,6]
    }
    //Lap 2 -> Jalan
    for(uint i = 3; 3<6; i=4){ //condition true
      arr[3] = arr[3+1] //Nilai 4 diganti dengan 5 =hasilnya=> [1,2,4,5,5,6]
    }
    //Lap 3 -> Jalan
    for(uint i = 4; 4<6; i=5){ //condition true
      arr[4] = arr[4+1] //Nilai 5 diganti dengan 6 =hasilnya=> [1,2,4,5,6,6]
    }
    //Lap 4 -> Jalan
    for(uint i = 5; 5<6; i=6){ //condition true
      arr[5] = arr[5+1] //Nilai 6 diganti dengan 6 =hasilnya=> [1,2,4,5,6,6]
    }
    //Lap 5 -> Tidak jalan
    for(uint i = 6; 6<6; i=7){ //condition false
      //Tidak jalan karena kondisi diatas false
    }
    //Lalu menjalankan kode di bawah ini
    arr.pop() //[1,2,4,5,6,6].pop() =hasilnya=> [1,2,4,5,6]
  }
=========================================================================
  function tes() external {
    arr = [1,2,3,4,5,6];
    remove(2); //[1,2,4,5,6];
    assert(arr[0] == 1);
    assert(arr[1] == 2);
    assert(arr[2] == 4);
    assert(arr[3] == 5);
    assert(arr[4] == 6);
  
    arr = [1];
    remove(0); //[]
    assert(arr.length == 0);
  }
}
```
============================
Remove array element by copying last element into to the place to remove
============================
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ArrayReplaceFromEnd{
  uint[] public arr;
 
  // Deleting an element createst a gap in the array. One trick to kepp the array compact is to move the last element into the place to delet.
  function remove(uint index) public{
    //Move the last element into the place to delete
    arr[index] = arr[arr.length - 1];
    //Remove the last element
    arr.pop();
  }

  function test() public{
    arr = [1,2,3,4,5]; length  = 5
    remove(2); //[1,2,4,5]
    assert(arr.length == 4);
    assert(arr[0] == 1);
    assert(arr[1] == 2);
    assert(arr[2] == 4);
    assert(arr[3] == 5);

    remove(1); // [1,4,5]
    assert(arr.length == 3);
    assert(arr[0] == 1);
    assert(arr[1] == 4);
    assert(arr[2] == 5);
  } 
}
```
====
## Array Smart Contract Programmer
--> Array - dynamic or fixed size (dynamic and fized size array  as a state variable)
--> Initialization an array by store with a variable
--> Insert(push), get, update, delete, pop, length
--> Creating array in memory (must be fixed size array)
--> Returning array from function (it can be worse, because the bigger arra the more gas will used). Summary you can write a function that returns an array but it is not recommended.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Array {
  uint[] public dynamicArray; //without data or dynamic empty array  
  uint[] public nums = [1,2,3] //with the data inside the array
  uint[3] public fixedArray; //without data, size can't be changed, the value of the data is default value
  uint[3] public numsFixed = [4,5,6];

  function example() external {
    //Update an Array -> mostly dynamic array, because we can't add the size of the fixed array
    //1. push -> add to the last element of array
    nums.push(77); //[1,2,3,77];
    //2. get/init
    uint x = nums[2]; //[3]
    //3. delete
    delete nums[2]; //[1,2,0,77] -> delete just  remove the value not remove the element, so the value will be 0
    //4. pop - remove the las element of array
    nums.pop(); [1,2,0]
    //5. length
    uint len = nums.length; //3

    //Create array in Memory
    uint[] memory a = new uint[](5); //the size array must be fixed size
    //will error
    //a.push(3);
    //a.pop();
    a[1] = 123;
  }

  function returnArray() external view returns(uint[] memory){
    return nums;
  }
}
```

===============
16. Array Remove an Element by Shifting
By Shift all elements to the left and then pop the last element.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ShiftArray{
  uint[] public array;

  //Shifting remove
  function remove(uint _index) public{
    require(_index < array.length, "index out of bound");
    for(uint i=_index; i<array.length; i++){
      arr[i] = arr[i+1];
    }
    array.pop(); //to put the last element of array after shifting process
  }
}
```

===============
17. Array Remove and Element By Replacing Last
Remove the element by pick index and change to the last element and then delete it (using pop()).
```sol
//SPDX-License-Identifier: MIT
contract ReplaceArray{
  uint[] public array;

  function remove(uint _index) public{
    array[_index] = array[array.length - 1] //put the choosen array to the last of element
    array.pop();
  }
}
```

===============
18. Mapping
In variable declarations, do not separate keyword `mapping` from its type by a space. Do not separate any nested `mapping` keyword from its type by whitespace.
YES
```sol
mapping(uint => uint) map;
mapping(adddress => bool) registeredAddresses;
mapping(uint => mapping(bool => Data[])) public data;
mapping(uint => mapping(uint => s)) data;
```
NO
```sol
mapping (uint => uint) map;
mapping( address => bool) registeredAddresses;
mapping (uint => mapping (bool => Data[])) public data;
mapping(uint => mapping (uint => s)) data;
```
====
## Mapping Types
Mapping types use the syntax `mapping(_KeyType => _ValueType)` and variables of mapping type are declared using the syntax `mapping(_KeyType => _ValueType) _VariableName.` The `_KeyType` can be any built-in valye type, bytes, string, or any contract or enum type. Other user-defined or complex types, such as mappings, structs or array types are not allowed. `_ValueType` can be any type, including mappings, arrays and structs. You can think of mappings as hash tables, which are virtually initialised such that every possible key exist and is mapped to a value whose byte-representation is all zeros, a type's default value. The similaritiy ends there, the key data is not stored in a mapping, only its `keccak256` hash is usde to look up the value.
Because of this, mappings do not have a length or a contept of a key or value being set, and therefore cannot be erased without extra information regarding the assigned keys (See Clearing Mappings). Mappings can only have a data location of `storage` and thus are allowed for state variables, as storage reference types in functions, or as parameters for library functions. They cannot be used as parameters or return parameters of contract functions that are publicly visible. These restrictions are also true for arrays and structs that contain mappings.
You can mark state variables of mapping type as `public` and Solidity creates a getter for you. The `_KeyType` becomes a parameter for the getter. If `_ValueType` is a value type or a struct, the getter returns `_ValueType`. If `_ValueType` is an array or a mapping, the getter has one parameter for each `_KeyType`, recuresively.
In the example below, the `MappingExample` contract defines a public `balances` mapping, with the key type an `address`, and a value type a `uint`, mapping an Ethereum address to an unsigned integer value. As `uint` is a value type, the getter returns a value that matches the type, which you can see in the `MappingUser` contract returns the value at the specified address.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MappingExample{
  mapping(address => uint) public balances;

  function update(uint newBalance) public{
    balances[msg.sender] = newBalance;
  }
}

contract MappingUser{
  function f() public returns (uint){
    MappingExample m = new MappingExample();
    m.update(100);
    return m.balances(address(this));
  }
}
```
====
The examples below is a simplified version of an ERC20 token. `_allowances` is an example of mapping type inside another mapping type. The example below uses `_allowances` to record the amount someone else is allowed to withdraw from your account.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MappingExample{
  mapping(address => uint256) private _balances;
  mapping(address => mapping(address => uint 256)) private _allowances;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, adddress indexed spender, uint256 value);

  function allowance(address owner, address spender) public view returns (uint 256){
    return _allowances[owner][spender]; //tunjangan dari owner ke spender
  }

  //Init the transaction _transfer mode true
  function transferFrom(address sender, address recipient, uint256 amount) public returns (bool){
    require(_allowances[sender][msg.sender] >= amount, "ERC20: Allowance not high enough");
    _allowances[sender][msg.sender] -= amount; //pengirim ke pihak ketiga
    _transfer(sender, recipient, amount)'
    return true;
  }

  //Transaction approval
  function approve(address spender, uint256 amount) public returns (bool){
    require(spender != address(0), "ERC20: approve to the zero address");
    _allowances[msg.sender][spender] = amount; //pihak ketiga ke penerima
    emit Approval(msg.sender, spender, amount);
    return true;
  }

  //Transfer
  function _transfer(addres sender, address recipient, uint256 amount) internal {
    require(sender != address(0), "ERC20: transfer from the zero address");
    require(recipient != address(0), "ERC20: transfer to the zero address");
    require(_balances[sender] >= amount, "ERC20: Not enough funds");

    _balances[sender] -= amount;
    _balances[recipient] += amount;
    emit Transfer(sender, recipient, eamount);
  }
}
```
====
## Iterate Mappings
You cannot iterate over mappings, ie. you cannot enumerate their keys. It is possible, though, to implement a data structure on top of them and iterate over that. For example, the code below implements and `IterableMapping` library that the `User` contract then adds data too, and the `sum` function iterates over to sum all the values.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

struct itmap{
  mapping(uint => IndexValue) data;
  KeyFlag[] keys;
  uint size;
}

library IterableMapping{
  function insert(itmap storage self, uint key, uint value) interal returns (bool replaced) {
    uint keyIndex = self.data[key].keyIndex;
    self.data[key].value = value;
    if(keyIndex > 0)
      return true;
    else {
      keyIndex = self.keys.length;
      self.keys.push();
      self.data[key].keyIndex = keyIndex + 1;
      self.keys[keyIndex].key = key;
      self.size++;
      return false;
    }
  }

  function remove(itmap storage self, uint key) internal returns (bool success) {
    uint keyIndex = self.data[key].keyIndex;
    if(keyIndex == 0)
      return false;
    delete self.data[key];
    self.keys[keyIndex - 1].deleted = true;
    self.size --;
  }

  function contains(itmap storage self, uint key) internal view returns (bool) {
    return self.data[key].keyIndex > 0;
  }

  function iterate_start(itmap storage self) internal view returns (uint keyIndex) {
    return iterate_next(self, type(uint).max);
  }

  function iterate_valid(itmap storage self, uint keyIndex) internal view returns (bool) {
    return keyIndex < self.keys.length;
  }

  function iterate_next(itmap storage self, unit keyIndex) internal view returns (uint r_keyIndex){
    keyIndex++;
    while(keyIndex < self.keys.length && self.keys[keyIndex].deleted)
      keyIndex++;
    return keyIndex;
  }

  function iterate_get(itmap storage self, uint keyIndex) internal view returns (uint kye, uint value){
    key = self.keys[keyIndex].key;
    value = self.data[key].value;
  }

  //How to use it.
  contract User {
    //Just a struct holding our data
    itmap data;
    //Apply library functions to the data type
    using IterableMapping for itmap;
  
    //Insert something
    function insert(uint k, uint v) public returns (uint size){
      //this calls IterableMapping.insert(data, k, v)
      data.insert(k, v);
      //We can still access members of the struct, but we should take care not to mess with them
      return data.size;
    }

    //Computes the sum of all stored data
    function sum() public view returns (uint s){
      for(
        uint i = data.iterate_start();
        data.iterate_valid(i);
        i = data.iterate_next(i); 
      ) {
        (, uint value) = data.iterate_get(i);
        s += value;
      }
    }
  }
}
```
====
## Mapping from Solidiy by Example
Maps are created with the syntax `mapping(keyType => valueType)`. `keyType` can be value types such as uint, address or bytes. `valueType` can be any type including another mapping or an array. Mappings are not iterable.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Mapping{
  //Mapping from address to uint
  mapping(address => uint) public myMap;

  function get(address _addr) public returns(uint){
    //Mapping always returns a value. If the value was never set, it will return the default value.
    return myMap[_addr];
  }

  function set(address _addr, uint _i) public{
    //Update the value at this address
    myMap[_addr] = _i;
  }

  function remove(address _addr) public {
    //Reset the value to the default value
    delete myMap[_addr];
  }
}

contract NestedMapping{
  //Nested mapping (mapping from address to another mapping)
  mapping(address => mapping(uint => bool))public nested;
  
  function get(address _addr1, uint _i) public view returns (bool) {
    //You can get values from a nested mapping even when it is not initialized
    return nested[_addr][_i];
  }

  function set(
    address _addr1,
    uint _i,
    bool _boo
  ) public {
    nested[_addr1][_i] = _boo;
  }

  function remove(address _addr1, uint _i) public {
    delete nested[_addr1][_i];
  }
}
```
====
## Smart Contract Programmer
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//Mapping, how to declare a mapping (simple and nested)
// Process in mapping, set, get and delete
contract Mapping {
  mapping(address => uint) public balances;
  mapping(address => mapping(address => bool)) public isFriend;

  function examples() external {
    balances[msg.sender] = 123;
    uint bal = balances[msg.sender];
    uint bal2 = balances[address[i]]; // 0

    balances[msg.sender] += 456; //123 + 456 = 579
    delete balances[msg.sender]; // return to default value = 0

    isFriend[msg.sender][adddress(this)] = true;
  }
}
```

===============
19. Iterable Mapping
Iterate is not the case for mappings, we cannot get the size of the maping and we cannot iterate it to get all of the elements of the mapping unless we internally keep track of all of the keys in the mapping. Here we will create the mapping that you can iterate, meaning that you'll be able to get the size of the mapping and you'll be able to run a for-loop to get all of the elements inside the mapping.
We're gonna need a mapping that keeps track whether a key is inserted or not.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract IterableMapping{
  mapping(address => uint) public balances;
  mapping(address => bool) public inserted;
  address[] public keys;

  function set(address _key, uint _val) external {
    balances[_key] = _val;

    if(!inserted[_key]){
      inserted[_key] = true;
      keys.push(_key)
    }
  }

  function getSize() external view returns (uint) {
    return keys.length;
  }

  function first() external view returns (uint) {
    return balances[keys[0]];
  }

  function last() external view returns (uint) {
    return balances[keys[keys.length - 1]];
  }

  function get(uint _i) external view returns (uint) {
    return balances[keys[_i]];
  }
}
```

===============
20. Struct
Struct are custom defined types that can group several variables. Solidity provides a wayt to define new types in the form of structs, which is shown in the following example
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//Voting dApp
contract Ballot {
  //This is the Struct
  struct Voter { 
    uint weight;
    bool voted;
    address delegate;
    uint vote;
  }
}

// Crowdfunding dApp
//Defines a new type with two fields. Declaring a struct outside a contract allows it to be shared by multiple contracts. Here, this is not really needed.

struct Funder{
  address addr;
  uint amount;
}

contract CrowdFunding {
  //Structs can also be defined inside contracts, which makes them visible only there and in derived contracts.
  struct Campaign {
    address payable beneficiary;
    uint fundingGoal;
    uint numFunders;
    uint amount;
    mapping(uint => Funder) funders;
  }

  uint numCampaigns;
  mapping(uint => Campaign) campaign;
  
  function newCampaign(address payable beneficiary, uint goal) public returns (uint campaignID){
    campaignID = numCampaigns++; //campaignID is return variable
    //We cannot use `campaigns[campaignID]=Campaign(beneficiary, goal, 0,0)` because the right hand side creates a memory-struct "Campaign" that contains a mapping.
    Campaign storage c = campaigns[campaignID];
    c.beneficiary = beneficiary;
    c.fundingGoal = goal;
  }

  function contribute(uint campaignID) public payable {
    Campaign storage c = campaigns[campaignID];
    //Creates a new temporary memory struct, initialised with the given values and copies it over to storage.
    //Note that you can also use Funder(msg.sender, msg.value) to initialise.
    c.funders[c.numFunders++] = Funder({
      addr: msg.sender,
      amount: msg.value
    });
    c.amount += msg.value;
  }

  function checkGoalReached(uint campaignID) public returns (bool reached) {
    Campaign storage c = campaigns[campaignID];
    if(c.amount < c.fundingGoal)
      return false;
    uint amount = c.amount;
    c.amount = 0;
    c.beneficiary.transfer(amount);
    return true;
  }
}
```
The contract does not provide the full functionality of a crowdfunding contract, but it contains the basic concepts necessary to understand structs. Structs types can be used inside mappings and arrays and they can themselves containt mapping and arrays. It is not possible for a struct to containt a member of its own type, although the struct itself can be the value type of a mapping member or it can contain a dynamically-sized array of its type. This restriction is necessary, as the size of the sturct has to be finite. 
Note how in all the functions, a struct type is assigned to a local variable with data location `storage`. This does not copy the struct but only stores a reference so that assignments to members of the local variable actually write to the state. Of course, you can also directly access the members of the struct without assigning it to a local variable, asn in `campaigns[campaignID.amount = 0]`.
{NOTE: Until Solidity 0.7.0, memory-structs containing members of storage-only types (e.g. mappings) were allowed and assignments like campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0) in the example above would work and just silently skip those members.}
====
## Struct Smart Contract Programmer
--> Defining a Struct, struct allow us to group data together.
2. Use in State Variables
3. Initialize
4. Get
5. Update
6. Delete
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Structs {
  //Define a struct that called Struct Car that contain prop model, year, and owner.
  struct Car{
    string model;
    uint year;
    address owner;
  }

  //Use the struct in a State Variables
  Car public car; //single variable
  Car[] public cars; //array car variable that called cars
  mapping(address => Car[]) public carsByOwner; //define owner to cars, and make owner can have multiple cars

  //How to Initialize a Struct, there 3 ways to initialize a struct
  function excamplesInitialization() external{
    //1. Same way to use function, put all parameters into parenthesis
    Car memory toyota = Car("Toyota", 1990, msg.sender) //write the parameter in the order of structs  
    
    //2. Using key-value pair - the order doesn't matter
    Car memory lambo = Carr({
      year: 2000,
      model: "Lamborghini",
      owner: msg.sender
    })

    //3. Using the empty init, and then put the value after that
    Car memory tesla; //It will hold the default value before you initialize it.
    //Put some data to tesla
    tesla.model = "Tesla";
    tesla.owner = msg.sender;
    tesla.year = 2020

    //*notes: the uses of memory indicates that this initialization will only run inside this function/ only works after the function excamplesInitialization called/execution, and after it finishes executing these structs will be gone

    //We can put those structs in a state variable, so that after we execute the function we'll able to get those structs from the smart contract by using push tehse structs into the Cars[]
    cars.push(toyota);
    cars.push(tesla);
    cars.push(lambo);

    //Immediately push the structs into the Cars[] similar to using memory
    cars.push(Car("Ferrari", 2020, msg.sender))

    //Get - the struct from the Cars array
    Car memory _car = cars[0] //using _car to avoid the same variable name
    _car.model;
    _car.year;
    _car.owner;

    //Update - the Struct data - we need to change the memory to storage, because memory means that we're loading this data onto memory so if we modify anything onto memory then when the function is done executing nothing is saved. Whereas storage would mean that we want to update the variable stored inside the smart contract.
    Car storage _car2 = cars[1]; //when we use the storage, the change will permanently
    _car2.year = 1933;

    //Delete - to reset the field stored in a struct
    Car storage _car3 = cars[2];
    delete _car3.year; //this will reset the owner of the car to have its default value
    delete cars[2]; //this will delete the car struct that is stored in the cars array the third element, meaning that whatever that is stored inside here will be reset to its default value
  } 
}
```
====
## Solidity By Examples
You can define your own type by creating a struct. They are useful for grouping together related data. Structs can be declared outside of a contract and imported in another contract.
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Todos {
  struct Todo {
    string text;
    bool completed;
  }

  //An array of 'Todo' struct;
  Todo[] public todos;
  
  function create(string memory _text) public {
    //3 ways to initialize a struct - calling it like a function
    todos.push(Todo(_text, false));

    //Key value mapping
    todos.push(Todo({
      text: _text,
      completed: false
    }));

    //Initialize an empty struct and then update it
    Todo memory todo;
    todo.test = _text;
    //todo.completed initialized to false

    todos.push(todo);
  }

  //Solidity automatically created a getter for 'todos' so you don't actually need this functino
  function get(uint _index) public view returns (string memory text, bool completed) {
    Todo storage todo = todos[_index];
    return(todo.text, todo.completed);
  }

  //Update Text
  function update(uint _index, string memory _text) public {
    Todo storage todo = todos[_index];
    todo.text = _text;
  }

  //Update Completed
  function toggleCompleted(uint _index) public {
    Todo storage todo = todos[_index];
    todo.completed = !todo.completed;
  }
}
```

===============
21. Enum
Using structs allow you to express multiple choices, for example boolean data types you can express true or false. But what if you need to express more choices, then enum is a great choice. Solidity supports enumerables and they are useful to model choice and keep track of state. Enums can be declared outside of a contract. 
```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Enum{ 
  //Enum that represents the shipping status, the value of this enum is the index number for each enum Status, None = 0, Pending = 1, Shipped = 2, Completed = 3, Rejected = 4, Canceled = 5. When you call the enum, it will return each index value. But when you call the reset function, the default value for the Status enum is the 0
  enum Status {
    None, //-> 0, meaning that there is no shipping request made yet
    Pending, // -> 1, meaning that it is getting processed
    Shipped, // -> 2
    Completed, // -> 3
    Rejected, // -> 4
    Canceled // -> 5
  }

  //Use enum as a state variable
  Status public status;
  
  //Use enum inside a struc
  struct Order {
    address buyer;
    Status status;
  }

  //And then create an array of orders
  Order[] public orders;

  //Returning enum from a function, so the function output will be enum
  function get() view returns (Status){
    return status; //this mean status from the state variable that define before
  }

  //Take enum as input, and then set the status to the enum from the input
  function set(Status _status) external {
    status = _status //Update the state variable
  }
 
  //Update a enum to a specific enum
  function ship() external {
    status = Status.Shipped; // This will update the state variable status to have a specific value of being Shipped
  }

  //Update to cancel status, you can update to a specific enum like this
  function cancel() public {
    status = Status.Canceled;
  }

  //Reset the enum to its default value by using delete
  function reset() external {
    delete status; //This will reset the status state variable which is enum to its default value
  }
}
```

===============
22. Deploy Any Contract
Deploy contract by calling `Proxy.deploy(bytes memory _code)`. For this example, you can get the contract bytecodes by calling `Helper.getBytecode1` and `Helper.getBytecode2`.
```sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Proxy{
  event Deploy(addres);

  fallback() external payable {}

  function deploy(bytes memory _code)  external payable returns (address addr){ 
    assembly {
      //create(v, p, n)
      // v = amount ot ETH to send
      // p = pointer in memory to start of code
      // n = size of code
      addr := create(callValue(), add(_code, 0x20), mload(_code));
    }
    // Return addres 0 on error
    require(addr != address(0), "deploy failed");

    emit Deploy(addr);
  }

  function execute(address _target, bytes memory _data) external payable {
    (bool success, ) = _target.call{
      value: msg.value
    }(_data);
    requre(success, "failed");
  }
}

contract TestContrac1{
  address public owner = msg.sender;
  
  function setOwner(address _owner) public{
    require(msg.sender == owner, "not owner");
    owner = _owner;
  }
}

contract TestContrac2{
  address public owner = msg.sender;
  uint public value = msg.value;
  uint public x;
  uint public y;
 
  constructor(uint _x, uint _y) payable {
    x = _x;
    y = _y;
  }
}

contract Helper {
  function getBytecode1() external pure returns (bytes memory){
    bytes memory bytecode = type(TestContrac1).creationCode;
    return bytecode;
  }

  function getBytecode2(uint _x, uint _y) external pure returns (bytes memory){
    bytes memory bytecode = type(TestContract2).creationCode;
    return abi.encodePacked(bytecode, abi.encode(_x, _y));
  }

  function getCalldata(address _owner) external pure returns (bytes memory) {
    return abi.encodeWIthSignature("setOwner(address)", _owner);
  }
}
```




























