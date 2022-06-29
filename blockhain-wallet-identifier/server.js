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

// app.get("/signature", (req, res) => {
//   let error = "", realAddr = ""
//   const expectedMsg = `My session ID: ${req.sessionID}`
//   const hash = ethers.utils.id(`\x19Ethereum Signed Message:\n${expectedMsg.length}${expectedMsg}`)
//   const claimedAddr = req.query.addr

//   try{
//     realAddr = ethers.utils.recoverAddress(hash, req.query.sig)
//   } catch(e){
//     error = e.reason
//   }

//   if(error){
//     res.send(`ERROR: ${error}`)
//   } else {
//     if(realAddr.toLowerCase() === claimedAddr.toLowerCase())
//       res.send(`Legitimate, welcome ${realAddr}`)
//     else
//       res.send(`Fraud!! You are not ${claimedAddr}, you are ${realAddr}`)
//   }
// })

app.get("*", (req, res) => {
  res.send(`
    <htmL>
      <body>
        <ul>
          <li><a href="/client_side.html">Client side user authentication</a></li>
          <li><a href="/server_side.html">Server side user authentication</a></li>
        </ul>
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