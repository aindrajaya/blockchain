pragma solidity ^0.4.26;

library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}

contract StandardToken {
   using ERC20Lib for ERC20Lib.TokenStorage;

   ERC20Lib.TokenStorage token;

   string public name = "SimpleToken";
   string public symbol = "SIM";
   uint public decimals = 18;
   uint public INITIAL_SUPPLY = 10000;

   function StandardToken() {
     token.init(INITIAL_SUPPLY);
   }

   function totalSupply() constant returns (uint) {
     return token.totalSupply;
   }

   function balanceOf(address who) constant returns (uint balance) {
     return token.balanceOf(who);
   }

   function allowance(address owner, address spender) constant returns (uint) {
     return token.allowance(owner, spender);
   }

   function transfer(address to, uint value) returns (bool ok) {
     return token.transfer(to, value);
   }

   function transferFrom(address from, address to, uint value) returns (bool ok) {
     return token.transferFrom(from, to, value);
   }

   function approve(address spender, uint value) returns (bool ok) {
     return token.approve(spender, value);
   }

   event Transfer(address indexed from, address indexed to, uint value);
   event Approval(address indexed owner, address indexed spender, uint value);
 }
 
 library ERC20Lib {
  using SafeMath for uint;

  struct TokenStorage {
    mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allowed;
    uint256 totalSupply;
  }

  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);

  function init(TokenStorage storage self, uint256 _initial_supply) {
    self.totalSupply = _initial_supply;
    self.balances[msg.sender] = _initial_supply;
  }

  function transfer(TokenStorage storage self, address _to, uint _value) returns (bool success) {
    self.balances[msg.sender] = self.balances[msg.sender].sub(_value);
    self.balances[_to] = self.balances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(TokenStorage storage self, address _from, address _to, uint _value) returns (bool success) {
    var _allowance = self.allowed[_from][msg.sender];

    self.balances[_to] = self.balances[_to].add(_value);
    self.balances[_from] = self.balances[_from].sub(_value);
    self.allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  function balanceOf(TokenStorage storage self, address _owner) constant returns (uint balance) {
    return self.balances[_owner];
  }

  function approve(TokenStorage storage self, address _spender, uint _value) returns (bool success) {
    self.allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(TokenStorage storage self, address _owner, address _spender) constant returns (uint remaining) {
    return self.allowed[_owner][_spender];
  }
}

contract Ownable {

    // keeps the address of the account that created the contract
    address internal owner;

    /** @dev Constructor: instantiates onwership for derived contracts */
    function Ownable() public {owner = msg.sender;}

    // checks whether the sender is the owner of the contract. If not, the action is reversed and no gas is consumed.
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    /** @dev passes the ownership of the current contract to another address. Only the current owner can call this function.
        @param _newOwner The address of the new owner. 
        */
    function passOwnership(address _newOwner) internal onlyOwner { 
        require(_newOwner != 0x0);
        owner = _newOwner; 
    }

    /** @dev deactivates the current contract and returns all remaining ethers to the owner's address. Only the current owner can call this function. */
    function kill() internal onlyOwner {selfdestruct(owner);}

    /** @dev retrieves the address of the current owner.
        @return The address of the current owner. 
        */
    function getOwner() internal constant returns (address) {return owner;}    

}

/// @title SCH token contract (SCH)
contract SCHToken is StandardToken, Ownable {
    using SafeMath for uint256;

    // EVENTS

    event TransferableChanged(bool transferable);

    // PUBLIC FUNCTIONS

    function SCHToken(address[] _wallets, uint256[] _amounts, uint256 totalSupply)  {
        require(_wallets.length == _amounts.length && _wallets.length > 0);
        uint i;
        uint256 sum = 0;
        for (i = 0; i < _wallets.length; ++i) {
            sum = sum.add(_amounts[i]);
        }
        require(sum == __SCH_LIMIT);
        totalSupply = __SCH_LIMIT;
        for (i = 0; i < _wallets.length; ++i) {
            // balanceOf(_wallets[i] = _amounts[i]);
            balanceOf(_wallets[i]);
        }
    }

    // If ether is sent to this address, send it back
    function() { revert(); }

    // Check transferable state before transfer
    function transfer(address _to, uint _value) canTransfer returns (bool) {
        return super.transfer(_to, _value);
    }

    // Check transferable state before approve
    function approve(address _spender, uint256 _value) canTransfer returns (bool) {
        return super.approve(_spender, _value);
    }

    // Check transferable state before transfer
    function transferFrom(address _from, address _to, uint _value) canTransfer returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    /// @dev Called by the owner to change ability to transfer tokens by users.
    function setTransferable(bool _transferable) onlyOwner {
        require(transferable != _transferable);
        transferable = _transferable;
        TransferableChanged(transferable);
    }

    // MODIFIERS

    modifier canTransfer() {
        require(transferable || msg.sender == owner);
        _;
    }

    // FIELDS

    // Standard fields used to describe the token
    string public name = "SCH Token";
    string public symbol = "SCH";
    string public version = "H0.1";
    uint8 public decimals = 18;

    // At the start of the token existence it is transferable
    bool public transferable = true;

    // Amount of supplied tokens is constant and equals to 1 000 000 000 SCH
    uint256 private constant __SCH_LIMIT = 1000000000;
}


