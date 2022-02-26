INTRODUCTION TO SMART CONTRACTS
(https://docs.soliditylang.org/en/v0.8.12/introduction-to-smart-contracts.html?highlight=deploy%20contracts)
-----------------------------------------------------------
## A Simple Smart Contract
Let us begin with a basic example that sets the value of a variable and exposes it for othe contracts ato access. It is fine if you do not understand everything righ now, we will go into more detail later.

1. Storage Example
```sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 < 0.9.0;

contract SimpleStorage {
  uint storedData;
  
  function set(uint x) public {
    storedData = x;
  }

  function get() public view returns (uint){
    return storedData;
  }
}
```
The first line tells you that the source code is licensed under the MIT. Machine-readable license specifiers are imporatnt in a setting where publishing the soruce code is the default.
The next line specifiers that the source code is written for Solidity version 0.4.16, or a newer version of the language up to, but not including version 0.9.0. This is to ensure that the contract id not compilable with a new (breaking) compiler version, where it couild behave differently. Pragmas are common instructions for compilers about how to treat the source code (e.g. prgama once). 
A contract in the sense of Solidity is a collection of code (its functions) and data (its state) that resides at a specific address on the Ethereum blockchain. The line `unit storedData;` declares a state variable called `storedData` of type `uint` (unsigned integer of 256 bits). You can think of its as a single slot ina database that you can query and alter by calling functions of the code that manages the database. In this example, the contract defines the functions set and get that can be used to modify or retrieve the value of the variable.
To access a member (like a state variable) of the current contract, you don not typically add the `this` prefix, you just access it directly via its name. Unlike in some other languages, omitting it is not just a matter of style, it results in a completely different way to access the member, but more on this later.
This contract does not do much yet apart from (due to the infrastructure build by Ethereum) allowing anyone to store a single number that is accessible by anyone in the world without a (feasible) way to prevent you from publishing this number. Anyone could call set again witha  different value and overwrite your number, but the number is still stored in the history of the blockchain. Later, you will see how you can impose access restrictions so that only you can alter the number.
{WARNING: Be careful with using Unicode text, as similar looking (or event identical) characters can have different code points and such are encoded as a different byte array}
{NOTE: All identifiers (contract name, function names and variable names) are restricted  to the ASCII character set. It is ppossible to store UTF-8 encoded data in string variables}
====
## Subcurrency Example
The following contract implements the simplest form of cryptocurency. The contract allows only its creator to create new coins (different issuance schemes are possible). Anyone can send coins to each other withoiut a need for registering with a username, all you need is an Ethereum keypair.
```sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Coin {
  //The keyword "public" makes variables accessible from other contracts
  address public minter;
  mapping(address => uint) public balances;

  //Events allow clients to react to specific contract changes you declare
  event Sent(address from, address to, uint amount);
 
  //Constructor code is only run when the contrac is created
  constructor(){
    minter = msg.sender;
  }

  //Sends an amount of newly created coinst to an addres can only be called by the contract creator
  function mint(address receiver, uint amount) public{
    require(msg.sender == minter);
    balances[receiver] += amount;
  }

  //Errors allow you to provide information about why an operation failed. They are returned to the caller of the function
  error InsufficientBalance(uint requested,  uint available);

  //Sends an amount of existing coins from any caller to an address
  function send(address receiver, uint amount) public{
    if(amount > balances[msg.sender])
      revert InsufficientBalance({
        requested: amount,
        available: balance[msg.sender]
      });
    balances[msg.sender] -= amount;
    balances[receiver] += amount;
    emit Sent(msg.sender, receiver, amount);
  }
}
```
This contract introduces some new concepts, let us go through them one by one.
The line `address public minter;` declares a state variable of type addres. The `address` type is a 160-bit value that does not allow any arithmetic operations. It is suitable for storing addresses of contracts, or a hash of the public half of a keypair belonging to external accounts.
The keyword `public` automatically generates a function that allows you to access the current value of the state variable from outside of the contract. Without this keyword, other contracts have not way to access the variable. The code of the function generated by the compiler is equivalent to the following (ignore external and view for now)
```sol
function minter() external view returns (address) {return minter;}
```
You could add a function like the above yourself, but would you have a function and state variable with the same name. You do not need to do this, the compiler figures it out for your. The next line, `mapping(address => uint) public balances;` also creates a public state variable, but it is a more complex datatype. The mapping type maps addresses to unsigned integers. 
Mappings can be seen a hash tables which are virtually initialised such that every possible key exists from the start and is mapped to a value whose byte-representation is all zeros. However, it is neither possible to obtain a list of all keys of a mapping, nor a list of all values. Record what you added to mapping, or use it ina context where this is not needed. Or even better, keep a list, or use a more suitable data type.
The getter function creted by the public keyword is more complex in the case of a mapping. It looks like the following:
```sol
function balances(addres _account) external view returns (uint){
  return balances[_account];
}
```
You can use this function to query the balance of a single account.
The line `event Sent(addres from, address to, uint amount);` declares an "event", which is emitted in the last line of the function send. Ethereum clients such as web applicaitons can listen for these events emitted on the blockchain without much cost. As soon as it is emitted, the listener receives the arguments from, to and amount, which makes it possible to track transactions.
To listen for this event, yo could use the following javascript code, which uses web3.js to create the Coin contract object, and any user interfeace calls the automatically generated balances function from above:
```js
Coin.Sent().watch({}, '', function(error, result){
  if(!error){
    console.log("Coin transfer: "+result.args.amount+ " coins were sent from "+result.args.from+" to "+result.args.to+".");
    console.log("Balances now:\n"+
      "Sender: "+Coin.balances.call(result.args.from)+
      "Receiver: "+Coin.balances.call(result.args.to)
    );
  }
})
```
The constructor is a special function that is executed during the creation of the contract and cannot be called afterwards. In this case, it permanently stores the addres of the person creating the contract. The msg variable (together with tx and block) is a special global variable that contains properties which allow access to the blockchain. msg.sender is always the address where the current (external) function call came from. The functions that make up the contract, and that users and contracts can all are mint and send.
The `mint` function sends an amount of newly created coinst to another address. The require function call defines conditions that reverts all changes if not met. In this example, `require(msg.sender ==minter);` ensures that only the creator of the contract can call mint. In general, the creator can mint as many tokens as they like, but at some point, this will leadn to a phenomenon called "overflow". Note that because of the default Checked arithmetic, the transaction would revert if the expression `balances[receiver] += amount;` overflows, i.e., when `balances[receiver] + amount` in arbitrary precision arithmetic is larger than the maximum value of `uint(2**256 - 1)`. This is also true for the statement `balances[receiver] += amount;` in the function send.
Errors allow you to provide more information to thecaller about why a condition or operation failed. Erors are used together with the revert statement. The revert statement unconditionally aborts and reverts all changes similar to the require function, but it also allows you to provide the name of an error and additional data which will be supplied to the caller (and eventually to the frontend application or block explorer) so that a failure can more easily be debugged or reacted upon.
The send function can be used by anyone (who already has some of these coins) to send coints to anyone else. If the sender does not have enouth coints to send, the if conditon evaluates to true. As a result, the revert will cause the operation to fail while providing the sender with error details using the `InsufficientBalance` error.
{NOTE: If you use this contract ot send oinst to and address, you will not see anything when you look at that addres on a blockchain explorer, because the record that you sent coints and the changed balances are only stored in the data storage of this particular coin contract. By using events, you can create a "blockchain explorere" that tracks transactions and balances of your new coin, but you have to inspect the coint contract address and not the addresses of the coin owners}



























