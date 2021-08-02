pragma solidity >=0.4.21 < 0.9.0;

contract Inbox {
  //structure
  mapping(string => string) public ipfsInbox;
  
  //events
  event ipfsSent(string _ipfsHash, string _address);
  event inboxResponse(string response);
  
  //modifier
  modifier notFull (string memory _string){
    bytes memory stringTest = bytes(_string);
    require(stringTest.length == 0);
    _;
  }

  //an empty constructor that crease and instance of the contract
  constructor () public {}

  //takes in receiver's address and IPFS hash. Places the IPFSaddress in the receiver's inbox
  function sendIPFS(string memory _address, string memory _ipfsHash) notFull(ipfsInbox[_address]) public {
    ipfsInbox[_address] = _ipfsHash;
    emit ipfsSent(_ipfsHash, _address);  
  }

  //retrieves hash
  function getHash(string memory _address) public view returns(string memory){
    string memory ipfs_hash = ipfsInbox[_address];
    //emit inboxResponse(ipfs_hash)
    return ipfs_hash;
  }
}