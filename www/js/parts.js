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
}]);
