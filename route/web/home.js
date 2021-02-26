const express = require("express");
var router = express.Router();

router.get("/", function(req, res){
    console.log("Index page");
    res.render("Index");
})

module.exports = router