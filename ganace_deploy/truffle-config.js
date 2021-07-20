var bip39 = require("bip39");
var ethwallet = require('ethereumjs-wallet');
var ProviderEngine = require("web3-provider-engine");
var WalletSubprovider = require('web3-provider-engine/subproviders/wallet.js');
//var Web3Subprovider = require("web3-provider-engine/subproviders/web3.js");
const FilterSubprovider = require('web3-provider-engine/subproviders/filters.js');
var Web3 = require("web3");

// Insert raw hex private key here, e.g. using MyEtherWallet
//var wallet = ethwallet.fromPrivateKey(Buffer.from('16c2f2505b7c5b2640951039d1fb346f7026794f57509cfc23db1628bb697454', 'hex'));//ropsten dsp
// from metamask
//var wallet = ethwallet.fromPrivateKey(Buffer.from('67ad9b848bc05a99e99f07e6ea774fb77d98a139bd7a72bdc829893503d2afea', 'hex'));//metamask

//var address = "0x" + wallet.getAddress().toString("hex");

//var providerUrl = "https://ropsten.infura.io";
//var engine = new ProviderEngine();
//engine.addProvider(new FilterSubprovider());
//engine.addProvider(new WalletSubprovider(wallet, {}));
//engine.addProvider(new Web3Subprovider(new Web3.providers.HttpProvider(providerUrl)));
//engine.start(); // Required by the provider engine.

module.exports = {
	//contracts_directory: "./contracts/*SCHToken.sol",
  networks: {
      development: {
        host: "127.0.0.1",
        port: 8545,
        network_id: "*", // Match any network id
        gas: 2000000,
        gasPrice: 0x01
      }
    },
/*
  test: {
      host: "dev.ropsten.infura.io",
      port: 80,
      network_id: "*" // Match any network id
    },

  infura_ropsten: {
      provider: engine,
      network_id: "*", // Match any network id
      from: address
  },
*/
  compilers: {
      solc: {
  		//version: "^0.7.0",
  		version: "0.4.26",
  		//version: ">=0.4.26 < 0.7.2",
        settings: {
          optimizer: {
            enabled: true, // Default: false
            runs: 200      // Default: 200
          },
        }
      }
  }

};
