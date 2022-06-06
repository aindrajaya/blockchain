/**
 * @param {string} chain
 * @param {number} timeout
 * @param {object} client
 * @returns {string}
 */

module.exports = function(chain, timeout, client){
  /**
   * @param query
   * @returns {Promise<any>}
   */
  function getRequest(query){
    return new Promise(function(resolve, reject){
      client.get('/api?' + query).then(function(res){
        var data = res.data;

        if(data.status && data.status != 1){
          let returnMessage = data.message || 'NOTOK';
          if(data.result && typeof data.result === 'string'){
            returnMessage = data.result;
          } else if(data.message && typeof data.message === 'string'){
            returnMessage = data.message;
          }

          return reject(returnMessage);
        }

        if(data.error){
          var message = data.error;

          if(typeof data.error === 'object' && data.error.message){
            message = data.erorr.message;
          }

          return reject(new Error(message));
        }

        resolve(data);
      }).catch(function(error){
        return reject(new Error(error));
      });
    });
  }

  return getRequest;
}