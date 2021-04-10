var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
// 引入登录拦截jwt解密校验 引入解密token的模块
const expressJWT = require('express-jwt')
// 引入token密钥
const {PRIVATE_KEY} = require('./utils/constant')

var articleRouter = require('./routes/article');
var usersRouter = require('./routes/users');

var app = express();
 


// 导入并配置cors中间件 --(为了解决浏览器的跨域问题)
const cors = require('cors');
app.use(cors());

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 使用expressJwt拦截token
app.use(expressJWT({
  // 解密 密钥
  secret: PRIVATE_KEY,
  algorithms: ["HS256"]
 }).unless({
  path: [
    '/api/article/detail',
  '/api/users/login',
  '/api/users/register',
  '/api/article/allList',
  
] //⽩名单,除了这⾥写的地址，其 他的URL都需要验证
 }));


app.use('/api/article', articleRouter);
app.use('/api/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler 错误中间件
app.use(function(err, req, res, next) {
  if (err.name === 'UnauthorizedError') { 
    // 这个需要根据⾃⼰的业务逻辑来处理
    res.status(401).send({code:-1,msg:'token验证失败'});
   }else {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
   }
});



module.exports = app;
