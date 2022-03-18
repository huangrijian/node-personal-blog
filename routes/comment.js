let express = require('express');
let router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')


/* 发布评论接口 */
router.post('/publish', async (req, res, next) => {
  // 获取评论的内容和文章id
  let { content, article_id, parent_cm_id, reply_nickname, reply_user_id } = req.body;
  // 获取当前用户名称
  let { username } = req.user

  try {
    // 根据用户名称查用户的id,头像和昵称
    let user = await querySql('select id,head_img,nickname from user where username = ?', [username]);
    let { id: user_id, head_img, nickname } = user[0]
    // 把 user_id,article_id,cmcontent,nickname,head_img,create_time 插入到 评论表
    let sql = `insert into 
    comment(user_id,article_id,cmcontent,nickname,head_img,parent_cm_id,reply_nickname,reply_user_id,create_time) 
    values(?,?,?,?,?,?,?,?,NOW())`
    await querySql(sql, [user_id, article_id, content, nickname, head_img, parent_cm_id, reply_nickname, reply_user_id])
    res.send({ code: 0, msg: '发表成功', data: null })
  } catch (e) {
    console.log(e);
    // 把错误交给错误中间件处理
    next(e)
  }
});



//获取评论列表接口
router.get('/list', async (req, res, next) => {
  let { article_id, list, offset, username } = req.query
  try {
    // 根据文章id查找对应的id,头像，昵称，评论，评论时间
    let sql = `select id,head_img,nickname,user_id,like_count,like_list,cmcontent,DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time 
    from comment where article_id = ?  && parent_cm_id = ? ORDER BY create_time DESC  LIMIT ${list} OFFSET ${offset};
    `
    // 父评论
    let result = await querySql(sql, [article_id, -1]);

    result.forEach((item) => {
      if (item.like_list.indexOf(username) !== -1) {
        item.is_like = true;
      } else {
        item.is_like = false
      }
    })

    let sql2 = `select parent_cm_id,reply_nickname,user_id, reply_user_id, id,head_img,nickname,cmcontent,DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time 
    from comment where article_id = ?  && parent_cm_id != ? ;
    `
    // 子评论
    let result2 = await querySql(sql2, [article_id, -1]);

    // 将非顶层评论推到顶层评论的子评论里面
    result.forEach((item) => {
      let arry = [];
      result2.forEach(items => {
        if (items.parent_cm_id === item.id) {
          arry.push(items)
        }
      })
      item.son = arry;
    })
    res.send({ code: 0, msg: '成功', data: result })
  } catch (e) {
    console.log(e)
    next(e)
  }
})
//获取评论列表数量
router.get('/listCount', async (req, res, next) => {
  let { article_id } = req.query
  try {
    let sql = `select * FROM comment WHERE article_id = ? && parent_cm_id = ?`;
    let result = await querySql(sql, [article_id, -1]);
    res.send({ code: 0, msg: '成功', count: result.length })
  } catch (e) {
    console.log(e)
    next(e)
  }
})

// 删除评论接口
router.post('/delete', async (req, res, next) => {
  let { comment_id } = req.body
  try {
    let sql = 'delete from comment where id = ?'
    let result = await querySql(sql, [comment_id])
    res.send({ code: 0, msg: '删除成功', data: null })
  } catch (e) {
    console.log(e)
    next(e)
  }
});


// 点赞评论
router.post('/like', async (req, res, next) => {

  // 点赞加1
  async function addLike(comment_id) {
    let sql2 = 'select like_count from comment where id = ? '
    let result2 = await querySql(sql2, [comment_id])
    let newlikeCount = result2[0].like_count + 1;
    let likesql = 'update comment set like_count = ? where id = ?'
    await querySql(likesql, [newlikeCount, comment_id])
    var likes = await querySql('select like_count from comment where id = ?', [comment_id]);
    return likes
  }
  // 将点赞的用户名push到点赞列表并且更新
  async function pushUsernameToLikeList(comment_id, username, like_list) {
    like_list.push(username)
    let newList = JSON.stringify(like_list);
    let sql = 'update comment set like_list = ? where id = ?'
    await querySql(sql, [newList, comment_id])
  }

  let { comment_id } = req.body
  let { username } = req.user
  try {
    let sql = 'select like_list from comment where id = ? '
    let result = await querySql(sql, [comment_id])
    let like_list = JSON.parse(result[0].like_list);
    let isSame = false;
    like_list.forEach((item) => {
      if (item === username) isSame = true;
    })
    if (!isSame) {
      // 将点赞数字＋1
      var likes = await addLike(comment_id);
      // 将点赞的用户名push到点赞列表
      await pushUsernameToLikeList(comment_id, username, like_list);
    }
    let response = isSame ? { code: -1, msg: '花有重开日，人无再少年。', count: likes }
      : { code: 200, msg: '赞+1', count: likes[0] }
    return res.send(response)
  } catch (e) {
    console.log(e)
    next(e)
  }
})



module.exports = router;
