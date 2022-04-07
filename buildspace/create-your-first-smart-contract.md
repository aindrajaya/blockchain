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
- Compile contract locally and run it
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
