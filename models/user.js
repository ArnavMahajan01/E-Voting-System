const pool = require('./pool');
const bcrypt = require('bcrypt');

function User() {};

User.prototype = 
{
    create:function(user,password,confirm_password,callback)
    {
        var pwd = password;
        password = bcrypt.hashSync(pwd,10);

        var bind = [];

        for(prop in user){
            bind.push(user[prop]);
        }

        let sql = 'Insert into t_users(name, genderid, primobno, email, ins_dt) values (?,?,?,?, now());';

        pool.query(sql,bind, function(err, result){
            if(err) throw err;

            if(result.insertId){
                sql = 'Insert into t_user_credentials(users_id, userid, password, userrole, ins_dt, tmp_txtpwd) values (?, ?, ?, 2, now(),?);';

                pool.query(sql, [result.insertId, user.email, password, pwd], function(credential_err, credential_result){
                    if(credential_err) throw credential_err;


                    if(credential_result.insertId > 0) {
                        return callback(credential_result.insertId);
                    }
                    else
                    {
                        return callback(null);
                    }

                } )
            }
            else {
                return callback(null);
            }
        })
    },

    login: function(email, password, callback)
    {
        this.find(email, function(user){
            if(user){
                
                if(bcrypt.compareSync(password, user.password)){
                    console.log("Login Succesful");
                    return callback(user);
                }
                else{
                    console.log("Password or user is invalid");
                    return callback(null);
                }
            }
        })
    },

    find: function(email, callback)
    {
        
        
        let sql = 'select a.id, a.name, a.genderid, a.primobno, a.email, a.status, a.ins_dt, a.ins_by, a.upd_dt, a.upd_by, b.id, b.users_id, b.userid, b.password, b.userrole, b.temppwd, b.temppwdvalid, b.otp, b.otpvalid, b.allowedmenu, b.status, b.ins_dt, b.ins_by, b.upd_dt, b.upd_by, c.id, c.gender_name, c.rec_st, c.ins_dt, c.ins_by, c.upd_dt, c.upd_by from t_users as a, t_user_credentials as b, m_gender as c where a.id = b.users_id and b.userid = ? and c.id = a.genderid';

        pool.query(sql, email, function(err, result){
            if(err) throw err
            
            if(result.length > 0){
                console.log("1 find "+ result[0]);
                callback(result[0]);
            }
            else{
                console.log("2 find");
                callback(null);
            }
        })
    },

    change_password: function(username, password, callback)
    {
        

        this.find(username.trim(), function(user) {

            if(user){
                let pwd = bcrypt.hashSync(password,10);
                let sql = 'update t_user_credentials set password =?, tmp_txtpwd=? where userid =?';

                

                pool.query(sql, [pwd, password, username.trim()], function(err, result){
                    
                    console.log('update query:' + JSON.stringify(result));
                    //console.log('result.affectedRows:' + result.affectedRows);

                    if(err) throw err;

                    if(result.affectedRows)
                    {
                        console.log('result.affectedRows:' + result.affectedRows);
                        return callback(result.affectedRows); 
                    }
                    else
                    {
                        console.log('0');
                        return callback(0); 
                    }
                })
            }
            else{
                console.log("There is no such user");
            }
            
        }); 
    },
    
    forgot_password: function(email)
    {
        this.find(email, function(user){
            if(user){
                let usersubstring = email.substring(0,4);
                console.log("User substring: " + usersubstring);
                var date = new Date();
                var time = date.getTime();
                let temppwd = usersubstring + time;
                console.log("Temppwd: " + temppwd);
                temppwd = bcrypt.hashSync(temppwd,10);
                console.log("Temppwd: " + temppwd + "Baseurl: " + baseurl);

                let sql = 'update t_user_credentials set temppwd=?, temppwdvalid=DATE_ADD(now(), INTERVAL 30 MINUTE) where userid=?;';

                pool.query(sql, [temppwd, email], function(err, result){
                    if(err) throw err;

                    let tempurl = baseurl + 'redirected_forgotpassword?t=' + temppwd;
                    if(result.affectedRows)
                    {
                        console.log("tempurl: " + tempurl);
                    }
                    else
                    {
                        console.log('0');
                        return callback(0); 
                    }
                })
            }
            else{
                console.log("There is no such existing user");
            }
        })
    },

    forgot_password_find: function(temppwd, callback)
    {
        let sql = 'select userid, password, temppwd from t_user_credentials where temppwd=? and temppwdvalid > now();';

        pool.query(sql, [temppwd], function(err, result){
            if(err) throw err;

            if(result.length > 0){
                console.log("Result Forgot Password: " + JSON.stringify(result));
                callback(result[0]);
            }
            else{
                console.log("Result Forgot Password 1: " + JSON.stringify(result));
                callback(null);
            }
        })
    },

    update_password: function(temppwd,password, callback){
        let pwd = bcrypt.hashSync(password,10);
        let sql = 'update t_user_credentials set password=? where temppwd=?';

        pool.query(sql,[pwd, temppwd], function(err, result){
            if(err) throw err;

            if(result.affectedRows)
            {
                console.log('result.affectedRows:' + result.affectedRows);
                return callback(result.affectedRows); 
            }
            else
            {
                console.log('0');
                return callback(0); 
            }
        })
    }
}

module.exports = User;