# CREATE YOUR FIRST SMART CONTRACT
[Link](https://app.buildspace.so/projects/CO02cf0f1c-f996-4f50-9669-cf945ca3fb0b)
---
## Get Started
- 🛠 What will you be building?
You'll be building a website that I'll calling the WavePortal --- it'll a place where anyone on the internet can learn a litle about who you are and send you a 👋 + a message and have that data saved on the blockchian through an Ethereum smart contract. (A smart contract is basicaly code that lives on the blockchain you can read and write from, we'll talk about this more in a bit)
You'll be writing + deploying the smart contract and you'll also be building the website that will let people actually connect their wallets and iteract with your smart contract. We're going to make this a little spicy as well. Basically, when someone waves at you there is a random chance they can win a small amount of ETH from your site. You'll be able to customze the website as much as you want. For example:
  - Maybe instead of a 👋 you want people to send you a 💩.
  - Perhaps instead of a plain old message, you want them to send you a Spotify link and create a place where anyone can send you awesome music and have it saved.
  - You can change the smart contract to recognize when one of your friends is waving at you (based on their Ethereum wallet address) and then take them to a page where they get Rick Roll'd.
You can do whatever you want :).
By the end, you'll have a site you can show off and actually have people use. Your fellow classmates will be your first users!

## Write and deploy your WavePortal smart contract to a Local Ethereum network
- Get your local Welcome networking running
✅ Setup your env to start working w/ the blockchain
Before anything, we'll need to get our local Ethereum network working. This is how we can compile and test our smart contract code! You know how you need to spin up a local environment to work on it? Same deal here! For now, all you need to know is that a smart contract is a piece of code that lives on the blockchain. The blockchain is a public place where anyone can securely read and write data for a fee. Think of it sorta like AWS or Heroku, except no one actually owns it!
So in this case, we want people to 👋 at us. The bigger picture here is:
  1. We're going to write a smart contract. That contract has all the logic around how the 👋 s are handled. This is like your server code.
  2. Our smart contrac to write will be deplyed to the blockchain. This way, anyone in the world will be able to access and run our smart cotnract (if we give them permisson to do so). So, pretty much like a server :)
  3. We're going to build a client website that will let peopl easily interact with our smart contract on the blockchain.
I'll explain certain things in-depth as needed (ex. how mining works, how smart contracts are compiled and run, etc) but for now let's just focus on getting stuff running. If you have any issues throughout here, just drop a message on Discord in  #section-1-help. 
✨ The magic of Hardhat
1. We're goint to be using a tool called Hardhat a lot. This will let us easily spin up a local Ethereum network and give us fake test ETH and fake test accoutns to work with. Remember, its' just like a local server, except the "server" is the blockchain.
2. Quickly compile smart contracts and test them on our local blockchain.
First you'll need to get node/npm. If you don't have it head over here.
We recommend running Hardhat using the current LTS Node.js version or you may run into some issues! You can find the current releases here.
Next, let's head to the terminal (Git Bash will not work). Go ahead and cd to the directory you want to work in. Once you're there run these commands:
```bash
$ mkdir my-wave-portal
$ cd my-wave-portal
$ npm init -y
$ npm install --save-dev hardhat
```
👏 Get sample project going 
Cool, now we should have Hardhat. Let's get a sample project going.
Run:
```bash
$ npx hardhat
```
Note: if you have yarn installed along with npm, you may get errors such as npm ERR! could not determine executable to run. In this case, you can do yarn add hardhat. Choose the option to create a sample project. Say yes to everything. The sample project will ask you to install hardhat-waffle and hardhat-ethers. These are other goodies we'll use later :).
Go ahead and install these other dependencies just in case it didn't do it automatically.
```bash
$ npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
```
Finally, run npx hardhat accounts and this should print out a bunch of strings that look like this:
0xa0Ee7A142d267C1f36714E4a8F75612F20a79720
These are Ethereum addresses that Hardhat generates for us to simulate real users on the blockchain. This is going to help us a ton later in the project when we want to simulate users 👋-ing at us!
🌟 Run it
To make sure everything is working, run:
```bash
$ npx hardhat compile
```
Then run:
```bash
$ npx hardhat test
```
You should see something like this:
🚨 Before you click "Next Lesson"
 
- Write your first smart contract in Solidity
👩‍💻 Let's write a contract
Awesome, we made it. We're just going to hop right into our projects. Let's build a smart contract that lets us send a 👋 to our contract and keep track of the total # of waves. This is going to be useful because on your site, you mgith want to keep trackt of this #1 Fele free to change this to fit your use case. Create a file named WavePortal.sol under the contracts directory. File structure is super important when using Hardhat, so, be careful here! We're going to start out with the structure every contract starts out with.
```sol
// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal{
  constructor(){
    console.log("Yo yo, I am a contract and I am smart");
  }
}
```
Note: You may want to download the VS Code Solidity extension for easy syntax highlighting here.
```sol
// SPDX-License-Identifier: UNLICENSED
```
Just a fancy comment.  It's called a "SPDX license identifier", feel free to Google what it is :).
```sol
pragma solidity ^0.8.0;
```
This is the version of the Solidity compiler we want our contract to use. It basically says "when running this, I only want to use version 0.8.0 of the Solidity compiler, nothing lower. Note, be sure that the compiler version is the same in hardhat.config.js.
```sol
import "hardhat/console.sol";
```
Some magic given to us by Hardhat to do some console logs in our contract. It's actually challenging to debug smart contracts but this is one of the goodies Hardhat gives us to make life easier.
```sol
contract WavePortal {
    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }
}
```
So, smart contracts sort of look like a class in other languages, if you've ever seen those! once we initialize this contract for the first time, that constructor will run and printe out that line. Please make that line say whatever you want it!. In the next lesson, we'll run this and see what we get!
🚨 Before you click "Next Lesson"
Note: if you don't do this, Farza will be very sad :(.
Go to #progress and post a screenshot of your fancy contract in the WavePortal.sol file :).

- Compile contract locally and run it
🔥 Imitating the blockchain environment to test
You've done it. You've written a smart contract. You're a champ!
Now we need to actually
1. Compile it.
2. Deploy it to our local blockchain
3. Once it's there, that console.log will run :).
We need to do this because in the real world, smart contract slive on the blokchcian. And, we want our websites and smart contract be used by real people so the can 👋 at us or do whatever you want them to do!. So, even when we're working locally we want to imitate that environment. Technically, we could just compile and run Solidity code, but what makes Solidity magical is how it can interact with the blockchain and Ethereum wallets (which we'll see more of in the next lesson). So, better to just knock this out right now. We're just going to write a custom script that handles those 3 steps for us.
Let's do it!
📝 Build a script to run our contract
So, to test a smart contract we've got to do a bunch of stuff right. Like: compile, deploy, then execute.
Our script will make it really easy to iterate on our contract really fast :).
So, this is what run.js is going to have:
```js
const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address);
};

const runMain = async() => {
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
}

runMain();
```

🤔 How's it work?
Again going line by line here.
```js
const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
```
This will actually compile our smart contrat and generate the necessary files we need to work with our contract under that `artifacts` directory. Go check it ou after you run this.
```js
const waveContract = await waveContractFactory.deploy();
```
This is pretty fancy :). 
What's happening here is Hardhat will create local Ethereum network for use, but just for this contrat. Then, after the script completes it'll destroy that local network. So, eveyr time you run the contract, it will be a fresh blockchain. What's the point? It's kinda like refreshing your local server every time som you alwasy start from a clean slate which makes it easy to debug errors.
```js
await waveContract.deployed();
```
We'll wait until our contract is officially deployed to our local blockchain! Our constructor runs when we actually deploy.
```js
console.log("Contract deployed to:", waveContract.address);
```
Finally, once it's deployued `waveContract.address` will basically give us the address of the deployed contract. This address is how we can actualy find our contract on the blockchain. There are millions of contracts on the actual blockchain. So, this address gives us easy access to the contract we're interested in working with! This will be more important a bit later once we deploy to a real Ethereum network. Let's run it!
```bash
$ npx hardhat run scripts/run.js
```
You should see your console.log run from within the contract and then you should also see the contract address print out!!! Here's what I get:
[IMAGE](https://i.imgur.com/ug79rOM.png)

🎩 Hardhat & HRE
In these code blocks you will constantly notice that we use hre.ethers, but hre is never imported anywhere? What type of magic trick is this? Directly from the Hardhat docs themselves you will notice this:
```docs
The Hardhat Runtime Environment, or HRE for short, is an object containing all the functionality that Hardhat exposes when running a task, test or script. In reality, Hardhat is the HRE.
```
So what does this mean? well, every time you run a terminal command that starts with npx hardhat you are getting this hre object built on the fly using `hardhat.config.js` specified in your code! This means you will never have to actually do some sort of import into your files like:
const hre = require("hardhat")
TL;DR - you will be seeing hre a lot in our code, but never imported anywhere! Checkout this cool Hardhat documentation to learn more about it!

🚨 Before you click "Next Lesson"
Note: if you don't do this, Farza will be very sad :(.
Go to #progress and post a screenshot of your terminal with the output.
Be sure to make that console.log whatever you want! You've now written your own contract and ran it by deploying to a local blockchain WOOOOOOOOOO LETS GOOO.

- Store data on our smart contract
- Deploy locally so we can start building the wbsite

## Build web3 app that connects to our wallet and talks to our WaveContract
- Setup a basic react app, setup Metamask
- Deploy smart contract to a real testnet
- Connect our wallet to our web app
- Call our wallet to our web app
- Call the our deployed smart contract from our web app

## Update WavePortal to randomly send lucky users waving at you some Ethereum
- Storing messages from users on the blockchain
- Fund contract, set a prize, and send users Ethereum

## Update UI + deploy to an Ethereum testnet so anyone on the internet can wave at you using their wallet
- Randomly pick a winnter and prevent spammers
- Finalize and celebrate
