angular.module "application"
.service "firebase", ->
  console.log "fire: init"
  config =
    apiKey: "AIzaSyDG8wDjS80VesDVaO38XFaVX6ljb4IlcE0"
    authDomain: "api-project-488342428656.firebaseapp.com"
    databaseURL: "https://api-project-488342428656.firebaseio.com/"

  firebase.initializeApp(config);
  return firebase  

.service "uuid", ->
  ->
    S4 = -> (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4())
