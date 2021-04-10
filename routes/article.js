var express = require('express');
var router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')

/* 新增博客接⼝ */
router.post('/add', async(req, res, next) => {
  // 获取标题和内容
  let {title,content} = req.body
  // 获取经过了 expressJwt拦截token后得到的username
  let {username} = req.user
  try {
    // 根据用户名获取用户id
    let result = await querySql('select id from user where username = ?', [username])
    console.log("用户id");
    console.log(result);
    let user_id = result[0].id
    console.log(user_id);
    // 将标题和内容和作者（用户id)插入数据库
    await querySql('insert into article(title,content,user_id,create_time)values(?,?,?,NOW())',[title,content,user_id])
    res.send({code:0,msg:'新增成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

// 获取全部博客列表接⼝
router.get('/allList', async(req, res, next) => {
  try {
    //DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time 格式化时间
    let sql = 'select id,title,content,DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article'
    let result = await querySql(sql)
    res.send({code:0,msg:'获取成功',data:result})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

 // 获取博客详情接⼝
router.get('/detail', async(req, res, next) => {
  let article_id = req.query.article_id
  try {
    // 根据文章id查询相关数据
    let sql = 'select id,title,content,DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article where id = ?'
    let result = await querySql(sql,[article_id])
    res.send({code:0,msg:'获取成功',data:result[0]})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

 // 获取我的博客列表接⼝
router.get('/myList', async(req, res, next) => {
  // expressJwt拦截token 后得到的username
    let {username} = req.user
  try {
    // 根据用户名查找用户id
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql,[username])
    let user_id = user[0].id
    // 根据用户id查找文章 (也就是查找当前作者的文章,包括文章id,标题，内容)
    let sql = 'select id,title,content,DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article where user_id = ?'
    let result = await querySql(sql,[user_id])
    // 将找到的结果返回到前端
    res.send({code:0,msg:'获取成功',data:result})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

// 更新文章接⼝
router.post('/update', async(req, res, next) => {
  let {article_id,title,content} = req.body
  try {
    // 通过文章id修改文章对应的标题和内容
    let sql = 'update article set title = ?,content = ? where id = ?'
    await querySql(sql,[title,content,article_id])
    res.send({code:0,msg:'更新成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  }
 });
module.exports = router;
