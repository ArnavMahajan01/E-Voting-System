const express = require("express");
var router = express.Router();
const User = require('../../models/user');
const user = new User();
global.str = '';

router.get("/signup", function(req, res){
    res.render("accounts/signup")
    //console.log("Signup page");
    //res.render("Index");
})

router.post("/signup", (req, res, next)=>{
    let user_info = {
        user_name : req.body.full_name,
        gender : req.body.gender,
        mobile_number : req.body.mob_no,
        email : req.body.email
    }

    let password = req.body.password;
    let confirm_password = req.body.confirm_password;
    
    if(password != confirm_password){
        res.render("accounts/signup", {'msg': 'Passwords are not same', 'status':false});
    }
    else {
        console.log("Password same")
    }

    user.create(user_info,password,confirm_password,function(lastId) {
        if(lastId) {
            res.redirect('/');
        
        } else {
            res.render('accounts/signup', {resp_msg:'Not able to register this user', resp_status: false});

        }
    })
})

router.get("/login", function(req, res){
    let user = req.session.ss_user_name;
    if(user){
        res.redirect('/');
        return;
    }
    res.render("accounts/login");
})

router.post("/login", function(req, res, next){
    let email = req.body.my_email;
    let password = req.body.my_password;
    
    user.login(email, password, function(result){
        if(result){
            console.log(result.name)
            req.session.ss_user_name = result.name;
            req.session.ss_user_email = result.email;
            req.session.ss_user_id = result.userid;
            req.session.ss_userrole = result.userrole;
            req.session.ss_allowedmenu = result.allowedmenu;
            req.session.ss_user_row_id = result.users_id;
            res.redirect('/');
        }
        else{
            console.log("Error!!! can't login");
            res.render('accounts/login', {resp_msg:'Incorrect! Username/Password', resp_status:false});
        }
    })
})

router.get("/forgot_password", function(req, res){
    console.log("STTTR: " + str);
    res.render("accounts/forgot_password_before_session")
})


router.post("/forget_password", function(req, res, next){
    let userid = req.body.email;
    console.log("User ID: " + userid);

    user.forgot_password(userid, function(result){
        if(result){
            console.log("Email Sent");
        }
        else{
            console.log("Error in sending email");
        }
    })    
})

router.get("/change_password", function(req, res){
    res.render("accounts/change_password")
})

router.post("/change_password", function(req, res ,next){
    let userid = req.body.userid;
    let password = req.body.old_password;
    let new_password = req.body.new_password;
    let confirm_new_password = req.body.confirm_new_password;

    
    if(new_password !== confirm_new_password)
        res.render('accounts/change_password', {resp_msg:'Passowrds do not match', resp_status: false});

    user.change_password(userid, new_password, function(result){
        if(result){
            console.log("Password changed");
            res.redirect('/')
        }
        else{
            console.log("Error in changing password");
            res.render('accounts/change_password');
        }
    })
})

router.get('/logout',function(req,res){    
    req.session.destroy(function(err){  
        if(err){  
            console.log(err);  
        }  
        else  
        {  
            res.redirect('/login');  
        }  
    });  

}); 

router.get("/redirected_forgotpassword", function(req,res){
    console.log("query string");
    str = req.query.t;
    console.log("STR: " + str);
    user.forgot_password_find(str, function(result){
        console.log("Result Length 1" + result.userid);
        if(result){
            res.render("accounts/forgot_password_after_session", {temppwd: str});
        }
        else{
            console.log("Error 401 Unauthorized");
        }
    })
});

router.post("/redirected_forgotpassword", function(req, res, next){
    let new_password = req.body.new_password;
    let confirm_new_password = req.body.confirm_new_password;
    let temppwd = req.body.temppwd;

    console.log("New_password: " + new_password + "ConfirmNew_password: " + confirm_new_password + "temppwd: " + temppwd)
    if(new_password !== confirm_new_password)
        res.render('accounts/login', {resp_msg:'Passowrds do not match', resp_status: false})

    
            user.update_password(temppwd, new_password, function(result){
                if(result){
                    console.log("Password changed");
                    res.redirect('/')
                }
                else{
                    console.log("Error in changing password");
                    res.render('accounts/login');
                }
            })
});

module.exports = router;