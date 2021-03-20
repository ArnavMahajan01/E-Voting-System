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
                sql = 'Insert into t_user_credentials(users_id, userid, password, userrole, ins_dt) values (?, ?, ?, 2, now());';

                pool.query(sql, [result.insertId, user.email, password], function(credential_err, credential_result){
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
                let sql = 'update t_user_credentials set password =? where userid =?';

                console.log("pwd: " + pwd + " username: " + username);

                pool.query(sql, [pwd, username.trim()], function(err, result){
                    
                    console.log(result);
                    console.log('result.affectedRows:' + result.affectedRows);

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
    
}

module.exports = User;