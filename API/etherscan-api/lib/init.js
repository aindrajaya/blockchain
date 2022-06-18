"use strict"
const axios = require('axios');

//Libs called
const log =  require('./log')
const proxy = require('./proxy');
const stats = require('./stats');
const block = require('./block');
const transaction = require('./transaction');
const contract = require('./contract');
const account = require('./account');

//libs extension
const pickChainUrl = require('./pickChainUrl');

/**
 * @module etherscan/api
 */

/**
 * @param {string} apiKey - (optional) Your Etherscan APIkey
 * @param {string} chain - (optional) Other chain keys [ropsten, rinkeby, kovan]
 * @param {number} timeout - (optional) Timeout in miliseconds for request, default 10000
 * @param {object} client - optional axios client instance
 */

module.exports = function(apiKey, chain, timeout, client = null) {
  if(!apiKey){
    apiKey = 'YourAPIKeyToken';
  }

  if(!timeout){
    timeout = 10000;
  }

  if(!client){
    client = axios.create({
      baseUrl: pickChainUrl(chain),
      timeout: timeout
    });
  }

  var getRequest = require('./getRequest')(chain, timeout, client);
  /**
   * @lends module:etherscan/api
   */
  return{
    /**
     * @namespace
     */
    log: log(getRequest, apiKey),
    /**
     * @namespace
     */
    proxy: proxy(getRequest, apiKey),
    /**
     * @namespace
     */
    stats: stats(getRequest, apiKey),
    /**
     * @namespace
     */
    block: block(getRequest, apiKey),
    /**
     * @namespace
     */
    transaction: transaction(getRequest, apiKey),
    /**
     * @namespace
     */
    contract: contract(getRequest, apiKey),
    /**
     * @namespace
     */
    account: account(getRequest, apiKey)
  };
};