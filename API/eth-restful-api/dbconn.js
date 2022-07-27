const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
// require('./model')
// const account = require('./route');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

let port = 4030;

mongoose.Promise = global.Promise;
mongoose.connect('mongodb+srv://jaya:Myr1EDULcaAyQvax@jayakatwang.vw9n8.mongodb.net/?retryWrites=true&w=majority', {useNewUrlParser: true})

let db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
let accountDB = db.collection("accounts");

app.use('/account', account);

app.listen(port, () => {
  console.log('Server is up and running on port number '+port);
  console.log(
    accountDB != null ?
    accountDB.name + " database found" :
    accountDB.name + " database not found"
  )
})