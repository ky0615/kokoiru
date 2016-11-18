express = require "express"
path = require "path"
gulp = require "./gulpfile"
sequence = require "run-sequence"
bodyParser = require "body-parser"

sequelize = require "./models"

app = express()
server = require('http').createServer(app)
io = require('socket.io')(server)

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
app.get '/attend/:id/heatmap', attend.heatMap
app.get '/attend', attend.index
app.post '/attend', attend.create
app.get '/attend/leavingAll', attend.leavingAll

chat = require("./router/chat")(sequelize)
app.get "/chat", chat.index
app.post "/chat", chat.create

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

io.on "connection", (socket)->
  console.log "Socket.io is connection!"


sequelize.Names.afterCreate (model)->
  io.emit "changeUserData",
    status: "create"
    data: model.dataValues
sequelize.Names.afterUpdate (model)->
  io.emit "changeUserData",
    status: "update"
    data: model.dataValues
sequelize.Chat.afterCreate (model)->
  io.emit "changeChatData",
    status: "add"
    data: model.dataValues

attendUpdateCb = (model)->
  console.log "hook"
  console.log model.dataValues
  io.emit "changeUserStatus", model.dataValues
sequelize.Attend.afterCreate attendUpdateCb
sequelize.Attend.afterUpdate attendUpdateCb
sequelize.Attend.afterBulkUpdate (model)->
  console.log "hook"
  io.emit "reloadUserStatus", {}

server.listen app.get("port"), ->
  console.log "Server listening on pot " + server.address().port





