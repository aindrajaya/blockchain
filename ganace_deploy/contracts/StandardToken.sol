pragma solidity >=0.4.21 < 0.7.2;


import './ERC20Lib.sol';

/**
 * Standard ERC20 token
 *
 * https://github.com/ethereum/EIPs/issues/20
 * Based on code by FirstBlood:
 * https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */

 contract StandardToken {
   using ERC20Lib for ERC20Lib.TokenStorage;

   ERC20Lib.TokenStorage token;

   string public name = "SimpleToken";
   string public symbol = "SIM";
   uint public decimals = 18;
   uint public INITIAL_SUPPLY = 10000;

   function StandardToken() public{
     token.init(INITIAL_SUPPLY);
   }

   function totalSupply() public view returns (uint) {
     return token.totalSupply;
   }

   function balanceOf(address who) public view returns (uint) {
     return token.balanceOf(who);
   }

   function allowance(address owner, address spender) public view returns (uint) {
     return token.allowance(owner, spender);
   }

   function transfer(address to, uint value) public returns (bool ok) {
     return token.transfer(to, value);
   }

   function transferFrom(address from, address to, uint value) public returns (bool ok) {
     return token.transferFrom(from, to, value);
   }

   function approve(address spender, uint value) public returns (bool ok) {
     return token.approve(spender, value);
   }

   event Transfer(address indexed from, address indexed to, uint value);
   event Approval(address indexed owner, address indexed spender, uint value);
 }