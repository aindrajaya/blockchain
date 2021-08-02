require('dotenv').config()
const express = require('express')
const app = express()
const routes = require('./routes')
const Web3 = require('web3')
const mongodb = require('mongodb').MongoClient
const contract = require('truffle-contract')
const artifacts = require('./build/Inbox.json')
app.use(express.json())
if(typeof web3 !== 'undefined'){
  var web3 = new Web3(web3.currentProvider)
}else{
  var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
}

const uriDB = "mongodb+srv://jaya:fizpjNaCk40iBXuZ@jayakatwang.vw9n8.mongodb.net/blockchain?retryWrites=true&w=majority";
const LMS = contract(artifacts)
LMS.setProvider(web3.currentProvider)

mongodb.connect(uriDB, {useUnifiedTopolygi: true}, (err, client) => {
  const db = client.db('blockchain')
  const accounts = await web3.eth.getAccounts();
  const lms = await LMS.deployed()
  // const lms = LMS.at(contract_address) for remote nodes deployed on ropsten or rinkeby
  //home
  routes(app, db, lms, accounts)
  app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port 8082')
  })
})