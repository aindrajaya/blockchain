WHAT IS BLOCKCHAIN
-------------
A blockkchain is a shared, distributed, and permanent database shared among multiple nodes on a computer network. They record data in a way that makes it probabilistically impossible to modify or hack the system. Specifically, as its namesake, blockchains record data as a chaing of blocks. Each block contains a group of transactions, which could be transferring assets around the network, or updating the information stored on the blockchain.
Blockchains were popularized by the anonymous person (or group) Satoshi Nakamoto, when they released the Bitcoin Network in 2008. Bitcoin is a cryptocurrency network, and it handles primarily the transfer of the BTC asset across the network, without a trusted middleman or authority, while ensuring the network itself is scure and cannot be hacked. (P.S. The bitcoin network is also likely the biggest bug bounty in the world- if you can hack it, you're an instant trillionaire)
Over time, this design of Bitcoin inspired other, more capable, blockchain networks to come out, like Ethereum. We will be learning a lot about Ethereum in the coming sessions.

# State Management
[GAMBAR: https://i.imgur.com/VQySjQu.png]
Blockchains start of a with a Genesis State when they launch. Bitcoin's genesis state happened in 2009 when the public network launched. Ethereum's Genesis State happened in 2015, when it launched. Every transaction on a blockchain modifies the global state that is replicated across all nodes.
[GAMBAR: https://i.imgur.com/wjK9Foy.png]
Since there are millions of transcations, transactions get grouped together in blocks. Hence the name. These blocks are chained together in a cryptography verifiable way to they are historically traceable. The current state of a network can be recalculated at any time by starting from the genesis block and transitioning the state according to each blocks' information up until now.

# Nodes
A blockchain network is managed autonomously through a peer-to-peer distributed network of computer nodes. Without going into too much detail, you can simply think of each node in the network as keeping a copy of the global transactions ledger. Therefore, each node can individually verify and audit transctionss happening on the netwokr and ensure there was no illicit behaviour. Another type of node, called a mining node, is responsible for grouping together new transactions being made on a network into a block, and proposing the block to be included onto the global ledger by everyhone else. Mining is computationally hard, and very important to do securely, so miners whose blocks get accepted are given a token reward for their hard work.
To use of blockchain confirms that each unit of value was transfered only once, and the ingenious mechanisms put forth by Satoshi Nakamoto sovled the long-standing decentralized double spending problem.

# Decentralization
By storing data  in a peer-to-peer network of nodes, the blockchain is a decentralized network. This has significant benefits over the traditional approach of storing data in a centralized manner. There are significant examples of problems with centralization- a few of which we will list here:
--> Data breaches in centralized systems expose lot of data
--> Centralized authorities can censor and shut down speech
--> Reliance on a central authority means upstream problems affect downstream consumers (e.g., AWS going down means most of the internet goes down with it)
On the other hand, decentralization brings about the opposite benefites:
--> No censorhip as there is no single authority or middleman that can censor you
--> No downtime as the overall network is running across 1000's of nodes across the globe
--> Highly attact resistant making it infeasible to manipulate or destroy data.

# Use Case
Cryptocurrency
Smart Contracts
Decentralized Finance
Gaming
Supply Chain Tracking
Counterfeiting Protection
Data Privacy
Decentralized Governance
Verifiable ownership of assets