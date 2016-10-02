angular.module("application").service("uuid", function() {
  return function() {
    var S4;
    S4 = function() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
  };
}).factory("socketio", ["$rootScope", function($rootScope) {
  var socket;
  socket = io.connect();
  return {
    on: function(eventName, cb) {
      return socket.on(eventName, function() {
        var args;
        args = arguments;
        return $rootScope.$apply(function() {
          return cb.apply(socket, args);
        });
      });
    },
    emit: function(eventName, data, cb) {
      return socket.emit(eventName, data, function() {
        var args;
        args = arguments;
        return $rootScope.$apply(function() {
          if (cb) {
            return cb.apply(socket, args);
          }
        });
      });
    }
  };
}]).filter("diffTime", function() {
  return function(date) {
    var dx, dxAb, now, prefix, time, timeText;
    if (!date) {
      return date;
    }
    time = new Date(date);
    now = new Date();
    dx = now.getTime() - time.getTime();
    dxAb = dx < 0 ? dx * -1 : dx;
    prefix = "";
    timeText = "";
    dxAb = dxAb / 1000;
    if (dxAb < 10) {
      return "今";
    }
    if (dxAb < 60) {
      timeText = Math.floor(dxAb) + "秒";
    } else if (dxAb < 3600) {
      timeText = Math.floor(dxAb / 60) + "分";
    } else if (dxAb < 3600 * 24) {
      timeText = Math.floor(dxAb / 3600) + "時間";
    } else if (dxAb < 3600 * 24 * 360) {
      timeText = Math.floor(dxAb / 3600 / 24) + "日";
    } else {
      timeText = Math.floor(dxAb / 3600 / 24 / 360) + "年";
    }
    prefix = prefix + (dx < 0 ? "後" : "前");
    return timeText + prefix;
  };
});
