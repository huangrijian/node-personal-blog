let express = require('express');
let router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')

router.post('/savePhoto', async (req, res, next) => {
  // 获取标题和内容及分类
  let { response:{uid, url, name, percentage, size, status} } = req.body;

  let result = await querySql(`
  insert into photoWall(uid, url, name, percentage, size, status)values(?,?,?,?,?,?)`,
  [uid, url, name, percentage, size, status])

  res.send({ code: 0, msg: '新增成功', data: result })

})

router.post('/changeTitle', async (req, res, next) => {
  let { uid, title } = req.body;
  await querySql(`update photoWall set title = ? where uid = ?`,[title, uid])

  res.send({ code: 0, msg: '修改成功', data: null })

})

router.get('/getPhoto', async (req, res, next) => {
  let sql = 'select * from photoWall';
  let result = await querySql(sql);
  res.send({ code: 0, msg: '获取成功', data: result });
})

module.exports = router;