express = require "express"
path = require "path"
gulp = require "./gulpfile"
sequence = require "run-sequence"
bodyParser = require "body-parser"

sequelize = require "./models"

app = express()
env = app.get "env"
app.use bodyParser()

app.use (req, res, next)->
  res.set "X-Powered-By", "NodeJS"
  next()

static_base_path = path.join __dirname, 'www'
app.use express.static static_base_path

users = require("./router/users")(sequelize)
app.get '/users', users.index
app.get '/users/:id', users.show
app.post '/users', users.create
app.put '/users/:id', users.update
app.delete '/users/:id', users.destroy

attend = require("./router/attend")(sequelize)
app.get '/attend', attend.index
app.post '/attend', attend.create

app.get /^\/(js|css|min)\/(.*)/, (req, res)->
  res.status(404).send("404 Not found")

app.get "*", (req, res)->
  res.sendFile path.join static_base_path, "index.html"
  return

console.log "NODE_ENV is " + env
app.set 'port', process.env.PORT || 1451

if env is "development"
  sequence "build", ->
    console.log "gulp build was successful"
    sequence "watch:assets", ->
# else
#   sequence "build", ->
#     console.log "gulp build was successful"

server = app.listen app.get("port"), ->
  console.log "Server listening on pot " + server.address().port
