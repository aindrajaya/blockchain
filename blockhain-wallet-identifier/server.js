#! /usr/local/bin/node
var express = require("express");
var session = require("express-session")
var ethers = require("ethers")

var app = express() //create a new express server

/**
 * Serve the file out of ./public as main files
 */
app.use(express.static(__dirname+ '/public'))

app.set('trust proxy', 1) //trust first proxy
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  
  cookie: {
    // secure: true => is required for production but requires an https server, which is overkill for now
    secure: false
  }
}))

app.get("/session", (req, res) => {
  res.send(req.sessionID)
})

app.get("/signature", (req, res) => {
  let error = "", realAddr = ""
  const expectedMsg = `My session ID: ${req.sessionID}`
  const hash = ethers.utils.id(`\x19Ethereum Signed Message:\n${expectedMsg.length}${expectedMsg}`)
  const claimedAddr = req.query.addr

  try{
    realAddr = ethers.utils.recoverAddress(hash, req.query.sig)
  } catch(e){
    error = e.reason
  }

  if(error){
    res.send(`ERROR: ${error}`)
  } else {
    if(realAddr.toLowerCase() === claimedAddr.toLowerCase())
      res.send(`Legitimate, welcome ${realAddr}`)
    else
      res.send(`Fraud!! You are not ${claimedAddr}, you are ${realAddr}`)
  }
})

app.get("*", (req, res) => {
  res.send(`
    <htmL>
      <title>Server and client-side user identification</title>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
      <body>
        <div class="container px-4 py-5 my-5 text-center">
          <h1 class="display-5 fw-bold lh-1 mb-3">Client and Server side Wallet Integration</h1>
          <p class="lead">Example for the Metamask wallet integration from client or server side.</p>
          <div class="d-grid gap-2 d-md-flex justify-content-md-center">
            <a href="/server_side.html" role="button" class="btn btn-primary btn-lg px-4 me-md-2 mr-4">Server</a>
            <a href="/client_side.html" role="button" class="btn btn-outline-secondary btn-lg px-4 ml-4">Client</a>
          </div>
        </div>
      </body>
    </htmL>
  `)
}) 

/**
 * Start server on the specific and binding host
 */
app.listen(8000, '0.0.0.0', function(){
  console.log("server started")
})