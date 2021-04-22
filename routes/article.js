var express = require('express');
var router = express.Router();
// 引入连接数据库的方法
const querySql = require('../db/index')
const {upload} = require('../utils/index')

/* 新增博客接⼝ */
router.post('/add', async(req, res, next) => {
  // 获取标题和内容及分类
  let {title,content,classname01,classname02,classname03,type,pic_url} = req.body
  // 获取经过了 expressJwt拦截token后得到的username
  let {username} = req.user

  try {
    // 根据用户名获取用户id
    let result = await querySql('select id from user where username = ?', [username])
    let user_id = result[0].id
    if(!classname01){
      // 如果当前的类名为空
      var cid01 = null;
      var className_01 = null;
   }else if(await querySql('select classify_id from classify where classname = ?', [classname01]) == false ){
    //  如果数据库里的分类表没有找到req的分类名，说明当前req的classname是一个新的分类名称，则将分类名称插入分类表
    await querySql('insert into classify(classname)values(?)',[classname01])
    //  再次获取分类id和分类名称
    var cid01 =  await querySql('select classify_id from classify where classname = ?', [classname01])
    cid01 = cid01[0].classify_id
    var className_01 =  await querySql('select classname from classify where classname = ?', [classname01])
    className_01 = className_01[0].classname
   }else {
      // 否则说明数据库已经有了这个分类名称，则 获取 该分类id和分类名称
      var cid01 =  await querySql('select classify_id from classify where classname = ?', [classname01])
      cid01 = cid01[0].classify_id
      var className_01 =  await querySql('select classname from classify where classname = ?', [classname01])
      className_01 = className_01[0].classname
   }

 
   if(!classname02){
    // 如果当前的类名为空
      var cid02 = null;
      var className_02 = null;
  }else if(await querySql('select classify_id from classify where classname = ?', [classname02]) == false ){
    //  如果数据库里的分类表没有找到req的分类名，说明当前req的classname是一个新的分类名称，则将分类名称插入分类表
    await querySql('insert into classify(classname)values(?)',[classname02])
    //  再次获取分类id和分类名称
    var cid02 =  await querySql('select classify_id from classify where classname = ?', [classname02])
    cid02 = cid02[0].classify_id
    var className_02 =  await querySql('select classname from classify where classname = ?', [classname02])
    className_02 = className_02[0].classname
  }else {
      // 否则说明数据库已经有了这个分类名称，则 获取 该分类id和分类名称
      var cid02 =  await querySql('select classify_id from classify where classname = ?', [classname02])
      cid02 = cid02[0].classify_id
      var className_02 =  await querySql('select classname from classify where classname = ?', [classname02])
      className_02 = className_02[0].classname
  }


 if(!classname03){
    // 如果当前的类名为空
    var cid03 = null;
    var className_03 = null;
  }else if(await querySql('select classify_id from classify where classname = ?', [classname03]) == false ){
  //  如果数据库里的分类表没有找到req的分类名，说明当前req的classname是一个新的分类名称，则将分类名称插入分类表
  await querySql('insert into classify(classname)values(?)',[classname03])
  //  再次获取分类id和分类名称
  var cid03 =  await querySql('select classify_id from classify where classname = ?', [classname03])
  cid03 = cid03[0].classify_id
  var className_03 =  await querySql('select classname from classify where classname = ?', [classname03])
  className_03 = className_03[0].classname
  }else {
    // 否则说明数据库已经有了这个分类名称，则 获取 该分类id和分类名称
    var cid03 =  await querySql('select classify_id from classify where classname = ?', [classname03])
    cid03 = cid03[0].classify_id
    var className_03 =  await querySql('select classname from classify where classname = ?', [classname03])
    className_03 = className_03[0].classname
  }

  // 判断type是否为空,不为空返回本身,为空返回0(代表文章类型是技术博文)
  type = type ? type : 0;

    // 将标题和内容和作者以及文章分类id和分类名称和封面地址插入数据库
    await querySql(
      `insert into article(title,content,user_id,
      classify_id01,classify_id02,classify_id03,
      class_name01,class_name02,class_name03,
      type,pic_url,
      create_time)values(?,?,?,?,?,?,?,?,?,?,?,localtime)`
    ,[title,content,user_id,
      cid01,cid02,cid03,
      className_01,className_02,className_03,
      type,pic_url
    ])

    res.send({code:0,msg:'新增成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

// 上传封面或头像接口 ，将图片保存在当前的 uploads 目录下
router.post('/upload',upload.single('head_img'),async(req,res,next) => {
  console.log(req.file)
  let imgPath = req.file.path.split('public')[1]
  let imgUrl = 'http://127.0.0.1:3000'+imgPath
  res.send({code:0,msg:'上传成功',data:imgUrl})
})

// 获取博客列表接⼝（根据type获取，不填则返回技术文章，type为1则返回生活说说）
router.get('/typeList', async(req, res, next) => {
  // select * from student limit(curPage-1)*pageSize,pageSize;
  try {

    // 当前页 和 每页的数量 以及类型， type为1则返回生活说说,为空则返回技术文章
    let{curPage,pageSize,type} = req.query

    // 如果有分页数据则执行分页查询
    if(curPage && pageSize) {
       if(!type){
        //  type为空则返回技术文章
          var start = (curPage - 1) * pageSize;
          // 获取所有博客的数量
          var numsql = 'select * from article where type = 0'
          var sql = `SELECT id,title,content,
          class_name01,class_name02,class_name03,type,pic_url,like_count,
          DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time FROM article where type = 0 limit ` + start + ',' + pageSize;
          var coust = await querySql(numsql)
          coust = coust.length
       }
      //  else 返回生活说说，这里先不写，是因为生活说说数量少暂时不需要分类
      
    }else {
      // 如果不分页...
      // 如果文章类型为1
      if(type == 1){
        // 则返回生活说说 type为1
         var sql = `select id,title,content,
          class_name01,class_name02,class_name03,type,pic_url,like_count,
          DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from article where type =`+type
      }else {
          // 否则返回技术文章 type为0
          //DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time 格式化时间
          var sql = `select id,title,content,
          class_name01,class_name02,class_name03,type,pic_url,like_count,
          DATE_FORMAT(create_time,"%Y-%m-%d %H:%i:%s") AS create_time from article where type = 0`
      }
    }

    
    let result = await querySql(sql)
    res.send({code:0,msg:'获取成功',data:result,coust})

  }catch(e){
    console.log(e)
    next(e)
  }
 });

// 获取单篇博客分类列表接⼝
router.get('/classify/single', async(req, res, next) => {
  try {
    let {classify_id01,classify_id02,classify_id03} = req.body
    let sql = 'select classname from classify where classify_id = ?'
      let classname01 = await querySql(sql,[classify_id01])
      let classname02 = await querySql(sql,[classify_id02])
      let classname03 = await querySql(sql,[classify_id03])
    res.send({code:0,msg:'获取单篇博客分类成功',data:{classname01,classname02,classname03}})
  }catch(e){
    console.log(e)
    next(e)
  }
 });

 // 获取单个分类的文章列表接⼝
router.get('/list/Singleclassify', async(req, res, next) => {
  
  try {
    
    let {classname} = req.query
    console.log(classname);
    let sql = `select pic_url,id,title,content,create_time,
    classify_id01,class_name01,
    classify_id02,class_name02,
    classify_id03,class_name03 from article where class_name01 = ? OR class_name02 = ?  OR class_name03 = ? `
    let list = await querySql(sql,[classname,classname,classname])
    res.send({code:0,msg:'获取单个标签分类成功',data:{list}})
  }catch(e){
    console.log(e)
    next(e)
  }
 });


// 删除博客接口
router.post('/delete', async(req, res, next) => {
  let {article_id} = req.body
  let {username} = req.user
  try {
    let userSql = 'select id from user where username = ?'
    let user = await querySql(userSql,[username])
    let user_id = user[0].id
    let sql = 'delete from article where id = ? and user_id = ?'
    let result = await querySql(sql,[article_id,user_id])
    res.send({code:0,msg:'删除成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  } 
});

// 获取全部博客分类接口
router.get('/classify', async(req, res, next) => {
  try {
    let sql = 'select classify_id,classname from classify'
    let result = await querySql(sql)
    res.send({code:0,msg:'获取博客分类成功',data:result})
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
    let sql = `select id,title,content,
    class_name01,classify_id01,
    class_name02,classify_id02,
    class_name03,classify_id03,
    visited,like_count,pic_url,
    DATE_FORMAT(create_time,"%Y-%m-%d%H:%i:%s") AS create_time from article where id = ?`
    let result = await querySql(sql,[article_id])
    let visited = result[0].visited + 1
    console.log("访问量",visited);
    // 将文章访问量＋1后更新到文章中
    await querySql('update article set visited = ? where id = ?',[visited,article_id])
    res.send({code:0,msg:'获取成功',data:result[0]})
  }catch(e){
    console.log(e)
    next(e)
  }
 });


 // 获取管理员的全部博客列表接⼝
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

// 点赞文章接口
router.post('/like',async(req,res,next)=> {
  let {article_id} = req.body
  let {username} = req.user
  try{
    // // 根据用户名查找用户id
    // let userSql = 'select id from user where username = ?'
    // let user = await querySql(userSql,[username])
    // let user_id = user[0].id

    // //先判断当前用户是否曾经点赞过该文章
    // let silkesql = 'select islike , like_count from article where user_id = ? AND id = ?'
    // let likeres = await querySql(silkesql,[user_id,article_id])

    // if(likeres[0].islike == 0){
    //   // 根据文章id查询出该文章的点赞数量
    //   let sql = 'select like_count from article where id = ? '
    //   let result = await querySql(sql,[article_id])
    //   let newlikeCount = result[0].like_count + 1;
    //   // 更新文章的点赞数量,并且把当前文章的islike改为1,代表着当前用户已经对当前文章实施了点赞行为
    //   let likesql = 'update article set islike = ?, like_count = ? where user_id = ? AND id = ?'
    //   await querySql(likesql,[1,newlikeCount,user_id,article_id])
    //   // 再次查询当前文章点赞数，并返回给前端
    //   let likeres = await querySql('select islike,like_count from article where user_id = ? AND id = ?',[user_id,article_id])
    //   res.send({code:0,msg:'点赞成功',data:likeres})
    // }else {
    //   res.send({code:-1,msg:'点赞失败，请勿重复点赞哦，亲~',data:likeres})
    // }

      let sql = 'select like_count from article where id = ? '
      let result = await querySql(sql,[article_id])
      let newlikeCount = result[0].like_count + 1;

      let likesql = 'update article set like_count = ? where id = ?'
      await querySql(likesql,[newlikeCount,article_id])

      let likeres = await querySql('select like_count from article where id = ?',[article_id])

      res.send({code:0,msg:'点赞成功',data:likeres})


  }catch(e){
    console.log(e)
    next(e)
  }
})

// 更新文章接⼝
router.post('/update', async(req, res, next) => {
  let {article_id,title,content,
    classname01,classname02,classname03,
    classid_01,classid_02,classid_03,pic_url
  } = req.body

  try {
    // 通过文章id修改文章对应的标题和内容和封面地址
    let sql = 'update article set title = ?,content = ?,class_name01 = ?,class_name02 = ?,class_name03 = ?,pic_url = ? where id = ?'
    await querySql(sql,[title,content,classname01,classname02,classname03,pic_url,article_id])

    // 通过 类id 修改类名表里的数据
    if(await querySql('select classname from classify where classname = ?',[classname01]) == false){
      let sql2 = 'update classify set classname = ? where classify_id = ?'
      await querySql(sql2,[classname01,classid_01])
    }

    if(await querySql('select classname from classify where classname = ?',[classname02]) == false){
    let sql3 = 'update classify set classname = ? where classify_id = ?'
    await querySql(sql3,[classname02,classid_02])
    }

    if(await querySql('select classname from classify where classname = ?',[classname03]) == false){
    let sql4 = 'update classify set classname = ? where classify_id = ?'
    await querySql(sql4,[classname03,classid_03])
    }
    res.send({code:0,msg:'更新成功',data:null})
  }catch(e){
    console.log(e)
    next(e)
  }
 });


module.exports = router;
