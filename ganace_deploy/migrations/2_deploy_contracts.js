// var BigNumber = require('bignumber');
// var ECRecovery = artifacts.require("zeppelin-solidity/contracts/ECRecovery.sol");
// var PapyrusToken = artifacts.require("./PapyrusToken.sol");

// Optional Deps
// var StandardToken = artifacts.require("./StandardToken.sol");
// var ChannelApi = artifacts.require("./ChannelApi.sol");
// var ChannelContract = artifacts.require("./ChannelContract.sol");

var ECRecovery = artifacts.require("./ECRecovery.sol");
var SCHToken = artifacts.require("./SCHToken");
var ChannelLibrary = artifacts.require("./ChannelLibrary.sol");
var EndpointRegistryContract = artifacts.require("./EndpointRegistryContract.sol");
var ChannelManagerContract = artifacts.require("./ChannelManagerContract.sol");
var ChannelApiStub = artifacts.require("./ChannelApiStub.sol");

module.exports = function(deployer) {
    deployer.deploy(ECRecovery);
    deployer.link(ECRecovery, ChannelLibrary);
    deployer.deploy(ChannelLibrary);
    deployer.deploy(EndpointRegistryContract);
    deployer.deploy(SCHToken);
    deployer.link(ChannelLibrary, ChannelManagerContract);
    deployer.deploy(ChannelApiStub).then(function() {
        deployer.deploy(SCHToken, ["0x33719B186Eb764e6F47345bE01e284aD807399a5", "0x515061D7Fa9c544Fb91B8D28BBF62d1aa4e1F8ad"], ["900000000000000000000000000", "100000000000000000000000000"]).then(function() {
            deployer.deploy(ChannelManagerContract, SCHToken.address, ChannelApiStub.address);
        });
    });
};
