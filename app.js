const express = require("express");
const path = require("path");
const {logger} = require("./logger");
const bodyParser = require("body-parser")
const session = require('express-session');
const cookieParser = require('cookie-parser');
const util = require('util');
var app = express();

global.baseurl = 'http://localhost:3000/'

app.use(express.urlencoded({extended:false}));

app.set("views", path.join(__dirname, "views"));
app.use("/static", express.static(__dirname + "/assets"));

app.set("view engine", "ejs");



app.use(cookieParser());

app.use(session({
    secret:'Lucifer_MorningStar',
    resave: false,
    saveUninitialized: false,
    cookie: {
        maxAge: 60 * 1000 * 30
    }
}));

app.use(function(req, res, next) {
    res.locals.loc_user_name = req.session.ss_user_name;
    res.locals.loc_user_email = req.session.ss_user_email;
    res.locals.loc_user_id = req.session.ss_user_id;
    res.locals.loc_userrole = req.session.ss_userrole;
    res.locals.loc_allowedmenu = req.session.ss_allowedmenu;
    res.locals.loc_user_row_id = req.session.ss_user_row_id;
    next();
});

app.use("/", require("./route/web"));
app.listen('3000', function(){
    console.log("This server port is 3000 ");
    logger.info("Server started");
})