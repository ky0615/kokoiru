angular.module "application"
.service "uuid", ->
  ->
    S4 = -> (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4())

.factory "socketio", ($rootScope)->
    socket = io.connect()
    return {
        on: (eventName, cb)->
            socket.on eventName, ->
                args = arguments
                $rootScope.$apply ->
                    cb.apply socket, args
        emit: (eventName, data, cb)->
            socket.emit eventName, data, ->
                args = arguments
                $rootScope.$apply ->
                    if cb
                        cb.apply socket, args
    }