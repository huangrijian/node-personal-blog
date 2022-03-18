let express = require('express');
let router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')
const { upload, parseRes } = require('../utils/index')

router.post('/addArticle', async (req, res, next) => {

  try {
    // 获取标题和内容及分类
    let { title, content, type, pic_url, classify, brief } = req.body
    // 获取经过了 expressJwt拦截token后得到的username
    let { username } = req.user
    let nicknameRes = await querySql('select nickname from user where username = ?', [username])
    let nickname = nicknameRes[0].nickname

    // 根据用户名获取用户id
    let result = await querySql('select id from user where username = ?', [username])
    let user_id = result[0].id

    let classifyList = JSON.stringify(classify)

    // 判断type是否为空,不为空返回本身,为空返回0(代表文章类型是技术博文)
    type = type ? type : 0;

    // 将标题和内容和作者以及文章分类id和分类名称和封面地址插入数据库
    let { insertId } = await querySql(
      `insert into article(title,content,user_id,
        type,pic_url,author,classify,brief,
        create_time)values(?,?,?,?,?,?,?,?,localtime)`
      , [title, content, user_id, type, pic_url, nickname, classifyList, brief])


    classify.forEach(async (item) => {
      let data = await querySql('select list from classify where classname = ?', [item]);
      if (data.length == 0) {
        // 新的类别直接插入
        await querySql(`insert into classify(classname, list)values(?,?)`, [item, JSON.stringify([insertId])])
      } else {
        let newLists = new Set(JSON.parse(data[0].list).concat(insertId))
        let newList = JSON.stringify([...newLists])
        await querySql(`update classify set list = ? where classname = ? `, [newList, item])
      }
    });

    res.send({ code: 0, msg: '新增成功', data: null })
  } catch (error) {
    console.log(error);
    next(error)
  }

})


// 上传封面或头像 ，将图片保存在当前的 uploads 目录下
router.post('/upload', upload.single('head_img'), async (req, res, next) => {
  // let url = 'http://112.124.52.188:4000';
  let url = 'http://127.0.0.1:4000';
  let imgPath = req.file.path.split('public')[1];
  let imgUrl = url + imgPath
  res.send({ code: 0, msg: '上传成功', data: imgUrl })
})


// 获取单页文章列表
router.get('/getSinglePageArticleList', async (req, res, next) => {

  let { limt, offset } = req.query

  let sql = `select id,title,content,author,classify,type,pic_url,like_count,brief,
  DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from article LIMIT ${limt} OFFSET ${offset}`;

  let result = await querySql(sql);

  res.send({ code: 0, msg: '获取成功', data: parseRes(result) })
});



// 获取全部文章列表的数量
router.get('/getAllCount', async (req, res, next) => {
  let sql = `select count(*) from article;`;
  let result = await querySql(sql);
  res.send({ code: 0, msg: '获取成功', count: result[0]['count(*)'] })
});

// 获取全部文章列表
router.get('/getAllArticle', async (req, res, next) => {
  try {
    let sql = `select id,title,content,author,classify,type,pic_url,like_count,brief,
    DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from article where type = 0`;
    let result = await querySql(sql);
    res.send({ code: 0, msg: '获取成功', data: parseRes(result) })
  } catch (error) {
    next(error)
  }
});


// 通过单个分类获取文章列表
router.get('/list/Singleclassify', async ({ query: { classname, limit, offset } }, res, next) => {

  async function getArticleIdList(classname) {
    let sql = `SELECT list FROM classify WHERE classname = '${classname}'`

    let res = await querySql(sql)
    let idArray = JSON.parse(res[0].list);
    let idList = idArray.length > 0 ? idArray.join() : 0;
    return idList;
  }

  async function getArticleInfoData(idList) {
    let sql = `SELECT pic_url,title,content,create_time,classify, id FROM article 
    WHERE id IN (${idList}) LIMIT ${limit} OFFSET ${offset}`
    let list = await querySql(sql)

    let articleArr = list.map((item) => {
      if (item.classify !== '[]') {
        item.classify = JSON.parse(item.classify);
      } else {
        item.classify = [];
      }
      return item
    })
    return articleArr
  }

  try {
    // 获取某分类下的所有文章id列表 如:93,95
    let idList = await getArticleIdList(classname);
    let idListLength = [...new Set(idList.split(','))].length
    // 通过id列表 (如:93,95)获取文章信息数据
    let arr = await getArticleInfoData(idList)
    res.send({ code: 0, msg: '获取单个标签分类成功', data: { list: arr }, count: idListLength })
  } catch (e) {
    next(e)
  }
});


// 删除博客
router.post('/delete', async (req, res, next) => {

  // 删除文章
  async function deleteArticle(article_id, username) {
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql, [username])
    let user_id = user[0].id
    var sql = 'delete from article where id = ? and user_id = ?'
    await querySql(sql, [article_id, user_id])
  }

  // 更新分类表的list,list装的是文章id的集合
  async function updateClassifyList(article_id, classname) {
    let sql = 'select list from classify where classname = ?'
    let classifyList = await querySql(sql, [classname]);

    let arr = [... new Set(JSON.parse(classifyList[0].list))].filter(item => {
      if (String(item) !== String(article_id)) return true;
    })
    await querySql(`update classify set list = ? where classname = ? `, [JSON.stringify(arr), classname])
  }

  // 删除分类列表中的文章id
  async function deleteArticleIdOnClassify(article_id) {
    // 1.根据id获取文章所有分类
    let sql = 'select classify from article where id = ?'
    let classify = await querySql(sql, [article_id]);
    let classifyArr = JSON.parse(classify[0].classify)
    classifyArr.forEach(async (item) => {
      // 2.根据分类名称从分类表的list中删除对应的id，然后更新list
      await updateClassifyList(article_id, item)
    })
  }
  let { article_id } = req.body
  let { username } = req.user
  try {
    await deleteArticleIdOnClassify(article_id)
    await deleteArticle(article_id, username);
    res.send({ code: 0, msg: '删除成功', data: null })
  } catch (e) {
    console.log(e)
    next(e)
  }
});

// 获取全部博客分类（list不为空的）
router.get('/classify', async (req, res, next) => {
  try {
    var sql = 'select classify_id,classname from classify where list != ?'
    let result = await querySql(sql, [`[]`])
    res.send({ code: 0, msg: '获取博客分类成功', data: result })
  } catch (e) {
    console.log(e)
    next(e)
  }
});


// 获取博客详情
router.get('/detail', async (req, res, next) => {
  let article_id = req.query.article_id
  try {
    // 根据文章id查询相关数据
    var sql = `select id,title,content,
    visited,like_count,pic_url,author,classify,brief,
    DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article where id = ?`

    let result = await querySql(sql, [article_id]);
    result[0].classify = JSON.parse(result[0].classify);

    let visited = result[0].visited + 1
    // 将文章访问量＋1后更新到文章中
    await querySql('update article set visited = ? where id = ?', [visited, article_id])
    res.send({ code: 0, msg: '获取成功', data: result[0] })
  } catch (e) {
    console.log(e)
    next(e)
  }
});


// 获取管理员的全部博客列表
router.get('/myList', async (req, res, next) => {
  // expressJwt拦截token 后得到的username
  let { username } = req.user
  try {
    // 根据用户名查找用户id
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql, [username])
    let user_id = user[0].id
    // 根据用户id查找文章 (也就是查找当前作者的文章,包括文章id,标题，内容)
    var sql = 'select id,title,content,DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article where user_id = ?'
    let result = await querySql(sql, [user_id])
    // 将找到的结果返回到前端
    res.send({ code: 0, msg: '获取成功', data: result })
  } catch (e) {
    console.log(e)
    next(e)
  }
});


// 获取文章时间轴
router.get('/timeShaft', async (req, res, next) => {

  async function filtration(...timer) {
    let result = [];
    for (let i = 0; i < timer.length; i++) {
      var sql = `SELECT id,title,DATE_FORMAT(create_time,"%Y-%m-%d") AS create_time
      FROM article WHERE create_time LIKE '%${timer[i]}%' order by create_time desc;`
      let res = await querySql(sql);
      res.r
      let dataObj = {
        year: timer[i],
        data: res
      }
      result.push(dataObj);
    }
    result.reverse();
    return result
  }

  try {
    res.send({ code: 0, msg: '获取成功', data: await filtration(2021, 2022) })
  } catch (e) {
    next(e)
  }
});


// 点赞文章
router.post('/like', async (req, res, next) => {

  // 点赞加1
  async function addLike(article_id) {
    let sql2 = 'select like_count from article where id = ? '
    let result2 = await querySql(sql2, [article_id])
    let newlikeCount = result2[0].like_count + 1;
    let likesql = 'update article set like_count = ? where id = ?'
    await querySql(likesql, [newlikeCount, article_id])
    var likes = await querySql('select like_count from article where id = ?', [article_id]);
    return likes
  }
  // 将点赞的用户名push到点赞列表并且更新
  async function pushUsernameToLikeList(article_id, username, like_list) {
    like_list.push(username)
    let newList = JSON.stringify(like_list);
    let sql = 'update article set like_list = ? where id = ?'
    await querySql(sql, [newList, article_id])
  }

  let { article_id } = req.body
  let { username } = req.user
  try {
    let sql = 'select like_list from article where id = ? '
    let result = await querySql(sql, [article_id])
    let like_list = JSON.parse(result[0].like_list);
    let isSame = false;
    like_list.forEach((item) => {
      if (item === username) isSame = true;
    })
    if (!isSame) {
      // 将点赞数字＋1
      var likes = await addLike(article_id);
      // 将点赞的用户名push到点赞列表
      await pushUsernameToLikeList(article_id, username, like_list);
    }
    let response = isSame ? { code: -1, msg: '花有重开日，人无再少年。', count: likes }
      : { code: 200, msg: '赞+1', count: likes[0] }
    return res.send(response)
  } catch (e) {
    console.log(e)
    next(e)
  }
})

// 搜索文章
router.post('/search', async (req, res, next) => {
  let { limit, offset, keyWord } = req.body
  try {
    var sql = `SELECT * FROM article 
    WHERE title LIKE '%${keyWord}%'|| content LIKE '%${keyWord}%' LIMIT ${limit} OFFSET ${offset}`
    let result = await querySql(sql);
    let arr = result.map((item) => {
      if (item.classify !== '[]') {
        item.classify = JSON.parse(item.classify);
      } else {
        item.classify = [];
      }
      return item
    })
    res.send({ code: 0, msg: '搜索成功', result: arr })
  } catch (e) {
    next(e)
  }
})

// 搜索文章符合条件的数量
router.post('/searchCount', async (req, res, next) => {
  let { keyWord } = req.body
  try {
    var sql = `SELECT count(*) FROM article 
    WHERE title LIKE '%${keyWord}%'|| content LIKE '%${keyWord}%'`
    let result = await querySql(sql);
    res.send({ code: 0, msg: '获取搜索数量成功', count: result[0]['count(*)'] })
  } catch (e) {
    next(e)
  }
})



// 删除文章单个分类
router.post('/deleteClassify', async (req, res, next) => {
  let { article_id, classifyName } = req.body
  let list1 = await querySql(`select list from classify where classname = ?`, [classifyName])
  let list2 = await querySql(`select classify from article where id = ?`, [article_id])

  let arr = JSON.parse(list1[0].list).filter((item) => {
    return item !== article_id
  })
  let arr2 = JSON.parse(list2[0].classify).filter((item) => {
    return item !== classifyName
  })

  await querySql(`update classify set list = ? where classname = ? `, [JSON.stringify(arr), classifyName])
  await querySql(`update article set classify = ? where id = ? `, [JSON.stringify(arr2), article_id])

  res.send({ code: 0, msg: '删除成功', data: null })
})


// 更新文章
router.post('/update', async (req, res, next) => {
  let { article_id, title, content, pic_url, classify, brief } = req.body

  let classifyArr = JSON.stringify(classify);

  try {
    // 通过文章id修改文章对应的标题和内容和封面地址
    var sql = 'update article set classify = ?, title = ?,content = ?,pic_url = ?, brief = ? where id = ?'
    await querySql(sql, [classifyArr, title, content, pic_url, brief, article_id])
    classify.forEach(async (item) => {
      let data = await querySql('select list from classify where classname = ?', [item]);
      if (data.length == 0) {
        // 新的类别直接插入
        await querySql(`insert into classify(classname, list)values(?,?)`, [item, JSON.stringify([article_id])])
      } else {
        let newLists = new Set(JSON.parse(data[0].list).concat(article_id))
        let newList = JSON.stringify([...newLists])
        await querySql(`update classify set list = ? where classname = ? `, [newList, item])
      }
    });
    res.send({ code: 0, msg: '更新成功', data: null })
  } catch (e) {
    console.log(e)
    next(e)
  }
});


module.exports = router;
