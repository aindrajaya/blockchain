# Ethereum Improvement Proposals - ERC-20 TOKEN
---
## Contents
### Simple Summary
A standard interface for tokens

### Abstract
The following standard alllows for the implementaion of a standard API for tokens within smart contracts. This standard provides basic functionality to transfer tokens, as well as allow tokens to be approved so they can be spen by another on-chain third party.

### Motivation
A standard interface allows any tokens on Ethereum to be re-used by other applications: from wallets to decentralzied exchanges.

### Specification
#### Token
  - Methods
    Notes:
    - This following specifications sue syntax from Solidity 0.4.17 (or above)
    - Callers MUST `handle` false from `returns (bool success)`. Callers MUST NOT assume that false is never returned!
    [name]
    Returns the name of the token, e.g. `MyToken`.
    OPTIONAL: This method can be used to improve usability, but interfaces and other contracst MUS NOT expect these values to be present.
```sol
function name() public view returns (string)
```
    [symbol]
    Returns the symbol of the token, e.g. "MTK"
    OPTIONAL: This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
```sol
function symbol() public view returns(string)
```
    [decimals]
    Returns the number of decimals the token users - e.g., `8`, means to divide the token amount by `1000000` to get its user representation.
    OPTIONAL: This method can be  used to improved usability, but interfaces and other contracs MUST NOT expect these values to be present.
```sol
function decimals() public view returns(uint8)
```   
    [totalSupply]
    Returns the total token supply
```sol
function totalSupply() public view returns(uint256)
```
    [balanceOf]
    Returns the account balance of another account with address `_owner`
```sol
function balanceOf(adderss _owner) public view returns (uint256 balance)
```
    [transfer]
    Transfer `_value` amount tokens to addres `_to`, and MUST fire the `Transfer` event. The function SHOULD `throw` is the message caller's account balance does not have enough tokens to spend.
    NOTE: Transfer of 0 values MUST be treated as normal transfers and fire the `Transfer` event.
```sol
function transfer(address _to, uint256 _value) public returns (bool success)
```
    [transferFrom]
    Transfer `_value` amount of tokens from addres `_from` to address `_to`, and MUST fire the `Transfer` event.
    The `transferFrom` method is used for a withdraw workflow, allowing contracts to transfer on your behaldf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge gees in sub-currencies. The function SHOULD `throw` unless the `_from` account has deliberately authorized the sender of the messages via some mechanism.
    NOTE: Transfer of 0 values MUST be treated as normal transfers and fire the `Transfer` event.
```sol
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
```
    [approve]
    Allows `_spender` to withdraw from your account multiple times, up to the `_value` amount. If this function is called again it overwrites the current allowance with `_value`.
    NOTE: To prevent atack vectors like the one described here and discussed here, clients SHOULD make sure to create interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender. THOUGH the contract itself shouldn't enforce it, to allow backwards compatibility with contracts deployed before.
```sol
function approve(addres _spender, uint256 _value) public returns (bool success)
```
    [allowance]
    Returns the amount which `_spender` is still aloowed to withdraw from `_owner`
```sol
function allowance(adderss _owner, addres _spender) public view returns (uint256 remaining)
```
--- 
  - Events
    [Transfer]
    MUST trigger when tokens are transferred, including zero value transfers. A token contract which creates new tokens SHOULD trigger a Transfer event with the `_from` address set to `0x0` when tokens are created.
```sol
event Transfer(address indexed _from, address indexed _to, uint256 _value)
```
    [Approval]
    MUST trigger on any successful call to `approve(address _spender, uint256 _value)`
```sol
event Approval(address indeced _owner, addres indexed _spender, uint256 _value)
```
---
### Implementation
There are already plenty of ERC20-compliant tokens deployed on the Ethereum network. Different implementations have been written by various teams that have different trade-offs: from gas saving to improved security. Example from openzeppelin and consensys
### History
### Copyright
