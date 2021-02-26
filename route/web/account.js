const express = require("express");
var router = express.Router();

router.get("/signup", function(req, res){
    res.render("accounts/signup")
    //console.log("Signup page");
    //res.render("Index");
})

router.get("/login", function(req, res){
    res.render("accounts/login")
})

router.get("/forgot_password", function(req, res){
    res.render("accounts/forgot_password_before_session")
})

router.get("/change_password", function(req, res){
    res.render("accounts/change_password")
})

module.exports = router;