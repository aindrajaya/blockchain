# [web3.js](https://web3js.readthedocs.io/en/v1.7.1/) - Ethereum JavaScript API
web3.js is a collection of libraries that allow you to interact with a local or remote ethereum node using HTTP, IPC or WebSocket. The following documentation will guide you through installing and running web3.js as well as providing an API reference documentation with examples.
Contents:
## User Documentation
### Getting Started
#### Adding Web3.js
### Callbacks Promises Events
### Glossary
#### JSON Interface
---
## API Reference
### Web3
#### Web3.modules
#### Web3 Instance
#### Version
#### Utils
#### setProvider
#### providers
#### givenProvider
#### currentProvider
#### BatchRequest
#### extend
### Web3.eth
#### Note on checksum addresses
#### subscribe
#### Contract
#### Iban
#### personal
#### accounts
#### ens
#### abi
#### net
#### setProvider
#### providers
#### givenProvider
#### BatchRequest
#### extend
#### defaultAccount
#### defaultBlock
#### defaultHardfork
#### defaulChain
#### defaultCommon
#### transactionBlockTimeout
#### blockHeaderTimeout
#### transactionConfirmationBlocks
#### transactionPollingTimeout
#### transactionPollingInterval
#### handleRevert
#### maxListenersWarningThreshold
#### getProtocolVersion
#### isSyncing
#### getCoinbase
#### isMining
#### getHashrate
#### getGasPrice
#### getFeeHistory
#### getAccounts
#### getBlockNumber
#### getBalance
#### getStorageAt
#### getCode
#### getBlock
#### getBlockTransactionCount
#### getBlockUncleCount
#### getUncle
#### getTransaction
#### getPendingTransactions
#### getTransactionFromBlock
#### getTransactionReceipt
#### getTransactionCount
#### sendTransaction
#### sendSignedTransaction
#### sign
#### signTransaction
#### call
#### estimateGas
#### getPastLogs
#### getWork
#### submitWork
#### requestAccounts
#### getChainId
#### getNodeInfo
#### getProof
#### createAccessList
### web3.eth.subscribe
#### subscribe
#### clearSubscription
#### subscribe("pendingTransactions")
#### subscribe("newBlockHeaders")
#### subscribe("syncing")
#### subscribe("logs")
### web3.eth.Contract
#### new contract
#### = Properties =
#### defaultAccount
#### defaultBlock
#### defaultHardfork
#### defaultChain
#### defaultCommon
#### transactionBlockTimeout
#### blockHeaderTimeout
#### transactionConfirmationBlocks
#### transactionPollingTimeout
#### transactionPollingInterval
#### handleRevert
#### options
#### options.address
#### options.jsoninterface
#### = Methods =
#### clone
#### deploy
#### methods
#### methods.myMethod.call
#### methods.myMethod.send
#### methods.myMethod.estimateGas
#### methods.myMethod.encodeABI
#### methods.myMethod.createAccessList
#### = Events =
#### once
#### events
#### events.allEvents
#### getPastEvents
### web3.eth.accounts
#### create
#### privateKeyToAccount
#### signTransaction
#### recoverTransaction
#### hashMessage
#### sign
#### recover
#### encrypt
#### decrypt
#### wallet
#### wallet.create
#### wallet.add
#### wallet.remove
#### wallet.clear
#### wallet.encrypt
#### wallet.decrypt
#### wallet.save
#### wallet.load
### web3.eth.personal
#### setProvider
#### providers
#### givenProvider
#### currentProvider
#### BatchRequest
#### extend
#### newAccount
#### sign
#### ecRecover
#### signTransaction
#### sendTransaction
#### unlockAccount
#### lockAccount
#### getAccounts
#### importRawKey
### web3.eth.ens
#### registryAddress
#### registry
#### resolver
#### getResolver
#### setResolver
#### getOwner
#### setOwner
#### getTTL
#### setTTL
#### setSubnodeOwner
#### setRecord
#### setSubnodeRecord
#### setApprovalForAll
#### isApprovedForAll
#### recordExists
#### getAddress
#### setAddress
#### getPubkey
#### setPubkey
#### getContent
#### setContent
#### getContenthash
#### setContenthash
#### getMultihash
#### supportsInterface
#### setMultihash
#### ENS events
### web3.eth.Iban
#### Iban instance
#### Iban contructor
#### toAddress
#### toIban
#### fromAddress
#### fromBban
#### createIndirect
#### isValid
#### prototype.isValid
#### prototype.isDirect
#### prototype.isIndirect
#### prototype.checksum
#### prototype.institution
#### prototype.client
#### prototype.toAddress
#### prototype.toString
### web3.eth.abi
#### encodeFunctionSignature
#### encodeEventSignature
#### encodeParameter
#### encodeParameters
#### encodeFunctionCall
#### decodeParameter
#### decodeParameters
#### decodeLog
### web3.*.net
#### getId
#### isListening
#### getPeerCount
### web3.bzz
#### setProvider
#### givenProvider
#### currentProvider
#### upload
#### download
#### pick
### web3.shh
#### setProvider
#### providers
#### givenProvider
#### currentProvider
#### BatchRequest
#### extend
#### getId
#### isListening
#### getPeerCount
#### getVersion
#### getInfo
#### setMaxMessageSize
#### setMinPoW
#### markTrustedPeer
#### newKeyPair
#### addPrivateKey
#### deleteKeyPair
#### hasKeyPair
#### getPublicKey
#### getPrivateKey
#### newSymKey
#### addSymKey
#### generateSymKeyFromPassword
#### hasSymKey
#### getSymKey
#### deleteSymKey
#### post
#### subscribe
#### clearSubscriptions
#### newMessageFilter
#### deleteMessageFilter
#### getFilterMessages
#### ### web3.utils
#### Bloom Filters
#### randomHex
#### BN
#### isBN
#### isBigNumber
#### sha3
#### sha3Raw
#### soliditySha3
#### soliditySha3Raw
#### isHex
#### isHexStrict
#### isAddress
#### toChecksumAddress
#### checkAddressChecksum
#### toHex
#### stripHexPrefix
#### toBN
#### hexToNumberString
#### hexToNumber
#### numberToHex
#### hexToUtf8
#### hexToAscii
#### utf8ToHex
#### asciiToHex
#### hexToBytes
#### bytesToHex
#### toWei
#### fromWei
#### unitMap
#### padLeft
#### padRight
#### toTwosComplement