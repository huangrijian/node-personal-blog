var express = require('express');
var router = express.Router();
// 引入连接数据库的方法
const quertSql = require('../db/index')
// 引入给密码加密的方法
const {PWD_SALT} = require('../utils/constant')
const {md5} = require('../utils/index')

/* 注册接口 */
router.post('/register', async (req, res, next) => {
  let {username,password,nickname} = req.body;
  try{
    // 查询有无user
    let user = await quertSql('select * from user where username = ?',[username]);
    if(!user || user.length === 0){
      // 调用加密方法给密码加密 
      password = md5(`${password}${PWD_SALT}`)
      // 然后再插入到数据库
      await quertSql('insert into user(username,password,nickname) value(?,?,?)',[username,password,nickname])
      res.send({code:0,msg:"注册成功！"})
    }
  }catch(e){
    console.log(e);
    // 把错误交给错误中间件处理
    next(e)
  }

});

module.exports = router;
