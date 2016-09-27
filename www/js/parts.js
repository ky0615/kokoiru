angular.module("application").service("firebase", function() {
  var config;
  console.log("fire: init");
  config = {
    apiKey: "AIzaSyDG8wDjS80VesDVaO38XFaVX6ljb4IlcE0",
    authDomain: "api-project-488342428656.firebaseapp.com",
    databaseURL: "https://api-project-488342428656.firebaseio.com/"
  };
  firebase.initializeApp(config);
  return firebase;
}).service("uuid", function() {
  return function() {
    var S4;
    S4 = function() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    return S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4();
  };
});
