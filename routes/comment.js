var express = require('express');
var router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')


/* 发布评论接口 */
router.post('/publish', async (req, res, next) => {
  // 获取评论的内容和文章id
  let {content,article_id} = req.body;
  // 获取当前用户名称
  let{username} = req.user

  try{
    // 根据用户名称查用户的id,头像和昵称
    let user  = await querySql('select id,head_img,nickname from user where username = ?',[username]);
    let {id:user_id,head_img,nickname} = user[0]
    // 把 user_id,article_id,cmcontent,nickname,head_img,create_time 插入到 评论表
    let sql = 'insert into comment(user_id,article_id,cmcontent,nickname,head_img,create_time) values(?,?,?,?,?,NOW())'
    await querySql(sql,[user_id,article_id,content,nickname,head_img])
    res.send({code:0,msg:'发表成功',data:null})
  }catch(e){
    console.log(e);
    // 把错误交给错误中间件处理
    next(e)
  }
});



//获取评论列表接口
router.get('/list',async(req,res,next) => {
  let {article_id} = req.query
  try {
    // 根据文章id查找对应的id,头像，昵称，评论，评论时间
    let sql = 'select id,head_img,nickname,cmcontent,DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from comment where article_id = ?'
    let result = await querySql(sql,[article_id])
    res.send({code:0,msg:'成功',data:result})
  }catch(e){
    console.log(e)
    next(e)
  } 
})

// 删除评论接口
router.post('/delete', async(req, res, next) => {
  let {comment_id} = req.body
  try {
    let sql = 'delete from comment where id = ?'
    let result = await querySql(sql,[comment_id])
    res.send({code:0,msg:'删除成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  } 
});
module.exports = router;
