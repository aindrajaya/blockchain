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

=============================
--> Oracles

=============================
--> Stablecoins

=============================
--> Automated Market Marker (DEX/ Decentralized Exchange)

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