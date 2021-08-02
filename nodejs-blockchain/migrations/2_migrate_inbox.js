var IPFSInbox = artifacts.require("./Inbox.sol");
module.exports = function(deployer){
  deployer.deploy(IPFSInbox)
}