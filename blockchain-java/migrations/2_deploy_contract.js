const JavaToken = artifacts.require("./JavaToken.sol");

// module.exports = function(deployer, network, accounts){
//   deployer.deploy(JavaToken, {from: accounts[0]}).then(function(instance){
//     return instance.mint(accounts[0], web3.utils.toBN("100"), {from: accounts[0]});
//   })
// }

module.exports = async function (deployer) {
  await deployer.deploy(JavaToken, 'Java Token', 'JVM', '10000000000000000000000');
};