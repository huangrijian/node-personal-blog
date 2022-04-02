let createError = require('http-errors');
let express = require('express');
let path = require('path');
// let cookieParser = require('cookie-parser');
let logger = require('morgan');
// 引入登录拦截jwt解密校验 引入解密token的模块
const expressJWT = require('express-jwt')
// 引入token密钥
const { PRIVATE_KEY } = require('./utils/constant')

let articleRouter = require('./routes/article');
let usersRouter = require('./routes/users');
let commentRouter = require('./routes/comment');
let speechRouter = require('./routes/speech');
let photoWallRouter = require('./routes/photoWall');
let clearUnnecessaryPhotos = require('./tool/clearUnnecessaryPhotos');
let app = express();

// 每24小时执行一次清除多余照片操作;
// setInterval(() => {
//   clearUnnecessaryPhotos();
// },86400000)
// clearUnnecessaryPhotos();

// 导入并配置cors中间件 --(为了解决浏览器的跨域问题)
const cors = require('cors');
const { Console } = require('console');
let corsOptions = {
  // 跨域白名单地址(只允许该地址访问)
  origin: 'http://127.0.0.1',//填写当前的前端启动地址
  optionsSuccessStatus: 200
}
// 设置跨域白名单
let corsWeb = cors(corsOptions);
app.use(cors());

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
// app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 使用expressJwt拦截token
app.use(expressJWT({
  // 解密 密钥
  secret: PRIVATE_KEY,
  algorithms: ["HS256"]
}).unless({
  path: [
    '/',
    '/api/article/detail',
    '/api/article/search',
    '/api/users/login',
    '/api/users/register',
    '/api/article/allList',
    '/api/article/classify',
    '/api/article/searchCount',
    '/api/article/list/Singleclassify',
    '/api/article/getAllCount',
    '/api/article/getSinglePageArticleList',
    '/api/article/upload',
    '/api/comment/list',
    '/api/comment/listCount',
    '/api/article/typeList',
    '/api/article/timeShaft',
    '/api/article/getAllArticle',
    '/api/speech/getSpeech',
    '/api/photoWall/getPhoto'
  ] //⽩名单,除了这⾥写的地址，其 他的URL都需要验证
}));

// 访问静态资源
app.use(express.static('public'))
// 拼接请求地址的中间件
app.use('/api/article', corsWeb, articleRouter);
app.use('/api/users', corsWeb, usersRouter);
app.use('/api/comment', corsWeb, commentRouter);
app.use('/api/speech', corsWeb, speechRouter);
app.use('/api/photoWall', corsWeb, photoWallRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler 错误中间件
app.use(function (err, req, res, next) {
  if (err.name === 'UnauthorizedError') {
    // 这个需要根据⾃⼰的业务逻辑来处理
    res.status(401).send({ code: -1, msg: 'token验证失败' });
  } else {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
  }
});

// app.listen(3030,function(){
//   console.log('server start ...');
// });

module.exports = app;
