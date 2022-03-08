MASTERING DEFI
Huge Opportunity, but have easy to get los, so we must have
an Action Plan
1. The fundamental Concepts
=============================
--> ERC20, solidity, and how to do token transfer
For the DeFi, erc20 token can be representing 
_Protocol Ownership, in the projects we give you right to a share of the profit, or some for of divident
_Governance, be used to governance token, voting shares.
and 
_IOU token, get IOU token after invest  some other token in the token (liquidity provider) token, can be used in online game.
_Token standard at https://eips.ethereum.org/EIPS/eip-20
_Schema
Investor(Owner)
1. approve(spender(defi protocol), amount)
2. deposit(amount) -> to the DeFi protocol(spender)
3. transferFrom(owner(investor), spender(defi protocol), amount)
4. ERC20 Token
```sol
Code 1. Create Token Example
Code 2. Contract A
Code 3. Contract B
```
=============================
--> ERC721
Can be used to more complex DeFi, such as insurrance, bond and derivatives

=============================
--> Wrapped Ether
is used as a replacement eth in a lot of DeFi. Decentralized Exchanges, deal mainly 2 kinds of assets ERC20 and Ether, but it will need more complex solution to implemented it. So the WETH is the bridge to implemented 2 assets in Decentralzied Exchanges. 
Wrapped Ether (WETH) is a token pegged to Ether(ETH). WETH is used in several platforms and DApps that support ERC-20 tokens. While ETH is used to pay for network transactions fees, it doesn't have the same functionality as ERC20 tokens. You can easilty convert ETH into WETH through a process known as wrapping.
`Weth.sol`
```sol
pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Weth is ERC20{
  constructor() ERC20('Wrapped Ether', 'WETH'){} //

  function deposit() external payable{
    _mint(msg.sender, msg.value); //value of the ether that will be send and wrapped
  }

  function withdraw(uint amount) external{
    require(balanceOf(msg.sender) >= amount, 'balance too low'); //check the balance of the sender
    _burn(msg.sender, amount); //to burn the wrapped token ether of the sender automatically calculated based on amount that you want to send
    msg.sender.transfer(amount);
  }
}
```

=============================
--> Collateral backed Token

=============================
--> Oracles

=============================
--> Stablecoins

=============================
--> Automated Market Marker (DEX)

=============================
--> Liquidity Mining

=============================
--> Staking

=============================
--> Yield Farming

=============================
--> Flashloans

=============================
--> DAO


2. The Main DeFi Protocols (EVM)
3. DeFi Projects
4. 