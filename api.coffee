express = require "express"
bodyParser = require "body-parser"
path = require "path"
exec = require('child_process').exec

app = express()
app.use bodyParser()

apiSuffix = "/api/v1/"

app.use (req, res, next)->
  res.set "X-Powered-By", "NodeJS"
  next()

app.get apiSuffix + "scan", (req, res)->
  console.log "start scan"
  exec path.dirname(process.mainModule.filename) + "/../build/scan", (error, stdout, stderr)->
    result = 
      status:"success"
      data: ""

    if(error)
      console.log error
      console.log ""
      console.log stderr
      result.status = "error"
      result.data = stdout
    else
      result.data = stdout

    res.send result

app.post apiSuffix + "send", (req, res)->
  console.log "start send"
  result = 
      status:"success"
  unless req?.body?.data
    result.status = "error"
    result.data = "parameter(data) is not enough."
    res.send result
    return

  param = ""

  param += "-r " + req.body.repeat if req?.body?.repeat

  exec "echo \"" + req.body.data.replace(/[&'`";<>]/g, -> "") + "\" |" +  path.dirname(process.mainModule.filename) +
  "/../build/send " + param, 
    (error, stdout, stderr)->
      if(error)
        console.log error
        console.log ""
        console.log stderr
        result.status = "error"
        result.data = stdout
      else
        result.data = stdout
      res.send result

app.get "*", (req, res)->
  res.status(404).send("404 Not found")

app.set 'port', process.env.PORT || 1452

server = app.listen app.get("port"), ->
  console.log "Server listening on pot " + server.address().port
