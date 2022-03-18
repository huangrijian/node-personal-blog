let express = require('express');
let router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')


// 获取发言
router.get('/getSpeech', async (req, res, next) => {
  let sql = `select *,DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from speech`;
  let result = await querySql(sql);
  res.send({ code: 0, msg: '获取成功', data: result })
});

// 获取管理员的发言列表接⼝
router.get('/getSpeechList', async (req, res, next) => {
  // expressJwt拦截token 后得到的username
  let { username } = req.user
  try {
    // 根据用户名查找用户id
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql, [username])
    let user_id = user[0].id
    // 根据用户id查找文章 (也就是查找当前作者的文章,包括文章id,标题，内容)
    let sql = 'select id,title,content,DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from speech where user_id = ?'
    let result = await querySql(sql, [user_id])
    // 将找到的结果返回到前端
    res.send({ code: 0, msg: '获取成功', data: result })
  } catch (e) {
    console.log(e)
    next(e)
  }
});

// 获取发言详情接⼝
router.get('/detail', async (req, res, next) => {
  let article_id = req.query.article_id
  try {
    // 根据文章id查询相关数据
    let sql = `select id,title,content,
    visited,like_count,pic_url,author,
    DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from speech where id = ?`
    let result = await querySql(sql, [article_id]);
    res.send({ code: 0, msg: '获取成功', data: result[0] })
  } catch (e) {
    res.send({ code: 500, msg: '获取失败', error: e })
    next(e)
  }
});

// 更新文章接⼝
router.post('/update', async (req, res, next) => {
  let { article_id, title, content, pic_url } = req.body
  try {
    // 通过文章id修改文章对应的标题和内容和封面地址
    let sql = 'update speech set title = ?,content = ?,pic_url = ? where id = ?'
    await querySql(sql, [title, content, pic_url, article_id])
    res.send({ code: 0, msg: '更新成功', data: null })
  } catch (e) {
    console.log(e)
    next(e)
  }
});

router.post('/addArticle', async (req, res, next) => {
  // 获取标题和内容及分类
  let { title, content, pic_url } = req.body
  // 获取经过了 expressJwt拦截token后得到的username
  let { username } = req.user
  let nicknameRes = await querySql('select nickname from user where username = ?', [username])
  let nickname = nicknameRes[0].nickname
  let result = await querySql('select id from user where username = ?', [username])
  let user_id = result[0].id

  await querySql(
    `insert into speech (title,content,user_id,pic_url,author,
      create_time)values(?,?,?,?,?,localtime)`, [title, content, user_id, pic_url, nickname])
  res.send({ code: 0, msg: '新增成功', data: [title, content, user_id, pic_url, nickname] })
})

// 删除博客
router.post('/delete', async (req, res, next) => {
  let { article_id } = req.body
  let { username } = req.user
  try {
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql, [username])
    let user_id = user[0].id
    var sql = 'delete from speech where id = ? and user_id = ?'
    await querySql(sql, [article_id, user_id])
    res.send({ code: 0, msg: '删除成功', data: null })
  } catch (e) {
    console.log(e)
    next(e)
  }
});

module.exports = router;
