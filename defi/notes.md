# MASTERING DEFI
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
//Code 1. Create Token Example
pragma solidity 0.7.4;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TokenGue is ERC20 {
  constructor() ERC20('Token Name', "TOKEN_TICKER"){}
}

contract TokenGua is ERC20{
  constructor() ERC20('Token Name', 'TOKEN_TICKER'){
    _mint(msg.sender, 100000);
  }
}

contract TokenGui is ERC20 {
  address public admin;
 
  constructor() ERC20('Token Name', "TOKEN_TICKER"){
    admin = msg.sender;
  }

  //Only admin that can mint the token
  function mint(address to, uint amount) external {
    require(msg.sender == admin, 'only admin');
    _mint(to, amount);
  }
}

contract TokenFaucet is ERC20 {
  constructor() ERC20('Token Name', 'TOKEN_TICKER'){}

  //Whoever call this function will get the token
  function faucet(adderss to, uint amount) external {
    _mint(to, amount);
  }
}

//Code 2. Contract A - Using Interface of ERC20
pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol'

//Code 3. Contract B - Send token to another contract
interface ContractB{
  function deposit(uint amount) external;
  function withdraw(uint amount) external;
}

contract ContractA {
  IERC20 public token;
  ContractB public contractB;

  constructor(address _token, addres _contractB){
    token = IERC20(_token);
    contractB = ContractB(_contractB);
  }

  //Keep a token inside contract
  function deposit(uint amount) external{
    token.transferFrom(msg.sender, addres(this), amount);
    token.approve(address(contractB), amount);
    contractB.deposit(amount);
  }

  //Withdraw token from contract
  function withdraw(uint amount) external{
    contractB.withdraw(amount);
    token.transfer(msg.sender, amount);
  }
}


```
=============================
--> ERC721
Can be used to more complex DeFi, such as insurrance, bond and derivatives. The standar from non-fungible assets. In game assets, some assets and characters. ERC721 tokens on DeFi it can be used on Insurance, Bonds, and Derivatives.
> [The safeTransferFrom function]
The `safeTransferFrom()` function is a public function that is used to safely transfer the NFT from the owner's account to the recipient account. Here, safely transfer means that, when a recipient is a contract, you need to ensure that the recipient contract has callbacks registered to let the receiver contract get a nitification when ERC721 token transfer is succestul.
This function takes the following argumensts:
>>>> `from`: The address of the current owner of the NFT
>>>> `to`: The address of the recipient who will receive the NFT
>>>> `tokenId`: `tokenId` of the NFT that is to be transferred\
>>>> `_data`>: The bytes data that is to be forwaded to the `ERC721Receiver` contract, if the address (recipient) is a contract. Make sure that the recipient contract has implemented the `ERC721Receiver` method.
`bytes4(keccak256("onERC721Received(address, addres, uint256, bytes)"))`
[EXAMPLE]
- Metadata ERTC721 -> tokenURI, notice a distinc Uniform Resource Identifier (URI) for a given asset. Throws if `_tokenId` is  not a valid NFT. URIs are defined in RFC3986. The URI may point to a JSON file that conforms to the "ERC721 Metadata JSON Schema"
This metadata Schema help us to save the image outside the blockchain, because when we stored images it will be take too much spaces
Two of differences ERC721 token and ERC20 is a ennumeration extention that not implement on the ERC20 token
```sol
pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

//Contract 1 - Just declaration
contract NFT1 is ERC721{
  constructor() ERC721('Token Name', 'Token_Symbol'){}
}

//Contract 2 - Mint some NFT in the Contsctructor
contract NFT2 is ERC721{
  constructor() ERC721('token name', 'TKN_SYMBL'){
    _safeMint(msg.sender, 0); //we check the recipient can handle the ERC721 token by using prefix safe
    _safeMint(msg.sender, 1); //mint one by one based on the tokenId
  }
}

//Contract 3 - Mint a function on the dedicated function not in the costructor
contract NFT3 is ERC721{
  addres public admin;

  constructor() ERC721('token name', 'TKN_SYM'){
    admin = msg.sender; //assign the admin to the deployer address
  }

  function mint(address to, uint tokenId) external { //make it external
    require(msg.sender == admin, 'only admin'); //make sure tha admin that only call this function
    _safeMint(to, tokenId); //call the mint process
  }
}

//Contract 4 - Faucet of ERC721
contract NFT4 is ERC721 {
  constructor() ERC721('token name', 'TKN_SYM'){}

  function faucet(address to, uint tokenId) external{ //Make external so it can call by anyone
    _safeMint(to, tokenId); //run the safeMint function
  }
}

//Contract 5 - Called the Faucet function from external address
import '@openzeppelin/contracts/token/ERC721/ERC721Holder.sol'; //to consume the NFTs
import '@openzeppelin/contracts/token/ERC721/IERC721.sol'; //interface

contract NFT4CallFirst is ERC721Holder { 
  IERC721 public token; //define the token that will be hold by holder

  constructor(address _token){ //address of each token
    token = IERC721(_token); //declare the token
  }
 
  //Function deposit to receive ERC721 
  function deposit(uint tokenId) external {
    token.safeTransferFrom(msg.sender, address(this), tokenId);
  }

  //Withdraw function
  function withdraw(uint tokenId) external {
    token.safeTransferFrom(address(this), msg.sender, tokenId);
  }
}

//Contract 6 - Forwarding a token to Another Address/contract address
contract NFT4CallForwarding is ERC721Holder { //Get the token from the first and next holder
  function deposit(uint tokenId) external;
  function withdraw(uint tokenId) external;
}

contract NFT4CallFirst is ERC721Holder { 
  IERC721 public token; //define the token that will be hold by holder
  ContractB public contractB; //define a var for that contract B

  constructor(address _token, address _contractB){ //address of each token
    token = IERC721(_token); //declare the token
    contractB = ContractB(_contractB);
  }
 
  //Function deposit to receive ERC721 
  function deposit(uint tokenId) external {
    token.safeTransferFrom(msg.sender, address(this), tokenId);
    token.approve(address(contractB), tokenId); //Approve the request from the contract B
    contractB.deposit(tokenId); //Execution the deposit function
  }

  //Withdraw function
  function withdraw(uint tokenId) external {
    contractB.withdraw(tokenId); //Execute the withdraw function that called from another contract
    token.safeTransferFrom(address(this), msg.sender, tokenId);
  }
}
```
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
Asset-backed tokens are digital claims on a physical asset and are backed by that asset. Gold, crude oil, real estate, soybeans or just about any other real, physical asset can be tokenized and become an asset-backed token. Asset-backed tokens are an evolution made possible by blockchain technology.
And what is collateral token, in cryptocurrency, collateral token are used as a risk mitigations asset when borrowing other types of crypto tokens. Just like with collateral used in traditional finance, collateral tokens server as a risk-mitigating asset for lenders when borrowers want to get a crypto-loan.
ETB- are a generalization of the idea use for WETH token, will be used for many cases such as Liquidity Provider tokens.
Ex. send some collateral, add and create to your address. Same as the WETH.
```sol
pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract CollateralBacked is ERC20{
  IERC20 public collateral;
  uint public price = 1; //This amount can depend on the natural value of Collateral backed token that you build, such as gas, oil, gold etc

  constructor(address _collateral) ERC20('Collateral Backed Token', 'CBT'){
    collateral = IERC20(_collateral);
  }

  function deposit(uint colalteralAmount) external {
    collateral.transferFrom(msg.sender, address(this), collateralAmount);
    _mint(msg.sender, collateralAmoun * price);
  }

  function withdrwa(uint tokenAmount) external{
    require(balanceOf(msg.sender) >= tokenAmoun,  'balance too low');
    _burn(msg.sender, tokenAmount);
    collateral.transfer(tokenAmoun /price);
  }
}
```

=============================
--> Oracles
Oracles are data feeds that connect Ethereum off-chain, real-world information so that you can query data in your smart contracts. For example, prediction market dapps use oracles to settle payments based on events. A prediction market may ask you to bet your ETH on who will become the next president of US. 
An oracle is bridge between the blockchain and the real world. They act as on-chain APIs you can query to get information into your smart ctonracts. This could be anything from price informatoin to weather reports. Oracles can also be bi-directional, used to "send" data out to the real world.
And the DeFi oracles are a 3rd party service enabling blockchain smart contracts to access external, real-world data. The oracle gives the smart contract the capacity to access a live feed of information that is no on the blockchain, such as real-time asset prices.
Data Flow:
1. Oracle API will request to the external Data API
2. The external Data API will response the request that created by Oracle API (off-chain)
3. The Oracle API send the report data to the Oracle inside the Ethereum Blockchin
4. And the when the user send transaction to the blockchain by send to the Oracle Smart(on-chain) contract, need to register a callback in the oracle Smart contract
5. The user will be request the data form DApp that connecting to the Oracle (on-chain) smart contract
6. And then the Oracle will send back/ response the request data from dApp
Solidity code example. Oracle system pull base oracle
```sol
//Oracle.sol -> base oracle smart contract
pragma solidity 0.7.3;

contract Oracle{
  //Data structure for the data that will be report
  struct Data{
    uint date; //date when we report the actuall data
    uint payload; //payload will be the actuall data
  }

  address public admin;
  mapping(address => bool) public reporters; //address reportet, that allowed to report the data, avoid to anybody to report the data
  mapping(bytes32 => Data) public data; //store reported data, by using byte32 that can store any arbitrary data, easy to manipulate
  
  constructor(address _admin){
    admin =_admin;
  }

  //Admin can update the reporters
  function updateReporter(address reporter, bool isReporter) external {
    require(msg.sender == admin, 'only admin');
    reporters[reporter] = isReporter; //To updated the reporter data using boolean
  }
 
  //Reporter update the data
  function updateDate(byes32 key, uint payload) external {
    require(reporters[msg.sender] == true, 'only reporters');
    data[key] = Data(block.timestamp, payload); //The data will inside the local smart contract

  //Get the data to dApp
  function getData(bytes32 key) external view returns(
    bool resul,
    uint date, 
    uint payload //or you can change to byte32
  ){
    if(data[key].date == 0){ //If false, we don't have mapping
      return(false,0 ,0);
    }
    return(true, data[key].date, data[key].paylad);
    }
  }
}

//IOracle.sol -> Oracle interface smart contract
pragma solidity 0.7.3;

interface IOracle{
  function getDate(bytes32 key)
    external
    view
    returns(
      bool result, 
      uint date, 
      uint payload
    );
}

//Consumer.sol -> dApp smart contract
pragma solidity 0.7.3;

import './IOracle.sol';

contract Consumer {
  IOracle public oracle;
  constructor(address _oracle){
    oracle = IOracle(_oracle);
  }

  function foo() external{
    bytes32 key = keccak256(abi.encodePacked(BTC/USD));

    (bool result, uint timestamp, uint data) = oracle.getData(key);
    require(result == true, 'could not get price');
    require(timestamp >= block.timestamp = 2 minutes, 'price too old');
    //Do something with the price
  }
}
```

=============================
--> Stablecoins
A stablecoin is a type of cryptocurrency that relis on a more stable asset as a basis for its value. Most commonly, people refer to stable coins as linked to a fiat curerncy, such as the USD, but they can also have value linked ot precious metals or other cryptocurrencies. Just like the derifatives. Keeping the same value of the market, 1USD = 1 USDT. Implement the ERC20.
>Use Cases for Stablecoins:
- Quote Currency: token A/ETH
- Collateral: bind the real world asset
- Merchan Payments: keep the value
>Stablecoin types:
- Fiat-backed stablecoins: quote and quote with the real fiat-currency, the stablecoin company should reserve the enough amount of the fiat currency to create a stablecoin
- Crypto-backed stablecoins: lock some crypto collateral
- Algorithmic stablecoins: Do not have backed reserve, an algorithmic srtablecoin is one that uses total supply manipulations to maintain a peg, rely on the elastic supply to maintain supply of the stablecoin. If the price high, will mint some new token, otherwise, if the price to low smart contract will burn some token.
>Difference between Stablecoin Type:
example, market cap, exchange support, decentralization, resever transparency, price stable
FIAT: USDT USDX, 28Billion, Excellent, Poor, Poor, Excellent
CRYPTO: DAI, 1B, Good, Good, Excellent, Good
ALGO: Ampleforth basiscash, ~300M, Poor, Excellent, N/A, TBD

=============================
--> Automated Market Marker (DEX/ Decentralized Exchange)
Automated market markers are a part of decentralized exchanges (DEXs) that were introduced to remove any intermediaries in the trading of crypto assets. You can think AMM as a computer programme that automates the process of providing liquidity.
>How it works,
An automated market marker (AMM) is a tool used to provide liquidity in decentralized finance (DeFi). The are used to enable the automatic trading of digital assets. They do this by using liquidity pools as a replacement for traditional buiyer and seller markets. Before AMMs, people had to use order books to trade.
>Example of AMM
Uniswap, considering how it is among the most well-funded DeFi protocols out ther. Despite what you've heard, Uniswap is an automated market makers (AMM) as well as a decentralized exchange.
>Example Calculate
equation of ETH/DAI => (100 - ethToBuy) * (65000 + daiToSpend) = 6500000
How much DAI we need to get 10ETH
Example:
```
daiToSpend = 65000000 / (100-10) - 65000 = 7222
=> ETH/DAI price = 7222/10 = 722.2 DAI to spend if you want to change to ETH
```
When we calculate the exchange, there are a slippage happen. Or we can called slippage tolerance. Slippage Tolerance is the pricing difference betweet the price at the confirmation time and the actual price of the transaction users are wiling to accept when swapping on AMMs. Slippage tolerance is set as a percentage of the total swap value.
There are Impermanent Loss,  IL is the risk that liquidity provider take in exchange for fees they earn in liquidity pools. If IL exceeds fees earned by a user when they withdraw, it means the user has suffered negative returns compared with simply holding their tokens ouside the pool.

=============================
--> Liquidity Mining
Liquidity mining is a process in which crypto holders lend assets to a decentralized exchange in return for rewards. These rewards commonly stem from trading fees that are accrued from tradeers swapping tokens.
Attracting liquidity
>How it Works
Liquidity Mining is a decentralized finance mechanism where in participanst provide some of their crypto assets into various liquidity pools, from which they're rewarded with tokens and fees. You can provide liquidity by depositing crypto in a trading pair and earning the rewards from trading fees. Users have to pay a small fee for swapping tokens in a trading pair. The small fees serves as the source of rewards for liquidity providers. 

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