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

.filter "diffTime", ->
    return (date)->
        unless date
            return date

        time = new Date date
        now = new Date()
        dx = now.getTime() - time.getTime()
        dxAb = if dx < 0 then dx * -1 else dx
        prefix = ""　
        timeText = ""

        # convert ms to second
        dxAb = dxAb / (1000)

        if dxAb < 10
            return "今"
        if dxAb < 60
            timeText = Math.floor(dxAb) + "秒"
        else if dxAb < 3600
            timeText = Math.floor(dxAb/60) + "分"
        else if dxAb < 3600 * 24
            timeText = Math.floor(dxAb/3600) + "時間"
        else if dxAb < 3600 * 24 * 360
            timeText = Math.floor(dxAb/3600/24) + "日"
        else
            timeText = Math.floor(dxAb/3600/24/360) + "年"

        prefix = prefix + if dx < 0 then "後" else "前"
        return timeText + prefix
