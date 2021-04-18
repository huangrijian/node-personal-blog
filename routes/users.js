var express = require('express');
var router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')
// 引入给密码加密的方法、token密钥、过期时间
const {PWD_SALT, PRIVATE_KEY, EXPIRESD} = require('../utils/constant')
const {md5} = require('../utils/index')
// 引入处理token的方法
const jwt = require('jsonwebtoken')

/* 注册接口 */
router.post('/register', async (req, res, next) => {
  let {username,password,nickname} = req.body;
  try{
    // 查询有无相同的用户名或者相同昵称 逻辑或  =>  有真则为真，两个都是假才为假
    let user = await querySql('select * from user where username = ? OR nickname = ? ',[username,nickname]);
    // let nicknameuser = await querySql('select * from user where username = ?',[username]);
    if(!user || user.length === 0){
      // 调用加密方法给密码加密 
      password = md5(`${password}${PWD_SALT}`)
      // 然后再插入到数据库
      await querySql('insert into user(username,password,nickname) value(?,?,?)',[username,password,nickname])
      res.send({code:0,msg:"注册成功！"})
    }else {
      res.send({code:-1,msg:"账号已存在，请重新注册！"})
    }
  }catch(e){
    console.log(e);
    // 把错误交给错误中间件处理
    next(e)
  }
});

/* 登录接口 */
router.post('/login', async (req, res, next) => {
  // let {username,password} = req.body;
  let username = req.body.name;
  let password = req.body.password
  try{
    // 查询有无user
    let user = await querySql('select * from user where username = ?',[username]);
    console.log(user);
    if(!user || user.length === 0){
      // 如果查不到该账号
      res.send({code:-1,msg:'该账号不存在'})
    }else {
      // 调用加密方法给密码加密 
      password = md5(`${password}${PWD_SALT}`)
      // 把加密过后的密码以及用户名 和 数据库的数据  匹配
      let result = await querySql('select * from user where username = ? and password = ?',[username,password])
      // 如果该结果不存在，则显示密码或账号不正确
      if(!result || result.length === 0){
        res.send({code:-1,msg:'账号或密码不正确'})
      }else {
        // 如果该结果存在说明登录成功，则生成token
        let token = jwt.sign({username},PRIVATE_KEY,{expiresIn:EXPIRESD})
        res.send({code:0,msg:'登录成功',token:token})
      }
    }
  }catch(e){
    console.log(e);
    // 把错误交给错误中间件处理
    next(e)
  }
});

/* 获取用户信息 */
router.get('/info', async (req, res, next) => {
  // 这个req是经过了 expressJwt拦截token 后得到的对象  req.user可得到解密后的token信息
  console.log(req.user);
  let { username } = req.user
  try{
    let userinfo = await querySql('select nickname,head_img from user where username = ?',[username])
    res.send({code:0,msg:'成功',data:userinfo[0]})
  }catch(e){
    console.log(e);
    next(e)
  }
});

//用户信息更新接口
router.post('/updateUser',async(req,res,next) => {
  let {nickname,head_img} = req.body
  let {username} = req.user

  // 通过用户名去用户表查找对应的用户信息
  let userinfo = await querySql('select id from user where username = ?',[username])
  // 再从中取出用户id
  let user_id = userinfo[0].id
  try {
    // 更新用户信息
    await querySql('update user set nickname = ?,head_img = ? where username = ?',[nickname,head_img,username])
    // 通过用户id去更新评论表里的相对应的用户头像和用户昵称
    let r = await querySql('update comment set nickname = ?,head_img = ? where user_id = ?',[nickname,head_img,user_id])
    console.log("更新评论表",r);
    // console.log(ress);
    res.send({code:0,msg:'更新成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  } 
})

module.exports = router;
