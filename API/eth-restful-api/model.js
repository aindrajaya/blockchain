const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let AccountSchema = new Schema({
  ETH: {type: string, required: false, max: 64},
});

module.exports = mongoose.model('Account', AccountSchema);