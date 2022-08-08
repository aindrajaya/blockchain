# Etherscan API 

1. Topics (topic0_1_opr): Each log record consists of **topics** and **data**. Topics are 32-byte (256 bit) "words" that are used to describe what's going on in an event. Different opcodes (LOG0,... LOG4) are needed to describe the numbe of topics that need to be included in the log record. For instance, LOG1 includes one topic, while LOG4 includes four topics. Therefore, the maximum number of topics that can be included in a single log is four. **Topics in Ethereum Log records**, the first part of a log record consists of an array of topics. These topics are used to describe the event. The first topic usually consists of the signature (a keccak256 hash) of the name of the even that occured, including the types (uint256, string, etc) of its parameters. One exception where this signature is not included as the first topic is when emitting anonymous events. 

2. Ethereum Proxy: a service running on the Ethereum wire protocol, allowing one or more clients to run behind it while keeping conections open.
 `eth_blockNumber`: Returns the numbe rof most recent block
 `eth_getByBlockByNumber`: Returns information about a block by block number
 `eth_getUncleByBlockNumberAndIndex`: Returns information about a uncle by block number. Can be retrieve the block that holds the block number of that uncle (Uncle blocks are similar to orphan blocks on Bitcoin, but have subtle distinctions connected with the Ethereum protocol. Uncle blocks are valid blocks that the networks has rejected. Miners get paid for producing an uncle block, unlike an orphan block, where miners don't get rewarded)
 `eth_getBlockTransactionCountByNumber`: Returns the number of transactions in a block matching the given block number, the string tag is 'earlies', 'latest', or 'pending'.
 `eth_getTransactionByHash`: Returns the information about a transaction requested by transaction hash. In response object, *blockHash*, *blockNumber* and *transactionIndex* are *null* when the transaction is pending.
 `eth_getTransactionByBlockNumberAndIndex`: Returns information about a transaction by block number and transaction index position.
 `eth_getTransactionCount`: Will returns the number of transactions performed by an address. 
 `eth_sendRawTransaction`: Submit a pre-signed transaction for broadcast to the Ethereum network or it can be say creates a new message call transaction or contract creation for signed transactions
 `eth_getTransactionReceipt`: Return the receipt of a tranasction by transaction hash
 `eth_call`: Executes a new message ecall immediately without creating a transaction on the blockchain. This one is one of the most commonly used API calls. It is used to read from the blockchain which includes executing smart contracts but does not publish anything to the blockchain. This call does not consume any Ether. Started from Geth 1.9.13, *eth_call* will check the balance of the sender (to make sure that the sender has enough gas to complete the request) before executing the call when one of the following conditions is true: (-) The *gas_price* parameter is populted, or (-) the contract function being called. In these two cases, even though the *eth_call* requests don't consume any gas, the *from* address mus have enough gas to execute the call as if it were a write transaction because *eth_call* is being used to simulate the transaction.
 `eth_getCode`: Returns code at a given address. 
 `eth_getStorageAt`: Returns the value from a storage position at a given address, or in other words, returns the state of the contract's storage, whichmay not be exposed via the contract's methods.
 `eth_gasPrice`: Returns the current price per gas in wei. 
 `eth_estimateGas`: Makes a clal or transaction, which won't be added to the blockchain and r eturns the used gas. It can be Generate and returns and estimate of how much gas is necessary to allow the transaction to complete. The transaction will not be added to the blockchain. NOTE: The estimate may be significantly more than the amout of gas actually used by the transaction, for a variety of reasons including EVM mechanics and node performance. Estimates are served directly from nodes, we're not doing anythig special to the value so the rest of the network is likely seeing the same.

 3. Ethereum Stats moudle/ service:
 `tokensupply`: Returns the current amount of an especially ERC-20 token in circulation.
`ethsupply`: Returns the current amount of Ether in circulation excluding ETH2 staking rewards end EIP1559 burnt fees.
 `ethprice`: returns the latest price of 1 ETH