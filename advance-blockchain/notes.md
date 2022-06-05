# Advanced Solidity: Understanding and Optimizing Gas Costs
----
## Section 1: Overview Gas Cost
1. Introduction
Gas costs depends on exactly four things during execution:
  * One is the transaction data tha was sent 
  * Two is the amount of memory that was used
  * Three is the state changes that took place
  * Four is the upgrades that were executed
You'll know the bad design pattenrs that you should be avoiding. Will know how to discover novel gas saving solutions on your own. And you'll recognize quickly when inefficiencies exist. Remix, openzeppelin and intro solidity, these are things that you should know already before take this course.
Mastering Ethereum devleopme requires three areas that you should be really good at:
  * One is knowing what really good design patterns are like. 
  * Two is security, and 
  * Three is optimizing gas costs
---
2. Calculating The Cost of an Ethereum Transfer.
How to compute the Transaction fee? The Transaction fee is the product of the gas used by the transaction x(dikali) the gas prices.
The gas price is iven in units of ether, when the people describe the gas price, they will often do it in units of gwei and one gwei. What you need to know for now is that whenever you transfer Ethereum, it always costs exactly 21000 gas. However, the gas price changes depending on network conditions, this is how much you pay the miners to get your transaction mined. After IP 1559 went into effect the gas calculation formula is a little bit more complicated.
---
3. Smart Contrat Interactions pt 1: What 21000, what exactly mean transaction is 21000 gas.
You can thing of gas as measuring a unit of computation or very roughly how many CPU cycles it takes to execute a certain computation. You can start to get an intuition about how transaction complexity and gas costs are correlated with each other.
---
4. Smart Contract Interactions pt 2
Need to note that the same transaction on the smart contract twill not always thave exaclty the same gas costs. When you are conducting a transaction on Ethereum, even if its' the same method, on the same smart contract, the exact computation that is carried out is not 100% identical all of the time. The same protocol, but a different implementation will often have a different cost.
---
5. Smart Contract Interactions pt 3
Formula of Transaction Feee
Ops		Gas Cost	Gas Price 	EthPrice	Fee
Eth transfer	   21000	   100		  3000		$6.30
Transfer USDC	   60825	   100		  3000		$18.25
Mint Boreape	  173576	   100		  3000		$52.07
trx boreape	  113071	   100		  3000		$33.92
buy on opensea	  242499	   100		  3000		$72.75
uniswap		  107061	   100		  3000		$32.12
tornado cahs	  984170	   100		  3000		$295.25
It needs to divide billions when convert to eth price
---
6. Heavy and Light Functions
example
```sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Simple{
  uint256 private x = 10;

  function light() external view returns(uint256){
    return x +1;
  }

  function heavy() external view returns(uint256){
    bytes32 _x = keccak256(abi.encodePacked(x));
    for(uint256 i = 0; i < 50; i++){
      _x = keccak256(abi.encodePacked(x));
    }
    return uint256(_x);
  }
}
```
The light function will costs 23673 gas, this cost more than a transfer on a Ethereum because all transactions on a ethereum must cost at lease 21000 gas. So in additiov to the transaction cost, which is 21000 gas, we're paying an additional 2000 plus in gas.
The heavy operations costs, is much higher 53173. But when we decrease the looping for this operations it will costs 38507. Because half operation doesn't need to execute.


## Section 2: Storage

## Section 3: Memory Costs

## Section 4: Solidity Tricks