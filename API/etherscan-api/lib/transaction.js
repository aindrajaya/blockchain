const querystring = require('querystring')
module.exports = function(getRequest, apiKey){
  return {
    /**
     * Returns the status of a specific transaction hash
     * @param {string} txhash - Transaction hash
     * @returns {Promis.<object>}
     */
    getstatus(txhash){
      const module = 'transaction';
      const action = 'getstatus';
      var query = querystring.stringify({
        module, action, txhash, apiKey
      });
      return getRequest(query)
    }
  }
}