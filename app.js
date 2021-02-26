const express = require("express");
const path = require("path");
const {logger} = require("./logger");
var app = express();

app.set("views", path.join(__dirname, "views"));
app.use("/static", express.static(__dirname + "/assets"));
app.use("/", require("./route/web"));
app.set("view engine", "ejs");

app.listen('3000', function(){
    console.log("This server port is 3000 ");
    logger.info("Server started");
})