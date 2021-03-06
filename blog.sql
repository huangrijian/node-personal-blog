/*
 Navicat Premium Data Transfer

 Source Server         : hrj
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 30/03/2022 12:06:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文章内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `user_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '作者id',
  `type` int(0) NULL DEFAULT 0 COMMENT '文章类型：默认0为技术文章，1为生活说说',
  `pic_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文章封面',
  `visited` int(0) NOT NULL DEFAULT 1 COMMENT '文章访问量',
  `like_count` int(0) NOT NULL DEFAULT 0 COMMENT '点赞数量',
  `islike` tinyint(0) NOT NULL DEFAULT 0 COMMENT '当前用户是否点赞了，默认为0,已点赞则为1',
  `author` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `classify` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '[]' COMMENT '分类数组，存储分类id',
  `like_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '[]' COMMENT '点赞列表，存储已点赞的用户id',
  `brief` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章简介',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 226 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (93, '2021年初级Vue面试题目', '\n### 1.var let const 的区别\n\nvar 会变量提升 let 和 const 不会\nvar 在全局命名的变量会挂载到 window 上，let const 不会\nlet 和 const 有块级作用域（暂时性死去），var 没有\nlet const 不允许重复命名\n\n#### 2.Vue 里面 computed 是什么东西怎么用？\n\n在 vue 模板里面是有表达式是非常便利的，但是设计他们的初衷是用来简单运算的。在实际的开发过程中在模板里放入过多的表达式会让项目的可维护性大大降低。\n```html\n<div>\n{{ data.split(\'\') ? data.split(\'\').reverse().join(\'\') : data.split(\'\')}}\n</div>\n```\n对于这种复杂的计算单数据，我们应该使用计算属性来解决；\n计算属性中的方法是依赖于其中的值的，当计算属性中的值变化的时候，计算属性会更新\n```js\nvar vm = new Vue({\n  el: \'#example\',\n  data: {\n  data: \'Hello\'\n  },\n  computed: {\n    // 计算属性的getter\n    reversedMessage: function () {\n    // `this` 指向 vm 实例\n    return this.data.split(\'\').reverse().join(\'\')\n    }\n  }\n})\n```\n当 this.data 的值发生变化大时候，他所依赖的计算属性 reversedMessage 会重新计算并调用\n\n#### 3.Vue 里面的 watch 是什么东西怎么使用？\n\n虽然计算属性在大部分情况下都适用，但是在实际开发过程中需要一些自定义的监听器，当需要在执行异步或者开销比较大的操作中，监听器比计算属性更加有效。\n\n```js\nwatch：{\n  //需要监听的值\n  question（）{\n\n  }\n}\n```\n#### 4.watch和computed的区别\n\n\n>计算属性和监听属性都是希望在依赖数据变化的时候，被依赖的数据根据事先设定好的函数发生自动的变换。 watch 一个数据相应多个数据 computed 一个数据受到多个数据的影响 在实现原理上watch和computed是差不多的，vue 的data值在初始化阶段都会被挂载上 watcher 观察者模式，当数据改变的时候先调用watcher观察者模式，然后调用计算属性，和监听属性。本质上来说没有多大区别\n\n#### 5.请说出 vue 几种常用的指令\n\nv-if：根据表达式的值的真假条件渲染元素。在切换时元素及它的数据绑定 / 组件被销毁并重建。\n\nv-show：根据表达式之真假值，切换元素的 display CSS 属性。\n\nv-for：循环指令，基于一个数组或者对象渲染一个列表，vue 2.0 以上必须需配合 key 值 使用。\n\nv-bind：动态地绑定一个或多个特性，或一个组件 prop 到表达式。\n\nv-on：用于监听指定元素的 DOM 事件，比如点击事件。绑定事件监听器。\n\nv-model：实现表单输入和应用状态之间的双向绑定\n\nv-pre：跳过这个元素和它的子元素的编译过程。可以用来显示原始\n\nMustache 标签。跳过大量没有指令的节点会加快编译。\n\nv-once：只渲染元素和组件一次。随后的重新渲染，元素/组件及其所有的子节点将被视为静态内容并跳过。这可以用于优化更新性能。\n\n#### 6.v-if 和 v-show 有什么区别\n\n**共同点：**\n\nv-if 和 v-show 都是动态显示 DOM 元素。\n\n**区别：**\n\n1、编译过程： v-if 是 真正 的 条件渲染，因为它会确保在切换过程中条件块 内的事件监听器和子组件适当地被销毁和重建。v-show 的元素始终会被渲染并 保留在 DOM 中。 v-show 只是简单地切换元素的 CSS 属性 display。\n\n2、编译条件： v-if 是惰性的：如果在初始渲染时条件为假，则什么也不做。直 到条件第一次变为真时，才会开始渲染条件块。v-show 不管初始条件是什么， 元素总是会被渲染，并且只是简单地基于 CSS 进行切换。\n\n3、性能消耗： v-if 有更高的切换消耗。v-show 有更高的初始渲染消耗。\n\n4、应用场景： v-if 适合运行时条件很少改变时使用。v-show 适合频繁切换。\n\n#### 7.vue 中子组件调用父组件的方法\n通过 v-on 监听 和emit\'触发 当前实例上的 自定义事件。 示例： 父组件：\n```html\n<template>\n  <div class=\"fatherPageWrap\">\n  <h1>这是父组件</h1>\n<!-- 引入子组件，v-on 监听自定义事件 -->\n  <emitChild v-on:emitMethods=\"fatherMethod\"></emitChild>\n  </div>\n</template>\n<script type=\"text/javascript\">\nimport emitChild from \'@/page/children/emitChild.vue\';\nexport default{\n  data () {\n  return {}\n  },\n  components : {\n  emitChild\n  },\n  methods : {\n    fatherMethod(params){\n      alert(JSON.stringify(params));\n    }\n  }\n}</script>\n  \n<!--子组件：-->\n\n<template>\n  <div class=\"childPageWrap\">\n    <h1>这是子组件</h1>\n  </div>\n</template>\n<script type=\"text/javascript\">\nexport default{\n  data () {\n    return {}\n  },\n  mounted () {\n  //通过 emit 触发\n  this.$emit(\'emitMethods\',{\"name\" : 123});\n  }\n}</script>\n结果：\n子组件 会调用 父组件的 fatherMethod 方法，该并且会 alert 传递过去的参\n数：{\"name\":123}\n\n```\n#### 8.axios 有哪些特点？\n\n1、Axios 是一个基于 promise 的 HTTP 库，支持 promise 所有的 API\n\n2、它可以拦截请求和响应\n\n3、它可以转换请求数据和响应数据，并对响应回来的内容自动转换成 JSON 类 型的数据\n\n4、安全性更高，客户端支持防御 XSRF\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:4000\\uploads\\20220216\\1645021751181.jpg', 637, 31, 1, '怪蜀黍', '[]', '[\"999\",\"aaa\"]', 'var 会变量提升 let 和 const 不会 var 在全局命名的变量会挂载到 window 上，let const 不会 let 和 const 有块级作用域（暂时性死去），var 没有 let const 不允许重复命名');
INSERT INTO `article` VALUES (95, 'es6-Promise解决回调地狱', '1、什么是回调地狱?\n假如我们有很多异步事件，而这些异步事件又有很紧密的联系，比如一个异步事件要依赖另一个异步事件的返回值，看下面的：\n\n```js\n $.ajax({\n        url: \'\',\n        data: {},\n        type: \'post\',\n        dataType: JSON,\n        success: function (res) {\n            $.ajax({\n                url: \'\',\n                data: res.data,\n                type: \'post\',\n                dataType: JSON,\n                success: function (res1) {\n                    $.ajax({\n                        url: \'\',\n                        data: res1.data,\n                        type: \'post\',\n                        dataType: JSON,\n                        success: function (res2) {\n                            $.ajax({\n                                url: \'\',\n                                data: res2.data,\n                                type: \'post\',\n                                dataType: JSON,\n                                success: function (res3) {\n                                    console.log(res3)\n                                }\n                            })\n                        }\n                    })\n                }\n            })\n        }\n    })\n```\n是不是进入了一环套一环的地狱里面。我们可以简单处理下：\n\n```js\n function ajax1() {\n        $.ajax({\n            url: \'\',\n            data: {},\n            type: \'post\',\n            dataType: JSON,\n            success: function (res) {\n                ajax2(res.data)\n            }\n        })\n    }\n    function ajax2(data) {\n        $.ajax({\n            url: \'\',\n            data: data,\n            type: \'post\',\n            dataType: JSON,\n            success: function (res) {\n                ajax3(res.data)\n            }\n        })\n    }\n    function ajax3(data) {\n        $.ajax({\n            url: \'\',\n            data: data,\n            type: \'post\',\n            dataType: JSON,\n            success: function (res) {\n                console.log(res)\n            }\n        })\n    }\n    ajax1();\n```\n这样虽然把每个ajax请求放在了函数里面，不用把所有请求放在一个方法里面，但实际上还是在函数里面一层一层的嵌套来实现，很不便于阅读和维护。\n\n2、看看promise是如何解决的\npromise的出现就是为了解决异步编程中的回调问题，它提供了统一的 API\n```js\n   const ajax1 = new Promise(function (resolve,reject) {\n        $.ajax({\n            url: \'\',\n            data: {},\n            type: \'post\',\n            dataType: JSON,\n            success: function (res) {\n                resolve(res.data)\n            }\n        })\n    })\n    function ajax2 (data) {\n        return new Promise(function (resolve,reject) {\n            $.ajax({\n                url: \'\',\n                data: data,\n                type: \'post\',\n                dataType: JSON,\n                success: function (res) {\n                    resolve(res.data)\n                }\n            })\n        })\n    }\n    function ajax3 (data) {\n        return new Promise(function (resolve,reject) {\n            $.ajax({\n                url: \'\',\n                data: data,\n                type: \'post\',\n                dataType: JSON,\n                success: function (res) {\n                    resolve(res.data)\n                }\n            })\n        })\n    }\n    ajax1.then(function (data) {\n        return ajax2(data)\n    }).then(function (data) {\n        return ajax3(data)\n    })\n```\n这就很很好的解决了回调地狱的问题', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210418\\1618728405902.jpg', 94, 11, 1, '怪蜀黍', '[\"es6\",\"回调地狱\"]', '[\"999\"]', NULL);
INSERT INTO `article` VALUES (96, 'sessionStorage只能存储字符串吗？', 'sessionStorage.setItem(\'xxx\',true),取出来结果\"true\"字符串\nsessionStorage.setItem(\'xxx\',{}),取出来结果\"[object Object]\"\n怎么存别的类型？\nsessionStorage和localStorage只能存字符串，针对对象需要存储storage的话可以序列化一下达到效果：\n\nvar obj = {};\n\nsessionStorage.setItem(\'xxx\', JSON.stringify(obj)); //序列化\n\nobj = JSON.parse(sessionStorage.getItem(\'xxx\')); //这时候需要反序列化一下\n\n', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210415\\1618490563294.jpg', 64, 3, 0, '怪蜀黍', '[]', '[]', 'sessionStorage只能存储字符串吗？');
INSERT INTO `article` VALUES (97, 'vue之路由钩子函数', '> vue路由钩子函数可以大致分为三类，他们的作用都是主要对路由的跳转进行控制，例如权限管理、登录判断、浏览器判断。\n\n1.全局钩子\n主要包括beforeEach和afterEach,\n\n一般有三个参数：\n\nto:router即将进入的路由对象\n\nfrom:当前导航即将离开的路由\n\nnext:Function,进行管道中的一个钩子，如果执行完了，则导航的状态就是 confirmed （确认的）；否则为false，终止导航。\n\n通过beforeEach来对路由跳转做权限管理：\n\n```js\n// 设置路由\nrouter.beforeEach((to, from, next) => {\n  console.log(to, from)\n  // 跳转前判断是否需要登录\n  if (to.meta.auto) {\n    sessionStorage.setItem(\'success\', to.path)\n    if (store.getters[\'login/getLogin\']) {\n      next()\n    } else {\n      next({ path: \'pleaseLogin\' })\n    }\n  } else {\n    next()\n  }\n})\n```\nrouter.beforeEach 页面加载之前\n\nrouter.afterEach  页面加载之后\n\n2、单个路由里面的钩子\nbeforeEnter和beforeLeave\n```js\nbeforeEnter: (to, from, next) => {          \n   console.log(to,from,next)\n},\nbeforeLeave: (to, from, next) => {\n   console.log(to,from,next)\n},\n```\n3、组件路由\nbeforeRouteEnter和beforeRouteUpdate,beforeRouteLeave\n```js\n\nbeforeRouteEnter(to, from, next) {\n   console.log(to)\n},\nbeforeRouteUpdate(to, from, next) {\n   console.log(to)\n},\nbeforeRouteLeave(to, from, next) {\n   console.log(to)\n}', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210415\\1618490592929.jpg', 52, 3, 1, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (98, '使用axios发送get和post请求详解', '发送get请求\n\n方法一：\n在axios方法中直接传入一个对象，配置请求路径：url,\n传递参数：params。然后使用。.then方法获得响应数据\n\n```js\n//配置接口地址\naxios.defaults.baseURL = \'http://127.0.0.1:3000\'\nfunction testget() {\n            axios({\n                    url: \'/a\',\n                    params: {\n                        id: 1\n                    }\n                })\n                .then(response => {\n                    console.log(\'/a\', response.data)\n                    return response.data\n                }, error => {\n                    console.log(\'错误\', error.message)\n                })\n        }\ntestget()\n', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210415\\1618490625539.jpg', 40, 6, 1, '怪蜀黍', '[]', '[\"999\"]', NULL);
INSERT INTO `article` VALUES (99, 'cursor:pointer;', 'cursor:pointer;', '2021-04-12 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210420\\1618917611885.jpg', 51, 10, 1, '怪蜀黍', '[]', '[\"aaa\"]', NULL);
INSERT INTO `article` VALUES (100, '23 个 Vue.js 初级面试题', '#### 1. 为什么Vue被称为“渐进框架”？\n\n使用渐进式框架的代价很小，从而使现有项目（使用其他技术构建的项目）更容易采用并迁移到新框架。 Vue.js 是一个渐进式框架，因为你可以逐步将其引入现有应用，而不必从头开始重写整个程序。\n\nVue 的最基本和核心的部分涉及“视图”层，因此可以通过逐步将 Vue 引入程序并替换“视图”实现来开始你的旅程。\n\n由于其不断发展的性质，Vue 与其他库配合使用非常好，并且非常容易上手。这与 Angular.js 之类的框架相反，后者要求将现有程序完全重构并在该框架中实现。\n\n#### 2. Vue.js 中的声明式渲染是什么？\n\nVue.js 使渲染数据变得容易，并隐藏了内部实现。例如下面的代码：\n\n**HTML**\n```html\n<div id=\'app\'></div>\n```\n**JavaScript**\n```js\nconst greeting = “Hello there!”;\nconst appDiv = document.getElementById(“app”);\nappDiv.innerText = greeting;\n```\n上面的代码段将在 ID 为 “app” 的 div 中显示短语 “Hello there！”。代码包含实现结果所需的所有步骤。首先选择 ID 为 “app” 的 DOM 元素，然后用 innerText 属性手动设置 div 的内容。\n\n现在，让我们看看在 Vue 中是怎么做的。\n\n**Template**\n```html\n<div id=\'app\'>{{ greeting }}</div>\n```\n**App**\n\n```js\nnew Vue({\n    data: {\n       greeting: ‘Hello There!’\n    },\n   el: ‘#app’\n});\n```\n我们在 Vue 程序中创建了一个名为 “greeting” 的数据属性，但是只需要在 div 中用 mustache 语法输入 “greeting” 即可，而不必关心内部实现。我们声明了 “greeting” 变量，其余的由 Vue 完成。这就是声明式渲染的样子。 Vue 隐藏并管理内部信息。\n\n\n', '2021-04-13 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210416\\1618554635762.jpg', 415, 8, 1, '怪蜀黍', '[]', '[\"aaa\"]', NULL);
INSERT INTO `article` VALUES (101, '一个人最好的生活状态', '一个人最好的生活状态，是该看书时看书，该玩时尽情玩，看见优秀的人欣赏，看到落魄的人也不轻视，有自己的小生活和小情趣，不用去想改变世界，努力去活出自己。没人爱时专注自己，有人爱时，有能力拥抱彼此。', '2021-04-13 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210415\\1618490908200.jpg', 66, 13, 1, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (118, '下雨特效', '##### 本站的下雨特效代码，canvas实现。\n\n```js\n  <body>\n    <script src=\"https://www.luckyclover.top/rain.js\"></script>\n    <script>Rain({speed:[2,40],hasBounce:true,wind_direction:340,gravity:0.05,maxNum:80,numLevel:5,drop_chance:0.4,cloud:true});</script>\n  </body>\n```\n\n', '2021-04-13 23:09:04', 18, 1, NULL, 2, 2, 0, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (119, '【造轮子】原生JavaScript实现轮播图', '```html\n<!DOCTYPE html>\n<html lang=\"en\">\n\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Document</title>\n    <style>\n        ul,\n        li {\n            padding: 0;\n            margin: 0;\n        }\n        \n        a {\n            font-style: normal;\n            padding: 0;\n            margin: 0;\n        }\n        \n        li {\n            list-style: none;\n        }\n        /* 四个圈圈 */\n        \n        ol {\n            padding: 0;\n            display: flex;\n            position: absolute;\n            bottom: 0px;\n            left: 50%;\n            transform: translateX(-50%);\n        }\n        /* 两个按钮 */\n        \n        .right,\n        .left {\n            display: none;\n            position: absolute;\n            top: 50%;\n            width: 15px;\n            height: 20px;\n            line-height: 20px;\n            border: none;\n            background-color: rgba(235, 231, 231, 0.5);\n            color: white;\n        }\n        \n        .left {\n            left: 0;\n        }\n        \n        .right {\n            right: 0;\n            text-align: right\n        }\n        \n        .right span {\n            float: right;\n        }\n        \n        ol li {\n            width: 10px;\n            height: 10px;\n            background-color: rgb(179, 192, 204);\n            margin: 0 10px;\n            border-radius: 50%;\n        }\n        /* 大盒子 用于显示单张图片*/\n        \n        .main {\n            position: relative;\n            border: 1px solid black;\n            width: 500px;\n        }\n        /* 轮播图 */\n        \n        .lbtBox {\n            overflow: hidden;\n        }\n        \n        .lbt {\n            position: relative;\n            display: flex;\n            border: 1px solid red;\n        }\n        \n        .lbt li {\n            height: 323px;\n        }\n        \n        .lbt li a {\n            display: inline-block;\n            width: 100%;\n            height: 100%;\n        }\n        \n        .lbt li img {\n            width: 500px;\n            height: 100%;\n        }\n        /* 流行的某一个 */\n        \n        .current {\n            background-color: white;\n        }\n    </style>\n</head>\n\n<body>\n\n    <div class=\"main\">\n        <!-- 图片存放在ul -->\n        <div class=\"lbtBox\">\n            <ul class=\"lbt\">\n                <li>\n                    <a href=\"javascript:;\">\n                        <img src=\"./img/1.jpg\" alt=\"\">\n                    </a>\n                </li>\n                <li>\n                    <a href=\"javascript:;\">\n                        <img src=\"./img/2.jpg\" alt=\"\">\n                    </a>\n                </li>\n                <li>\n                    <a href=\"javascript:;\">\n                        <img src=\"./img/3.jpg\" alt=\"\">\n                    </a>\n                </li>\n                <li>\n                    <a href=\"javascript:;\">\n                        <img src=\"./img/4.jpg\" alt=\"\">\n                    </a>\n                </li>\n                <li>\n                    <a href=\"javascript:;\">\n                        <img src=\"./img/5.jpg\" alt=\"\">\n                    </a>\n                </li>\n\n            </ul>\n            <!-- 两个按钮 -->\n            <div class=\"left\">\n                <</div>\n                    <div class=\"right\">></div>\n\n                    <!-- 四个圆 -->\n                    <ol class=\"circle\">\n                    </ol>\n            </div>\n        </div>\n\n\n        <script>\n            function animate(obj, target, callback) {\n                // console.log(callback);  callback = function() {}  调用的时候 callback()\n                console.log(obj.timer);\n                // 先清除以前的定时器，只保留当前的一个定时器执行\n                clearInterval(obj.timer);\n                obj.timer = setInterval(function() {\n                    // 步长值写到定时器的里面\n                    // 把我们步长值改为整数 不要出现小数的问题\n                    // var step = Math.ceil((target - obj.offsetLeft) / 10);\n                    var step = (target - obj.offsetLeft) / 10;\n                    step = step > 0 ? Math.ceil(step) : Math.floor(step);\n                    if (obj.offsetLeft == target) {\n                        // 停止动画 本质是停止定时器\n                        clearInterval(obj.timer);\n                        // 回调函数写到定时器结束里面\n                        // if (callback) {\n                        //     // 调用函数\n                        //     callback();\n                        // }\n                        callback && callback();\n                    }\n                    // 把每次加1 这个步长值改为一个慢慢变小的值  步长公式：(目标值 - 现在的位置) / 10\n                    obj.style.left = obj.offsetLeft + step + \'px\';\n\n                }, 15);\n            }\n\n\n\n\n            // 功能1：鼠标经过轮播图,左右按钮显示，离开则隐藏\n            // 1.1获取元素\n            var lbtLeft = document.querySelector(\'.left\')\n            var lbtRight = document.querySelector(\'.right\')\n                // 轮播图大盒子\n            var lbtBox = document.querySelector(\'.lbtBox\')\n                // 轮播图\n            var lbt = document.querySelector(\'.lbt\')\n                // 轮播图的宽度\n            var lbtWight = lbt.offsetWidth;\n            // 1.2添加经过鼠标事件\n            lbtBox.addEventListener(\'mouseenter\', () => {\n                    lbtLeft.style.display = \'block\'\n                    lbtRight.style.display = \'block\'\n                })\n                // 1.2添加离开鼠标事件\n            lbtBox.addEventListener(\'mouseleave\', () => {\n                    lbtLeft.style.display = \'none\'\n                    lbtRight.style.display = \'none\'\n                })\n                // 功能2：动态生成小圆 小圆的个数由轮播图的li的个数决定\n            var ol = document.querySelector(\'.circle\');\n            for (var i = 0; i < lbt.children.length; i++) {\n                // 创建li\n                let li = document.createElement(\'li\');\n                // 为创建的li添加自定义属性，就是记录li的索引号\n                li.setAttribute(\'index\', i)\n                    // 把li插入到ol\n                ol.appendChild(li);\n                // 生成小圆的同时直接绑定点击事件\n                li.addEventListener(\'click\', function() {\n                    // 干掉所有人，把所有li清除 current类名\n                    for (var i = 0; i < ol.children.length; i++) {\n                        ol.children[i].className = \'\'\n                    }\n                    // 留下我自己 当前li设置 current类名\n                    this.className = \'current\'\n                        // 点击小圆， 移动的是ul\n                        // ul的移动距离 = 小圆的索引号 * 图片宽度  注意图片往右走 ，移动距离是负值\n                    var index = this.getAttribute(\'index\');\n\n                    console.log(\"距离\", -index * lbtWight);\n                    // 使用动画函数\n                    animate(lbt, -index * lbtWight)\n                    console.log(lbtWight);\n                })\n\n            }\n            // 功能3.点击右侧按钮，图片滚动一张\n            // 克隆第一张图片放到轮播图ul的最后面\n            var first = lbt.children[0].cloneNode(true);\n            lbt.appendChild(first)\n            var num = 0;\n            lbtRight.addEventListener(\'click\', function() {\n                // 当走到最后复制的图片时，将轮播图ul快速复原left改为0\n                if (num == lbt.children.length - 1) {\n                    lbt.style.left = 0;\n                    num = 0;\n                }\n                num++;\n                animate(lbt, -num * lbtWight)\n            })\n\n            // 把ol里面的第一个li设置类名为current\n            ol.children[0].className = \'current\'\n        </script>\n</body>\n\n</html>\n\n\n\n\n\n', '2021-04-14 16:13:49', 18, 0, NULL, 12, 3, 0, '怪蜀黍', '[]', '[\"aaa\"]', NULL);
INSERT INTO `article` VALUES (120, '一万小时定律', '\n一万小时定律是作家格拉德威尔在《异类》一书中指出的定律。“人们眼中的天才之所以卓越非凡，并非天资超人一等，而是付出了持续不断的努力。1万小时的锤炼是任何人从平凡变成世界级大师的必要条件。”他将此称为“一万小时定律”。\n\n要成为某个领域的专家，需要10000小时（1.1415525年），按比例计算就是：如果每天工作八个小时，一周工作五天，那么成为一个领域的专家至少需要五年。这就是一万小时定律。', '2021-04-14 23:19:12', 18, 1, 'http://127.0.0.1:3000\\uploads\\20210419\\1618808090918.jpg', 2083, 3, 0, '怪蜀黍', '[]', '[\"999\"]', NULL);
INSERT INTO `article` VALUES (148, 'vue中\'. native\'修饰符的使用', '\n官网的解释：\n\n\n> 你可能想在某个组件的根元素上监听一个原生事件。可以使用 v-on 的修饰符 .native 。\n\n通俗点讲：就是在父组件中给子组件绑定一个原生的事件，就将子组件变成了普通的HTML标签，不加\'. native\'事件是无法触  发的。\n\n```js\n <el-form-item prop=\"password\">\n  <el-input v-model=\"form.password\" @keyup.enter=\"onSubmit\"></el-input>\n</el-form-item>\n```\n此时按回车无反应，因为vue把@keyup.enter当成了子组件传过来的事件，所以应该写成@keyup.enter.**native**=\"onSubmit\"\n```js\n <el-form-item prop=\"password\">\n    <el-input v-model=\"form.password\" @keyup.enter.native=\"onSubmit\"></el-input>\n</el-form-item>\n```\n native的作用可以理解为该修饰符的作用就是把一个vue组件转化为一个普通的HTML标签，并且该修饰符对普通HTML标签是没有任何作用的。\n\n\n\n\n\n', '2021-04-18 14:03:37', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210418\\1618725955821.jpg', 29, 1, 0, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (149, '前端ES6面试题', '**1、ES5、ES6和ES2015有什么区别?**\n\n> ES2015特指在2015年发布的新一代JS语言标准，ES6泛指下一代JS语言标准，包含ES2015、ES2016、ES2017、ES2018等。现阶段在绝大部分场景下，ES2015默认等同ES6。ES5泛指上一代语言标准。ES2015可以理解为ES5和ES6的时间分界线\n\n**2、babel是什么，有什么作用?**\n> babel是一个 ES6 转码器，可以将 ES6 代码转为 ES5 代码，以便兼容那些还没支持ES6的平台\n\n**3、let有什么用，有了var为什么还要用let？**\n\n> 在ES6之前，声明变量只能用var，var方式声明变量其实是很不合理的，准确的说，是因为ES5里面没有块级作用域是很不合理的。没有块级作用域回来带很多难以理解的问题，比如for循环var变量泄露，变量覆盖等问题。let声明的变量拥有自己的块级作用域，且修复了var声明变量带来的变量提升问题。\n\n**4、举一些ES6对String字符串类型做的常用升级优化?**\n\n**优化部分**\n> ES6新增了字符串模板，在拼接大段字符串时，用反斜杠()`取代以往的字符串相加的形式，能保留所有空格和换行，使得字符串拼接看起来更加直观，更加优雅\n\n**升级部分**\n\n> ES6在String原型上新增了includes()方法，用于取代传统的只能用indexOf查找包含字符的方法(indexOf返回-1表示没查到不如includes方法返回false更明确，语义更清晰), 此外还新增了startsWith(), endsWith(), padStart(),padEnd(),repeat()等方法，可方便的用于查找，补全字符串\n\n\n\n\n\n', '2021-04-18 14:34:14', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210418\\1618738950065.jpg', 25, 2, 0, '怪蜀黍', '[]', '[\"aaa\"]', NULL);
INSERT INTO `article` VALUES (151, 'CSS实现漂亮的大标题文字效果', '## HTML代码用H1吧，这样语义化好些，因为标题一般用h1-h6.\n\n```html\n<h1 class=\"vintage\">美丽的中国语</h1>\n```\n\n### CSS空心文字\n\n![](http://images.shejidaren.com/wp-content/uploads/2013/10/css-heading-02.png)\n\n```css\n.stroke{\ncolor: transparent;\n-webkit-text-stroke: 1px black;\nletter-spacing: 0.04em;\nbackground-color: }\n```\n### CSS内阴影文字效果\n\n![](http://images.shejidaren.com/wp-content/uploads/2013/10/css-heading-03.png)\n\n```css\n.press {\ncolor: transparent;\nbackground-color : black;\ntext-shadow : rgba(255,255,255,0.5) 0 5px 6px, rgba(255,255,255,0.2) 1px 3px 3px;\n-webkit-background-clip : text;\n}\n```\n### CSS 实现3D感文字标题(本站采用)\n\n![](http://images.shejidaren.com/wp-content/uploads/2013/10/css-heading-04.png)\n\n```css\n.threed{\ncolor: #fafafa;\nletter-spacing: 0;\ntext-shadow: \n0px 1px 0px #999, \n0px 2px 0px #888, \n0px 3px 0px #777, \n0px 4px 0px #666, \n0px 5px 0px #555, \n0px 6px 0px #444, \n0px 7px 0px #333, \n0px 8px 7px #001135 \n}\n```\n\n代码来自 [Tutorials ETC](http://codepen.io/AgustiBelloc/pen/bljEB)\n\n', '2021-04-19 12:50:26', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210419\\1618807924418.jpg', 71, 2, 0, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (153, 'JavaScript reverse() 方法', '\n**定义和用法\nreverse() 方法用于颠倒数组中元素的顺序。**\n\n语法\n\n```js\narrayObject.reverse()\n```\n\n提示和注释\n注释：**该方法会改变原来的数组，而不会创建新的数组。**\n\n实例\n在本例中，我们将创建一个数组，然后颠倒其元素的顺序：\n\n```js\nvar arr = new Array(3)\narr[0] = \"George\"\narr[1] = \"John\"\narr[2] = \"Thomas\"\n\ndocument.write(arr + \"<br />\")\ndocument.write(arr.reverse())\n\n```\n\n输出：\n```js\nGeorge,John,Thomas\nThomas,John,George\n```\n\n\n补充相关知识点：\n\nJavaScript实现-字符串翻转-Reverse a String\n\n题目：翻转字符串\n思路：先把字符串转化成数组，再借助数组的reverse方法翻转数组顺序，最后把数组转化成字符串。\n\n```js\nfunction reverseString(str) {\n  var newstr = str.split(\"\").reverse().join(\"\");\n  return newstr;\n}\n', '2021-04-19 13:26:57', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210419\\1618809856941.jpg', 30, 3, 0, '怪蜀黍', '[]', '[\"aaa\"]', NULL);
INSERT INTO `article` VALUES (154, '深入理解 JavaScript 方法集的特性与最佳实践', '# 深入理解 JavaScript 方法集的特性与最佳实践\n\n# 1 Array\n\n## 1.1 array.concat(item…)\n\nconcat 方法会产生一个新数组，它是数组的浅复制，并把一个或多个 item 附加在其后。如果 item 是一个数组，那么它的每一个元素都会被添加：\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\nvar b = [\'x\', \'y\', \'z\'];\nvar c = a.concat(b, true);\nconsole.log(c);//[ \"a\", \"b\", \"c\", \"x\", \"y\", \"z\", true ]\n\n```\n\n```js\n//也可以用concat() 复制原数组并生成一个新数组\nvar a = [\'a\', \'b\', \'c\'];\nvar c = a.concat();\n//此时c是a的副本\nconsole.log(c);//[\"a\",\"b\",\"c\"]\n//c与a是不同的两个对象，他们在内存中分别被分配两块不同的空间进行存储，c仅仅是值与a相同，但是内存地址不同\nconsole.log(c == a )//false\n```\n\n### 1.2 array.join(separator)\n\njoin 方法会把一个 array 构造成一个字符串。它先把 array 中的每一个元素都构造成一个字符串，然后再用 separator 分隔符把它们连接起来。默认的 separator 是逗号 ‘,’。如果想要实现无间隔连接，可以把 separator 设置为空字符串。\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\na.push(\'d\');\nconsole.log(a.join(\'\'));//abcd\n```\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\na.push(\'d\');\nconsole.log(a.join());//a,b,c,d 默认为，号分割\n```\n\n\n\n## 1.3 array.pop()\n\npop 与 push 方法可以使得数组像堆栈一样工作。pop 方法会移除 array 中的最后一个元素并返回这个元素。如果 array 是空数组，那么会返回 undefined：\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\nconsole.log(a.pop());//c\n```\n\n## 1.4 array.push()\n\npush 方法把一个或多个参数 item 附加到一个数组的尾部。它会修改 array。如果 item 是一个数组，它会把这个数组作为单个元素添加到数组中，并返回这个 array 的新长度值：\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\nvar b = [\'x\', \'y\', \'z\'];\nconsole.log(a.push(b, true));//5\nconsole.log(a);//[ \"a\", \"b\", \"c\", Array[3], true ]\n```\n\n## 1.5 array.reverse()\n\n这个方法会反转 array 里元素的顺序，并且会修改数组本身，不会生成一个新的数组\n\n```js\nvar a = [\'a\', \'b\', \'c\'];\nvar b = a.reverse();\nconsole.log(a);//[ \"c\", \"b\", \"a\" ] a数组使用reverse()后会改变a本身的顺序\nconsole.log(b);//[ \"c\", \"b\", \"a\" ]\n```\n', '2021-04-19 14:05:24', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210419\\1618812322565.jpg', 40, 2, 0, '怪蜀黍', '[]', '[\"999\"]', NULL);
INSERT INTO `article` VALUES (155, '修改Markdown编辑器的字体大小', '### 在全局作用域下使用以下代码\n```js\n  // 改变编辑器字体大小\n  .hljs {\n    font-size: 20px;\n}\n```\n### 就这么简单的问题,我还以为不能改,所以说,遇事不要慌,多尝试,多试错,年轻人不要怕', '2021-04-19 14:13:11', 18, 1, NULL, 14, 0, 0, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (166, 'css设计漂亮的搜索框', '## css设计漂亮的搜索框\n\n\n\n\n```js\n* {\n	box-sizing:border-box;\n}\nbody {\n	margin:0;\n	padding:0;\n	background-image:url(ydrzimages/p3.jpg);\n	font-weight:500;\n	font-family:\"Microsoft YaHei\",\"宋体\",\"Segoe UI\",\"Lucida Grande\",Helvetica,Arial,sans-serif,FreeSans,Arimo;\n}\n#container {\n	width:500px;\n	height:820px;\n	margin:0 auto;\n}\ndiv.search {\n	padding:10px 0;\n}\nform {\n	position:relative;\n	width:300px;\n	margin:0 auto;\n}\ninput,button {\n	border:none;\n	outline:none;\n}\ninput {\n	width:100%;\n	height:42px;\n	padding-left:13px;\n}\nbutton {\n	height:42px;\n	width:42px;\n	cursor:pointer;\n	position:absolute;\n}\n/*搜索框6*/\n     \n.bar6 input {\n	border:2px solid #c5464a;\n	border-radius:5px;\n	background:transparent;\n	top:0;\n	right:0;\n}\n.bar6 button {\n	background:#c5464a;\n	border-radius:0 5px 5px 0;\n	width:60px;\n	top:0;\n	right:0;\n}\n.bar6 button:before {\n	content:\"搜索\";\n	font-size:13px;\n	color:#F9F0DA;\n}\n/*搜索框7*/\n      \n.bar7 form {\n	height:42px;\n}\n.bar7 input {\n	width:250px;\n	border-radius:42px;\n	border:2px solid #324B4E;\n	background:#F9F0DA;\n	transition:.3s linear;\n	float:right;\n}\n.bar7 input:focus {\n	width:300px;\n}\n.bar7 button {\n	background:none;\n	top:-2px;\n	right:20px;\n}\n.bar7 button:before {\n	content:\"Search\";\n	font-family:FontAwesome;\n	color:#324b4e;\n}\n/*搜索框8*/\n       \n.bar8 form {\n	height:42px;\n}\n.bar8 input {\n	width:0;\n	padding:0 42px 0 15px;\n	border-bottom:2px solid transparent;\n	background:transparent;\n	transition:.3s linear;\n	position:absolute;\n	top:0;\n	right:0;\n	z-index:2;\n}\n.bar8 input:focus {\n	width:300px;\n	z-index:1;\n	border-bottom:2px solid #F9F0DA;\n}\n.bar8 button {\n	background:#683B4D;\n	top:0;\n	right:0;\n}\n.bar8 button:before {\n	content:\"Go\";\n	font-family:FontAwesome;\n	font-size:16px;\n	color:#F9F0DA;\n}\n```', '2021-04-20 17:39:59', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210420\\1618911593894.jpg', 1911, 0, 0, '怪蜀黍', '[]', '[]', NULL);
INSERT INTO `article` VALUES (167, 'CSS 8种让人眼前一亮的hover效果眼前一亮的HOVER效果', '## CSS 8种让人眼前一亮的hover效果眼前一亮的HOVER效果\n\n\n### 1.发送效果\n![发送效果](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831154902861-499307127.gif)\n\n```html\n\n<h1>发送效果</h1>\n    <div id=\"send_btn\">\n        <button>\n            <svg class=\"icon\" aria-hidden=\"true\">\n                <use xlink:href=\"#icon-bianji\"></use>\n            </svg>\n            send\n        </button>\n    </div>\n\n```\n\n```css\n/* 发送效果 */\n        .icon {\n            width: 1em;\n            height: 1em;\n            vertical-align: -0.15em;\n            fill: currentColor;\n            overflow: hidden;\n        }\n\n        #send_btn button {\n            background: #5f55af;\n            border: 0;\n            border-radius: 5px;\n            padding: 10px 30px 10px 20px;\n            color: white;\n            text-transform: uppercase;\n            font-weight: bold;\n        }\n\n        #send_btn button svg {\n            display: inline-block;\n            vertical-align: middle;\n            padding-right: 5px;\n        }\n\n        #send_btn button:hover svg {\n\n            animation: fly 2s 1;\n        }\n\n        @keyframes fly {\n            0% {\n                transform: translateX(0%);\n            }\n\n            50% {\n                transform: translateX(400%);\n            }\n\n            100% {\n                transform: translateX(0);\n            }\n        }\n\n\n```\n### 2.霓虹效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831154919944-1642655002.gif)\n\n```html\n<h1>霓虹效果</h1>\n\n    <div id=\"neon-btn\">\n        <button class=\"btn one\">Hover me</button>\n        <button class=\"btn two\">Hover me</button>\n        <button class=\"btn three\">Hover me</button>\n    </div>\n```\n\n```css\n/* 霓虹效果 */\n\n        #none-btn {\n            display: flex;\n            align-items: center;\n            justify-content: space-around;\n            height: 100vh;\n            background: #031628;\n        }\n\n        .btn {\n            border: 1px solid;\n            background-color: transparent;\n            text-transform: uppercase;\n            font-size: 14px;\n            padding: 10px 20px;\n            font-weight: 300;\n        }\n\n        .one {\n            color: #4cc9f0;\n        }\n\n        .two {\n            color: #f038ff;\n        }\n\n        .three {\n            color: #b9e769;\n        }\n\n        .btn:hover {\n            color: white;\n            border: 0;\n        }\n\n        .one:hover {\n            background-color: #4cc9f0;\n            -webkit-box-shadow: 10px 10px 99px 6px rgba(76, 201, 240, 1);\n            -moz-box-shadow: 10px 10px 99px 6px rgba(76, 201, 240, 1);\n            box-shadow: 10px 10px 99px 6px rgba(76, 201, 240, 1);\n        }\n\n        .two:hover {\n            background-color: #f038ff;\n            -webkit-box-shadow: 10px 10px 99px 6px rgba(240, 56, 255, 1);\n            -moz-box-shadow: 10px 10px 99px 6px rgba(240, 56, 255, 1);\n            box-shadow: 10px 10px 99px 6px rgba(240, 56, 255, 1);\n        }\n\n        .three:hover {\n            background-color: #b9e769;\n            -webkit-box-shadow: 10px 10px 99px 6px rgba(185, 231, 105, 1);\n            -moz-box-shadow: 10px 10px 99px 6px rgba(185, 231, 105, 1);\n            box-shadow: 10px 10px 99px 6px rgba(185, 231, 105, 1);\n        }\n\n\n```\n\n### 3.边框效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831154934932-102426851.gif)\n\n```html\n<h1>边框效果</h1>\n    <div id=\"draw-border\">\n        <button>Hover me</button>\n    </div>\n```\n\n```css\n/* 边框效果 */\n        #draw-border button {\n            border: 1px solid #ccc;\n            background: none;\n            text-transform: uppercase;\n            color: #4361ee;\n            font-weight: bold;\n            position: relative;\n            outline: none;\n            padding: 10px 20px;\n            box-sizing: border-box;\n        }\n\n\n        #draw-border button::before,\n        button::after {\n            box-sizing: inherit;\n            position: absolute;\n            content: \'\';\n            border: 2px solid transparent;\n            width: 0;\n            height: 0;\n        }\n\n        #draw-border button::after {\n            bottom: 0;\n            right: 0;\n        }\n\n        #draw-border button::before {\n            top: 0;\n            left: 0;\n        }\n\n        #draw-border button:hover::before,\n        button:hover::after {\n            width: 100%;\n            height: 100%;\n        }\n\n        #draw-border button:hover::before {\n            border-top-color: #4361ee;\n            border-right-color: #4361ee;\n            transition: width 0.3s ease-out, height 0.3s ease-out 0.3s;\n        }\n\n        #draw-border button:hover::after {\n            border-bottom-color: #4361ee;\n            border-left-color: #4361ee;\n            transition: border-color 0s ease-out 0.6s, width 0.3s ease-out 0.6s, height 0.3s ease-out 1s;\n        }\n\n```\n\n### 4.圆形效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831154953141-96097506.gif)\n\n```html\n <h1>圆形效果</h1>\n    <div id=\"circle-btn\">\n        <div class=\"btn-container\">\n            <svg class=\"icon\" aria-hidden=\"true\">\n                <use xlink:href=\"#icon-bianji\"></use>\n            </svg>\n            <button>Hover me</button>\n        </div>\n    </div>\n```\n\n```css\n/* 圆形效果 */\n        #circle-btn {\n            overflow: hidden;\n        }\n\n        #circle-btn .btn-container {\n            position: relative;\n        }\n\n        #circle-btn button {\n            border: 0;\n            border-radius: 50px;\n            color: white;\n            background: #5f55af;\n            padding: 10px 20px 7px 60px;\n            text-transform: uppercase;\n            background: linear-gradient(to right, #f72585 50%, #5f55af 50%);\n            background-size: 200% 100%;\n            background-position: right bottom;\n            transition: all 2s ease;\n        }\n\n        #circle-btn svg {\n            background: #f72585;\n            padding: 8px;\n            border-radius: 50%;\n            position: absolute;\n            left: 0;\n            top: 0%;\n        }\n\n        #circle-btn button:hover {\n            background-position: left bottom;\n        }\n\n```\n### 5.圆角效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831155008870-1765660683.gif)\n\n```html\n<h1>圆角效果</h1>\n    <div id=\"border-btn\">\n        <button>Hover me</button>\n    </div>\n```\n\n```css\n/* 圆角效果 */\n\n        #border-btn button {\n            border: 0;\n            border-radius: 10px;\n            background: #2ec4b6;\n            text-transform: uppercase;\n            color: white;\n            font-size: 16px;\n            font-weight: bold;\n            padding: 15px 30px;\n            outline: none;\n            position: relative;\n            transition: border-radius 3s;\n            -webkit-transition: border-radius 3s;\n        }\n\n        #border-btn button:hover {\n            border-bottom-right-radius: 50px;\n            border-top-left-radius: 50px;\n            border-bottom-left-radius: 10px;\n            border-top-right-radius: 10px;\n        }\n```\n\n### 6.冰冻效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831155025177-299409793.gif)\n\n```html\n<h1>冰冻效果</h1>\n    <div id=\"frozen-btn\">\n        <button class=\"green\">Hover me</button>\n        <button class=\"purple\">Hover me</button>\n    </div>\n```\n```css\n/* 冰冻效果 */\n        #frozen-btn button {\n            border: 0;\n            margin: 20px;\n            text-transform: uppercase;\n            font-size: 20px;\n            font-weight: bold;\n            padding: 15px 50px;\n            border-radius: 50px;\n            color: white;\n            outline: none;\n            position: relative;\n        }\n\n        #frozen-btn button:before {\n            content: \'\';\n            display: block;\n            background: linear-gradient(to left, rgba(255, 255, 255, 0) 50%, rgba(255, 255, 255, 0.4) 50%);\n            background-size: 210% 100%;\n            background-position: right bottom;\n            height: 100%;\n            width: 100%;\n            position: absolute;\n            top: 0;\n            bottom: 0;\n            right: 0;\n            left: 0;\n            border-radius: 50px;\n            transition: all 1s;\n            -webkit-transition: all 1s;\n        }\n\n        #frozen-btn .green {\n            background-image: linear-gradient(to right, #25aae1, #40e495);\n            box-shadow: 0 4px 15px 0 rgba(49, 196, 190, 0.75);\n        }\n\n        #frozen-btn .purple {\n            background-image: linear-gradient(to right, #6253e1, #852D91);\n            box-shadow: 0 4px 15px 0 rgba(236, 116, 149, 0.75);\n        }\n\n        #frozen-btn .purple:hover:before {\n            background-position: left bottom;\n        }\n\n        #frozen-btn .green:hover:before {\n            background-position: left bottom;\n        }\n\n```\n\n### 7.闪亮效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831155048122-949881628.gif)\n\n```html\n<h1>闪亮效果</h1>\n \n    <div id=\"shiny-shadow\">\n        <button><span>Hover me</span></button>\n    </div>\n```\n\n```css\n #shiny-shadow{\n            background: #000;\n        }\n \n        #shiny-shadow button {\n            border: 2px solid #ccc;\n            background: transparent;\n            text-transform: uppercase;\n            color: white;\n            padding: 15px 50px;\n            outline: none;\n            overflow: hidden;\n            position: relative;\n        }\n \n        #shiny-shadow span {\n            z-index: 20;\n        }\n \n        #shiny-shadow button:after {\n            content: \'\';\n            display: block;\n            position: absolute;\n            top: -36px;\n            left: -100px;\n            background: white;\n            width: 50px;\n            height: 125px;\n            opacity: 20%;\n            transform: rotate(-45deg);\n        }\n \n        #shiny-shadow button:hover:after {\n            left: 120%;\n            transition: all 600ms cubic-bezier(0.3, 1, 0.2, 1);\n            -webkit-transition: all 600ms cubic-bezier(0.3, 1, 0.2, 1);\n        }\n```\n\n### 8.加载效果\n\n![](https://img2020.cnblogs.com/blog/1380972/202008/1380972-20200831155104215-972340878.gif)\n\n```html\n<h1>加载效果</h1>\n    \n<div id=\"loading-btn\">\n    <button><span>Hover me</span></button>\n  </div>\n```\n\n```css\n/* 加载效果 */\n#loading-btn button {\n  background: transparent;\n  border: 0;\n  border-radius: 0;\n  text-transform: uppercase;\n  font-weight: bold;\n  font-size: 20px;\n  padding: 15px 50px;\n  position: relative;\n}\n\n#loading-btn button:before {\n  transition: all 0.8s cubic-bezier(0.7, -0.5, 0.2, 2);\n  content: \'\';\n  width: 1%;\n  height: 100%;\n  background: #ff5964;\n  position: absolute;\n  top: 0;\n  left: 0;\n}\n\n#loading-btn button span {\n  mix-blend-mode: darken;\n}\n\n#loading-btn button:hover:before {\n  background: #ff5964;\n  width: 100%;\n}\n\n```\n\n\n\n\n\n', '2021-04-20 18:38:16', 18, 0, 'http://127.0.0.1:4000\\uploads\\20220319\\1647621739694.jpg', 70, 3, 0, '怪蜀黍', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (168, '测试1213', '测试1213测试1213', '2022-01-12 23:05:31', 18, 0, '', 96, 2, 0, '怪蜀黍', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (169, 'hrj123hrj123', 'hrj123hrj123', '2022-01-12 23:12:13', 35, 0, '', 287, 2, 0, '怪蜀黍', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (201, '测试123', '', '2022-01-15 09:17:33', 18, 0, '', 358, 3, 0, '怪蜀黍', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (204, '哈哈哈哈', '哈哈哈哈', '2022-01-25 03:21:03', 18, 0, '', 1061, 3, 0, '黄先森', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (205, '123', '222', '2022-02-16 21:19:12', 18, 0, '', 116, 2, 0, '黄先森', '[]', '[\"999\",\"aaa\"]', NULL);
INSERT INTO `article` VALUES (211, '咕咕咕咕咕咕过过过过', '# 咕咕咕咕咕咕过过过过', '2022-03-19 04:06:01', 18, 0, '', 14, 0, 0, '黄先森', '[\"es6\"]', '[]', '');
INSERT INTO `article` VALUES (213, '啊发发', '', '2022-03-19 04:07:07', 18, 0, '', 17, 0, 0, '黄先森', '[]', '[]', '');
INSERT INTO `article` VALUES (219, '', '发发我😂👩‍🦲🙌😜😢😍❤😒😂👌👌☮☮', '2022-03-20 00:54:11', 18, 0, '', 5, 0, 0, '黄先森', '[]', '[]', '');
INSERT INTO `article` VALUES (221, '', '```js\nconsole.log()\n```\n- s', '2022-03-21 09:41:50', 18, 0, '', 11, 0, 0, '黄先森', '[]', '[]', '');
INSERT INTO `article` VALUES (223, 'QQ111', '## QQ111QQ111', '2022-03-25 01:45:29', 18, 0, '', 13, 0, 0, '黄先森', '[]', '[]', 'QQ111');
INSERT INTO `article` VALUES (224, 'aaa', 'aaa', '2022-03-25 22:19:19', 18, 0, '', 3, 0, 0, '黄先森', '[]', '[]', 'aaa');
INSERT INTO `article` VALUES (225, '123', 'sasaff', '2022-03-25 22:20:27', 18, 0, '', 10, 0, 0, '黄先森', '[]', '[]', 'aaaww');
INSERT INTO `article` VALUES (226, '爱爱丸', '# 爱爱丸', '2022-03-25 23:48:18', 18, 0, '', 7, 0, 0, '黄先森', '[\"前端\",\"vue\"]', '[]', '爱爱丸');

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify`  (
  `classify_id` int(0) NOT NULL AUTO_INCREMENT,
  `classname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名',
  `list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '[]' COMMENT '文章列表',
  PRIMARY KEY (`classify_id`) USING BTREE,
  UNIQUE INDEX `classname_UNIQUE`(`classname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 187 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES (143, '前端', '[226]');
INSERT INTO `classify` VALUES (173, 'vue', '[226]');
INSERT INTO `classify` VALUES (174, 'vue-router', '[]');
INSERT INTO `classify` VALUES (175, 'es6', '[95,211]');
INSERT INTO `classify` VALUES (176, '回调地狱', '[95]');
INSERT INTO `classify` VALUES (177, '我我', '[]');
INSERT INTO `classify` VALUES (178, '甜甜咸咸', '[]');
INSERT INTO `classify` VALUES (179, 'cvv', '[]');
INSERT INTO `classify` VALUES (180, 'qwe', '[]');
INSERT INTO `classify` VALUES (181, 'kk', '[]');
INSERT INTO `classify` VALUES (182, '1', '[]');
INSERT INTO `classify` VALUES (183, 'aaaww', '[]');
INSERT INTO `classify` VALUES (184, 'qq', '[]');
INSERT INTO `classify` VALUES (185, 'QQ111', '[]');
INSERT INTO `classify` VALUES (186, '大前端', '[]');
INSERT INTO `classify` VALUES (187, '爱爱丸', '[]');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cmcontent` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int(0) NULL DEFAULT NULL,
  `article_id` int(0) NULL DEFAULT -1 COMMENT '文章id,0为留言，非0为文章评论',
  `create_time` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `head_img` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nickname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_cm_id` int(0) NULL DEFAULT -1,
  `reply_nickname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `reply_user_id` int(0) NULL DEFAULT NULL,
  `like_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '[]',
  `like_count` int(0) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 515 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (24, '为了生活而工作，而不是被工作绑架了生活\n', 18, 101, '2021-04-17 14:25:57', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (46, '写得不错\n', 19, 98, '2021-04-17 18:41:42', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (47, '干就完了\n', 19, 0, '2021-04-17 18:42:30', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (48, '哈哈\n', 18, 0, '2021-04-17 18:42:45', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (49, '好\n', 18, 95, '2021-04-17 19:28:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (51, '我喜欢这个博客网站\n', 19, 0, '2021-04-17 22:49:39', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (52, '加油哦\n', 19, 101, '2021-04-17 22:52:12', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (53, '666\n', 19, 0, '2021-04-17 22:52:40', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (54, 'cursor:pointer;鼠标经过变成小手\n', 19, 99, '2021-04-17 22:58:36', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (55, '棒棒哒\n', 18, 148, '2021-04-18 14:07:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (56, '不错\n', 19, 148, '2021-04-18 14:07:41', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', '酷酷的猫', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (66, '干就完了\n', 18, 100, '2021-04-18 18:47:09', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (73, '加油吧骚年\n', 18, 93, '2021-04-18 19:23:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (74, '整挺好\n', 18, 94, '2021-04-18 19:24:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (75, '很不错的字体样式\n', 18, 151, '2021-04-19 14:58:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (76, '冲冲冲\n', 18, 0, '2021-04-19 14:59:31', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (78, 'a\n', 18, 97, '2021-04-19 19:36:50', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (79, 'as1\n', 18, 97, '2021-04-19 19:37:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (93, '好\n', 18, 96, '2021-04-19 20:10:42', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (95, '非常棒\n', 18, 0, '2021-04-19 20:38:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (97, '不错\n', 18, 153, '2021-04-20 11:48:45', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (98, 'nice\n', 18, 99, '2021-04-20 13:39:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', NULL, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (100, 'nice\n', 18, 0, '2021-04-23 22:10:59', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (101, 'hh\n', 18, 0, '2021-04-25 17:01:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (103, '哈哈', 18, 0, '2021-04-26 17:01:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (104, '哈哈123', 20, 0, '2021-05-26 17:01:39', NULL, '前端工程师阿健', 103, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (105, '哈哈1778823', 20, 0, '2021-05-27 17:01:39', NULL, '前端工程师阿健', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (106, '哈哈1778823', 20, 0, '2021-05-28 17:01:39', NULL, '前端工程师阿健', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (107, '哈哈1778823', 20, 0, '2021-05-29 17:01:39', NULL, '前端工程师阿健', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (108, '哈哈1778823', 19, 0, '2021-05-30 17:01:39', NULL, '酷酷的猫', 101, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (109, 'nh\n', 18, 0, '2022-01-26 11:50:53', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (110, '非常好哈哈哈\n', 18, 0, '2022-01-26 11:51:14', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (111, 'UIUIU\n', 18, 0, '2022-01-26 11:53:18', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (112, 'WQWQWQW\n', 18, 0, '2022-01-26 11:54:12', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (113, 'RTRTR\n', 18, 0, '2022-01-26 11:56:35', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (114, 'QWE\n', 18, 0, '2022-01-26 11:57:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (115, 'ggg\n', 18, 0, '2022-01-26 12:19:42', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (116, 'ui\n', 18, 0, '2022-01-26 12:20:22', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (117, 'uiii\n', 18, 0, '2022-01-26 12:20:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '酷酷的猫', 19, '[]', 0);
INSERT INTO `comment` VALUES (118, 'io\n', 18, 0, '2022-01-26 12:23:52', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (119, 'rt\n', 18, 0, '2022-01-26 12:25:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (121, 'xxxxx\n', 18, 0, '2022-01-26 12:25:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '酷酷的猫', 19, '[]', 0);
INSERT INTO `comment` VALUES (122, 'w\n', 18, 0, '2022-01-26 12:31:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 118, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (123, 'ui\n', 18, 0, '2022-01-26 12:31:53', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (125, 'ty\n', 18, 93, '2022-01-26 12:33:24', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 124, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (126, 'io\n', 18, 0, '2022-01-26 12:36:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (127, 'w\n', 18, 0, '2022-01-26 12:40:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (128, '啊哇青蛙\n', 18, 0, '2022-01-26 12:40:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (129, '自己回复自己\n', 18, 0, '2022-01-26 12:40:31', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (130, '啊我去\n', 18, 93, '2022-01-26 12:40:57', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 124, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (131, '无钱无权\n', 18, 93, '2022-01-26 12:41:10', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 124, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (132, 'AA\n', 18, 93, '2022-01-26 12:41:22', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 124, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (150, 'a\n', 18, 0, '2022-01-26 14:20:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (151, 'wa\n', 18, 0, '2022-01-26 14:20:31', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (152, 'ss\n', 18, 0, '2022-01-26 14:20:36', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (153, '必须的\n', 18, 0, '2022-01-26 14:20:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 50, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (154, '自己回复自己\n', 18, 0, '2022-01-26 14:20:56', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 50, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (155, '不错阿\n', 18, 0, '2022-01-26 14:21:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 47, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (156, 'xx\n', 18, 0, '2022-01-26 14:21:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 47, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (157, '哈哈哈\n', 18, 0, '2022-01-26 14:21:12', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 47, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (158, 'j\n', 18, 0, '2022-01-26 16:25:53', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '前端工程师阿健', 20, '[]', 0);
INSERT INTO `comment` VALUES (159, 'q\n', 18, 0, '2022-01-26 16:25:59', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (160, 'j\n', 18, 0, '2022-01-26 16:31:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (161, 'e\n', 18, 0, '2022-01-26 16:39:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (162, 'j\n', 18, 0, '2022-01-26 17:07:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (163, 's\n', 18, 0, '2022-01-26 17:20:24', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '酷酷的猫', 19, '[]', 0);
INSERT INTO `comment` VALUES (164, 'l\n', 18, 0, '2022-01-26 17:27:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (165, 'qe\n', 18, 0, '2022-01-26 17:27:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '酷酷的猫', 19, '[]', 0);
INSERT INTO `comment` VALUES (166, 'hh\n', 18, 0, '2022-01-26 17:32:57', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '酷酷的猫', 19, '[]', 0);
INSERT INTO `comment` VALUES (167, 'j\n', 18, 0, '2022-01-26 17:34:24', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (168, 'u\n', 18, 0, '2022-01-26 17:34:28', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 167, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (169, 'ui\n', 18, 0, '2022-01-26 17:34:40', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 167, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (170, 'o\n', 18, 0, '2022-01-26 17:35:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 118, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (174, 'h\n', 18, 0, '2022-01-26 18:10:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 172, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (175, 'h\n', 18, 0, '2022-01-26 19:47:26', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 101, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (176, 'ui\n', 18, 0, '2022-01-26 20:22:10', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (177, 'iop\n', 18, 0, '2022-01-26 20:22:16', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 103, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (179, '嘻嘻\n', 40, 0, '2022-01-26 20:30:28', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 172, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (180, '安抚\n', 40, 0, '2022-01-26 20:30:52', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 120, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (181, '自己回自己\n', 40, 0, '2022-01-26 20:32:16', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 120, 'hrjrhj', 40, '[]', 0);
INSERT INTO `comment` VALUES (182, '我也是\n', 40, 0, '2022-01-26 20:32:29', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 51, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (183, '你好\n', 40, 0, '2022-01-26 20:36:23', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 120, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (184, '哈哈\n', 40, 0, '2022-01-26 20:48:21', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 167, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (185, '花花无法花花赴澳符号为佛啊who符号和法务搜索水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水水\n', 40, 0, '2022-01-26 21:08:09', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 101, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (186, 'hh\n', 40, 0, '2022-01-26 21:42:12', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 'hrjrhj', 120, 'hrjrhj', 40, '[]', 0);
INSERT INTO `comment` VALUES (188, '是\n', 18, 0, '2022-01-27 06:05:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 187, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (190, 'qwe\n', 18, 95, '2022-01-27 06:33:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 189, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (191, 'w\n', 18, 95, '2022-01-27 06:33:34', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 189, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (193, 'hh\n', 18, 204, '2022-02-20 21:19:50', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (195, '776.\n', 18, 0, '2022-03-04 02:16:27', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 194, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (196, 'ha\n', 18, 0, '2022-03-04 03:03:10', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 167, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (197, 'ss\n', 18, 0, '2022-03-04 03:03:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 120, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (198, 'w\n', 18, 0, '2022-03-04 03:05:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 194, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (202, 'wr\n', 18, 0, '2022-03-04 03:08:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 201, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (203, 'aw\n', 18, 0, '2022-03-04 03:08:34', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 201, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (204, 'wwer\n', 18, 0, '2022-03-04 03:08:44', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 200, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (207, 'iop\n', 18, 0, '2022-03-10 01:09:55', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 206, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (208, 'op\n', 18, 0, '2022-03-10 01:10:12', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 206, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (209, 'l\n', 18, 93, '2022-03-10 01:13:36', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 124, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (210, 'a\n', 18, 0, '2022-03-10 02:07:52', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 206, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (211, '123\n', 18, 0, '2022-03-10 02:14:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 206, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (215, 'a\n', 18, 207, '2022-03-16 05:21:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (216, 'aw\n', 18, 94, '2022-03-16 05:21:41', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (218, 'a\n', 18, 168, '2022-03-16 05:25:21', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (219, 'aww\n', 18, 169, '2022-03-16 05:25:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (232, 'z\n', 18, 206, '2022-03-16 05:44:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 230, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (233, '安慰\n', 18, 206, '2022-03-16 05:46:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (234, 'a\n', 18, 207, '2022-03-16 05:46:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (235, '‘\n’', 18, 207, '2022-03-16 05:46:41', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (236, 'l\n', 18, 207, '2022-03-16 05:46:44', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (237, 'll\n', 18, 207, '2022-03-16 05:46:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (238, 'l\n', 18, 207, '2022-03-16 05:46:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (239, 'l\n', 18, 207, '2022-03-16 05:46:55', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (240, '‘’\n；', 18, 207, '2022-03-16 05:47:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (250, 'aw\n', 18, 206, '2022-03-16 05:48:20', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (251, 'fasfgaeg\n', 18, 206, '2022-03-16 05:48:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (252, 'khulhul\n', 18, 206, '2022-03-16 05:48:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (253, ';ij;j\n', 18, 206, '2022-03-16 05:48:49', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (254, 'ji;ji;ji\n', 18, 206, '2022-03-16 05:48:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (255, 'fafaw\n', 18, 206, '2022-03-16 05:49:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (256, ';o;\n', 18, 206, '2022-03-16 05:49:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (257, 'o\'j\'jk\'\n', 18, 206, '2022-03-16 05:49:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (258, ';ji;ji\n', 18, 206, '2022-03-16 05:49:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (259, 'fawfawfa\n', 18, 206, '2022-03-16 05:49:09', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (260, 'liulji\n', 18, 206, '2022-03-16 05:49:10', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (261, 'awdawf\'\n', 18, 206, '2022-03-16 05:49:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (262, 'da\n', 18, 206, '2022-03-16 05:52:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (263, 'as\n', 18, 206, '2022-03-16 05:53:21', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (264, 'awfa\n', 18, 206, '2022-03-16 05:53:26', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (265, '哈哈哈\n', 18, 206, '2022-03-16 05:53:38', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (266, 'fa\n', 18, 206, '2022-03-16 05:55:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (267, '以i\n', 18, 206, '2022-03-16 05:56:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (288, '哈哈哈\n', 18, 207, '2022-03-16 06:16:19', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (304, 'aa\n', 18, 207, '2022-03-16 06:58:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (305, 'fafa\n', 18, 207, '2022-03-16 06:58:59', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (310, 'fawf\n', 18, 93, '2022-03-16 07:12:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (315, '.\n', 18, 0, '2022-03-17 16:01:26', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (316, 'as\n', 18, 0, '2022-03-17 16:23:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (318, 'vsdh\n', 43, 96, '2022-03-18 08:26:06', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (319, 'c\n', 43, 153, '2022-03-18 08:26:43', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (320, 'a\n', 43, 0, '2022-03-18 09:22:10', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (321, 's\n', 43, 0, '2022-03-18 09:22:39', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (322, 'a\n', 43, 0, '2022-03-18 09:23:17', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (323, 'afa\n', 43, 0, '2022-03-18 09:23:36', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (324, 'a\n', 43, 0, '2022-03-18 09:27:03', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (325, 'l\n', 43, 0, '2022-03-18 09:27:41', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (326, 'o;\n', 43, 0, '2022-03-18 09:28:09', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (327, '\n', 43, 0, '2022-03-18 09:28:19', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (328, 'a\n', 43, 168, '2022-03-18 09:37:29', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (329, 'a\n', 43, 168, '2022-03-18 09:38:15', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (330, 'as\n', 43, 168, '2022-03-18 09:40:20', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (331, 'af\n', 43, 168, '2022-03-18 09:40:36', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (332, 'wa\n', 43, 168, '2022-03-18 09:40:57', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (333, 'aww\n', 43, 168, '2022-03-18 09:41:02', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (334, 'aaa\n', 43, 0, '2022-03-18 10:46:59', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (335, 's\n', 43, 0, '2022-03-18 10:51:49', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\"]', 1);
INSERT INTO `comment` VALUES (336, 'a\n', 43, 0, '2022-03-18 10:58:56', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\",\"999\"]', 2);
INSERT INTO `comment` VALUES (337, '(ﾉ\"◑ ◑)ﾉ\"(｡•́︿•̀｡)\n', 43, 0, '2022-03-18 11:01:26', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 'aaa', -1, NULL, NULL, '[\"aaa\",\"bbc\",\"999\"]', 3);
INSERT INTO `comment` VALUES (338, 'as\n', 18, 0, '2022-03-18 11:12:19', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\",\"bbc\"]', 2);
INSERT INTO `comment` VALUES (339, 'a\n', 18, 0, '2022-03-18 11:14:42', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\",\"bbc\",\"qqe\"]', 3);
INSERT INTO `comment` VALUES (340, '1\n', 18, 208, '2022-03-18 11:37:34', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (341, 'a\n', 47, 0, '2022-03-19 19:47:40', 'http://127.0.0.1:4000\\uploads\\20220319\\1647690495961.jpg', 'bnm', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (342, 'a\'\n', 47, 0, '2022-03-19 19:48:08', 'http://127.0.0.1:4000\\uploads\\20220319\\1647690495961.jpg', 'bnm', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (343, 'y\n', 47, 0, '2022-03-19 19:48:20', 'http://127.0.0.1:4000\\uploads\\20220319\\1647690495961.jpg', 'bnm', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (344, 'h\n', 47, 0, '2022-03-19 19:48:59', 'http://127.0.0.1:4000\\uploads\\20220319\\1647690495961.jpg', 'bnm', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (345, 's\n', 48, 0, '2022-03-19 20:11:25', 'http://127.0.0.1:4000\\uploads\\20220319\\1647691893630.jpg', 'xxxq', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (346, 's\n', 48, 0, '2022-03-19 20:11:42', 'http://127.0.0.1:4000\\uploads\\20220319\\1647691893630.jpg', 'xxxq', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (347, 'f\n', 49, 0, '2022-03-19 20:17:51', 'http://127.0.0.1:4000\\uploads\\20220319\\1647692265081.jpg', 'pppo', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (348, 'ffaw\n', 49, 0, '2022-03-19 20:17:55', 'http://127.0.0.1:4000\\uploads\\20220319\\1647692265081.jpg', 'pppo', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (349, 'as\n', 18, 0, '2022-03-19 20:33:10', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (350, 'asasaa\n', 18, 0, '2022-03-19 20:33:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (351, '是😊😊\n', 18, 0, '2022-03-20 00:53:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (352, '打发发发我发瓦房\n', 18, 0, '2022-03-20 00:53:20', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (353, '啊🤩🤩🤩🤩👌👌🤦‍♂️🤦‍♀️🤣🤷‍♂️👏👏\n', 18, 0, '2022-03-20 00:53:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (355, '🖤💌💨😂😍😁😅😎😚\n', 18, 0, '2022-03-20 01:27:57', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (356, '😅\n', 18, 0, '2022-03-20 01:28:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (357, '😘\\\n', 18, 0, '2022-03-20 01:28:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (358, '😻👨‍🏫\n', 18, 0, '2022-03-20 01:33:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (359, '💩\n', 18, 0, '2022-03-20 01:33:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (360, '为😴😉😶\n', 18, 0, '2022-03-20 01:53:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (361, '😀🤔😷\n', 18, 0, '2022-03-20 02:05:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (362, 'daf阿发发🧜‍♂️👮🧔🧚‍♂️\n', 18, 0, '2022-03-20 02:06:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (363, '😮😋😂😂\n', 18, 0, '2022-03-20 02:07:11', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (364, 's\n', 18, 0, '2022-03-20 02:11:22', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 362, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (365, '\'\n', 18, 0, '2022-03-20 02:14:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 361, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (366, 'af💇‍♀️ad🤑\n', 18, 0, '2022-03-20 02:14:41', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (367, 'fa\n', 18, 0, '2022-03-20 02:26:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 363, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (368, '😐faw\n', 18, 0, '2022-03-20 02:28:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 363, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (369, 'afw😃😘😐\n', 18, 0, '2022-03-20 02:29:35', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (370, '😔\n', 18, 0, '2022-03-20 02:30:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 366, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (371, '打发😗😗🤔\n', 18, 0, '2022-03-20 02:30:28', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (372, 'af\n', 18, 0, '2022-03-20 02:40:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 366, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (373, '😘\n', 18, 0, '2022-03-20 02:51:54', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 366, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (374, 'a😘\n', 18, 0, '2022-03-20 02:54:14', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 363, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (375, '❣️🙄😐😫😫\n', 18, 0, '2022-03-20 03:28:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 366, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (376, 'f😍\n', 18, 0, '2022-03-20 03:28:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (377, 'awf\n', 18, 0, '2022-03-20 03:29:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (378, '👹\n', 18, 0, '2022-03-20 03:29:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (379, '😸👺\n', 18, 0, '2022-03-20 03:29:34', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (380, '💚💚\n', 18, 0, '2022-03-20 03:32:07', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (381, '🤐\n', 18, 0, '2022-03-20 03:33:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (382, 'w\n', 18, 0, '2022-03-20 03:36:09', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 376, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (383, 'af\n', 18, 0, '2022-03-20 03:36:11', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (384, 'a\n', 18, 0, '2022-03-20 03:36:24', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 366, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (385, 'w\n\n', 18, 0, '2022-03-20 03:36:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 371, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (386, 'rwet\n', 18, 0, '2022-03-20 03:36:42', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 369, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (387, 'af\n', 18, 0, '2022-03-20 03:37:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (388, 'awf\n', 18, 0, '2022-03-20 03:39:27', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 369, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (389, 'fawf\n', 18, 0, '2022-03-20 03:39:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 369, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (390, '😙😙\n', 18, 0, '2022-03-20 03:39:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, '黄先森', NULL, '[]', 0);
INSERT INTO `comment` VALUES (391, '😍😑😑😑\n', 18, 0, '2022-03-20 03:40:50', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (392, 'af\n', 18, 0, '2022-03-20 03:41:20', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 391, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (393, 'fawf\n', 18, 0, '2022-03-20 03:41:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 390, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (394, 'yjj\n', 18, 0, '2022-03-20 03:43:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 387, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (395, 's\n', 18, 0, '2022-03-20 03:48:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 383, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (396, 's\n', 18, 0, '2022-03-20 03:49:50', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 344, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (397, '😡啊啊啊\n', 18, 0, '2022-03-20 05:27:50', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 387, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (398, '😍\n', 18, 0, '2022-03-20 05:28:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 387, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (399, '😑😕哈哈哈\n', 18, 0, '2022-03-20 05:28:12', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (400, '🤨😍😚哈哈\n', 18, 0, '2022-03-20 05:28:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (401, '嘻嘻🤐🤐\n', 18, 0, '2022-03-20 05:28:58', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (402, '；‘’\n', 18, 0, '2022-03-20 05:29:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (403, '\n', 18, 0, '2022-03-20 05:29:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (404, '\n', 18, 0, '2022-03-20 05:29:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, '黄先森', NULL, '[]', 0);
INSERT INTO `comment` VALUES (405, '🧕\n', 18, 0, '2022-03-20 05:29:21', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (406, '阿瓦我\n', 18, 0, '2022-03-20 05:29:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (407, '非\n', 18, 0, '2022-03-20 05:29:38', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 346, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (408, '按我发\n', 18, 0, '2022-03-20 05:29:49', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 352, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (409, '👩‍💼\n', 18, 0, '2022-03-20 05:38:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 343, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (410, '😀😂😐\n', 18, 0, '2022-03-20 06:13:33', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 404, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (411, '😅\n', 18, 0, '2022-03-20 06:14:19', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 399, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (412, '😶\n', 18, 0, '2022-03-20 06:15:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 400, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (413, 's\n', 18, 0, '2022-03-20 06:17:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 400, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (414, 'a\n', 18, 0, '2022-03-20 06:20:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 400, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (415, ';\n', 18, 0, '2022-03-20 06:20:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (416, ';\n', 18, 0, '2022-03-20 06:20:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (417, 'l\n', 18, 0, '2022-03-20 06:20:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 416, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (418, 'kljjljl\n', 18, 0, '2022-03-20 06:20:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 415, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (419, 'gawgawg\n', 18, 0, '2022-03-20 06:21:05', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 415, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (420, '\n', 18, 0, '2022-03-20 06:29:14', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (421, '以i\n', 18, 0, '2022-03-20 06:29:22', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (422, '魄魄\n', 18, 0, '2022-03-20 06:29:37', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (423, '我哦熊\n', 18, 0, '2022-03-20 06:29:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 420, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (424, '看看看\n', 18, 0, '2022-03-20 06:31:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 422, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (425, '；‘；‘’；’\n', 18, 0, '2022-03-20 06:31:54', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (426, '【】【；【】】；\n', 18, 0, '2022-03-20 06:32:00', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 421, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (427, '魄魄篇\n', 18, 0, '2022-03-20 06:32:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 421, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (428, '咳咳咳\n', 18, 0, '2022-03-20 06:34:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 422, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (429, '阀🤣\n', 18, 0, '2022-03-20 06:37:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 421, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (430, '婆【婆【\n', 18, 0, '2022-03-20 06:52:38', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 425, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (431, '婆婆\n', 18, 0, '2022-03-20 06:55:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (432, '【】魄魄\n', 18, 0, '2022-03-20 06:55:18', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (433, 'awf\n', 18, 0, '2022-03-20 06:56:59', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 432, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (434, 'awfawf\n', 18, 0, '2022-03-20 06:57:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (435, 'fawf\n', 18, 0, '2022-03-20 06:57:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (436, '少时诵诗书所所所\n', 18, 0, '2022-03-20 06:57:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (437, '发完疯\n', 18, 0, '2022-03-20 06:57:21', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (438, '安慰法付付付\n', 18, 0, '2022-03-20 06:57:26', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 437, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (441, '几集发完疯\n', 18, 0, '2022-03-20 06:57:56', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 440, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (443, '\\(^o^)/\n', 18, 0, '2022-03-20 06:58:30', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 437, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (444, '发未发为父\n', 18, 0, '2022-03-20 06:58:37', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 440, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (445, '俺单位ff\n', 18, 0, '2022-03-20 06:58:43', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 442, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (446, '暗访\n', 18, 0, '2022-03-20 06:59:01', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 442, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (447, '品牌\n', 18, 0, '2022-03-20 06:59:04', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 442, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (448, '安抚\n', 18, 0, '2022-03-20 07:01:55', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 442, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (449, '法法\n', 18, 0, '2022-03-20 07:07:19', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (451, '；；‘\n’', 18, 0, '2022-03-20 07:07:29', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 450, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (452, '；\n', 18, 0, '2022-03-20 07:07:33', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 439, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (454, '安慰法王噶我国\n', 18, 0, '2022-03-20 07:07:42', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 440, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (455, '阿发无法访问\n', 18, 0, '2022-03-20 07:07:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (458, '发未发\n', 18, 0, '2022-03-20 07:08:22', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 425, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (460, '发完疯\n', 18, 0, '2022-03-20 07:08:39', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 399, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (462, '嗄\n', 18, 0, '2022-03-20 07:35:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (463, '吖\n', 18, 0, '2022-03-20 07:35:38', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (464, '嗄\n', 18, 0, '2022-03-20 07:35:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (465, '瓦\n', 18, 0, '2022-03-20 07:35:54', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (466, '阿帆\n', 18, 0, '2022-03-20 07:36:07', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (467, '啊娃娃人\n', 18, 0, '2022-03-20 07:38:07', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (468, '老\n', 18, 0, '2022-03-20 07:38:13', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (469, '；\n', 18, 0, '2022-03-20 07:38:16', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (470, '；\n', 18, 0, '2022-03-20 07:38:18', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (471, '；\n', 18, 0, '2022-03-20 07:38:19', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (472, '锕🤣😍🤔\n', 18, 0, '2022-03-20 07:38:33', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (473, '阿\n', 18, 0, '2022-03-20 07:42:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 47, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (474, '阿飞\n', 18, 0, '2022-03-20 08:00:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (475, '发我f\n', 18, 0, '2022-03-20 08:00:38', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (476, '阿凡达阀\n', 18, 0, '2022-03-20 08:00:47', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (477, '嗄\n', 18, 0, '2022-03-20 08:00:52', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (478, '卅‘\n’', 18, 0, '2022-03-20 08:03:51', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (479, '锕\n', 18, 0, '2022-03-20 08:03:56', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (480, '安抚\n', 18, 0, '2022-03-20 08:05:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 440, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (481, '阿法无法\n', 18, 0, '2022-03-20 08:05:11', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 440, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (482, '打我发放\n', 18, 0, '2022-03-20 08:05:24', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 439, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (483, '林\n', 18, 0, '2022-03-20 08:05:32', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 439, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (484, '‘\n’', 18, 0, '2022-03-20 08:05:35', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 439, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (485, '爱我\n', 18, 0, '2022-03-20 08:05:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 439, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (486, '按发放\n', 18, 0, '2022-03-20 08:16:23', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (487, '阿\n', 18, 0, '2022-03-20 08:17:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (488, '；老\n', 18, 0, '2022-03-20 08:21:03', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (489, '吖\n', 18, 0, '2022-03-20 08:26:48', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (490, '👱👱\n', 18, 0, '2022-03-20 08:28:21', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (491, '🤤🤤🤤\n', 18, 0, '2022-03-20 08:37:09', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 471, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (492, '爱我反复\n', 18, 0, '2022-03-20 08:37:27', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (493, '😀😀😀毕设\n', 18, 0, '2022-03-20 08:37:57', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (494, '安慰法\n', 18, 0, '2022-03-20 08:38:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (495, '发未发\n', 18, 168, '2022-03-20 08:39:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (496, '发我f\n', 18, 168, '2022-03-20 08:39:31', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 332, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (497, '安文费\n', 18, 168, '2022-03-20 08:39:37', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 332, '黄先森', 18, '[]', 0);
INSERT INTO `comment` VALUES (498, '\n', 18, 168, '2022-03-20 08:39:40', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 332, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (499, '奥法\n', 18, 168, '2022-03-20 08:39:46', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 332, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (500, '我\n', 18, 168, '2022-03-20 08:41:07', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (501, '你好\n', 18, 168, '2022-03-20 08:41:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 495, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (502, '😪😪🤣🤣\n', 18, 168, '2022-03-20 08:41:27', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (503, '按我🤽🤽🤽\n', 18, 0, '2022-03-20 08:43:18', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (504, '🤣🤣\n', 18, 0, '2022-03-20 10:48:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 503, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (505, '😉😉💛💛\n', 18, 0, '2022-03-20 10:48:17', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 503, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (506, '👩‍🚒👩‍🚒\n', 18, 0, '2022-03-20 10:49:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 400, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (507, 'd\n', 18, 0, '2022-03-20 10:49:44', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 503, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (508, '😚\n', 18, 0, '2022-03-20 10:50:06', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 493, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (509, 'a\n', 18, 98, '2022-03-21 10:16:25', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[\"999\"]', 1);
INSERT INTO `comment` VALUES (510, '\n', 18, 98, '2022-03-21 10:16:29', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (511, 'aa\n', 18, 98, '2022-03-21 10:17:07', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (512, '啪啪啪\n', 18, 98, '2022-03-21 10:28:15', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (513, '阿发无法访问\n', 18, 98, '2022-03-21 10:30:08', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 510, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (514, '😙😙😙😙as\n', 18, 98, '2022-03-21 10:33:40', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', -1, NULL, NULL, '[]', 0);
INSERT INTO `comment` VALUES (515, '😄😄😅\n', 18, 0, '2022-03-26 03:05:02', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', '黄先森', 503, NULL, NULL, '[]', 0);

-- ----------------------------
-- Table structure for photowall
-- ----------------------------
DROP TABLE IF EXISTS `photowall`;
CREATE TABLE `photowall`  (
  `uid` bigint(0) UNSIGNED NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `percentage` int(0) NULL DEFAULT NULL,
  `size` int(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '这是标题...',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of photowall
-- ----------------------------
INSERT INTO `photowall` VALUES (1642949383513, 'http://127.0.0.1:3000/uploads/20220123/1642949383869.jpg', '109951165000584159.jpg', 100, 231633, 'success', 'h');
INSERT INTO `photowall` VALUES (1642952000027, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952000375.jpg', '2.jpg', 100, 3797405, 'success', '虎年吉祥，虎虎生威');
INSERT INTO `photowall` VALUES (1642952330660, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952330713.jpg', 'cbc36448.jpg', 100, 152090, 'success', '等一个陪我看彩虹的人');
INSERT INTO `photowall` VALUES (1642952348372, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952348419.jpg', '123.jpg', 100, 1101196, 'success', 'ha');
INSERT INTO `photowall` VALUES (1642952593049, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952593066.jpg', 'afafassx.jpg', 100, 61356, 'success', '一只可爱的喵');
INSERT INTO `photowall` VALUES (1642952601601, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952601621.jpg', 'afa.jpg', 100, 62812, 'success', '龙珠，我的神');
INSERT INTO `photowall` VALUES (1642952606434, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952606450.jpg', '23.jpg', 100, 116517, 'success', '静谧的小城，环绕着独特的美感');
INSERT INTO `photowall` VALUES (1642952632330, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952632345.jpg', 'afaw.jpg', 100, 40448, 'success', 'haa');
INSERT INTO `photowall` VALUES (1642952637670, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952637689.jpg', '123.jpg', 100, 1101196, 'success', 'h');
INSERT INTO `photowall` VALUES (1642952645288, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952645301.jpg', 'afaw.jpg', 100, 40448, 'success', '贱兮兮的小黄人');
INSERT INTO `photowall` VALUES (1642952843844, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952843859.jpg', 'marvin-cors-Dr6s2iRcdyI-unsplash.jpg', 100, 147672, 'success', '力量举');
INSERT INTO `photowall` VALUES (1642952847154, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952847158.jpg', 'markus-spiske-oPDQGXW7i40-unsplash.jpg', 100, 80336, 'success', 'h');
INSERT INTO `photowall` VALUES (1642952962990, 'http://127.0.0.1:3000\\uploads\\20220123\\1642952963004.jpg', 'christian-mendoza-j14sr5KkTJ0-unsplash.jpg', 100, 217845, 'success', 'NBA现场');
INSERT INTO `photowall` VALUES (1642975527761, 'http://127.0.0.1:3000\\uploads\\20220124\\1642975527820.jpg', '111.jpg', 100, 18098, 'success', 'Java真的是世界上最好的语言吗');
INSERT INTO `photowall` VALUES (1642979806045, 'http://127.0.0.1:3000\\uploads\\20220124\\1642979806086.jpg', 'hrj.jpg', 100, 296127, 'success', '好久没健身');
INSERT INTO `photowall` VALUES (1642980463468, 'http://127.0.0.1:3000\\uploads\\20220124\\1642980463497.jpg', 'u=798826585,2283441214&fm=26&fmt=auto.jpg', 100, 7672, 'success', '这是标题...');
INSERT INTO `photowall` VALUES (1643243684055, 'http://127.0.0.1:3000\\uploads\\20220127\\1643243684412.jpg', '111.jpg', 100, 18098, 'success', '这是标题...');
INSERT INTO `photowall` VALUES (1643249009217, 'http://127.0.0.1:3000\\uploads\\20220127\\1643249009592.jpg', '111.jpg', 100, 18098, 'success', '这是标题...');
INSERT INTO `photowall` VALUES (1643250906764, 'http://127.0.0.1:3000\\uploads\\20220127\\1643250907097.jpg', '123.jpg', 100, 1101196, 'success', '这是标题...');
INSERT INTO `photowall` VALUES (1647263092181, 'http://127.0.0.1:4000\\uploads\\20220314\\1647263092558.jpg', '111.jpg', 100, 18098, 'success', 'java');

-- ----------------------------
-- Table structure for speech
-- ----------------------------
DROP TABLE IF EXISTS `speech`;
CREATE TABLE `speech`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文章内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `user_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '作者id',
  `state` int(0) NOT NULL DEFAULT 0 COMMENT '删除状态 0为未删除，1为已删除',
  `pic_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文章封面',
  `visited` int(0) NULL DEFAULT 1 COMMENT '文章访问量',
  `like_count` int(0) NULL DEFAULT 0 COMMENT '点赞数量',
  `islike` tinyint(0) NULL DEFAULT 0 COMMENT '当前用户是否点赞了，默认为0,已点赞则为1',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 265 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of speech
-- ----------------------------
INSERT INTO `speech` VALUES (102, '又写了一天的代码', '又写了一天的代码hhh', '2021-04-13 00:00:00', 18, 0, 'http://127.0.0.1:3000\\uploads\\20210416\\1618576192492.jpg', 3, 3, 1, '怪蜀黍');
INSERT INTO `speech` VALUES (256, 'hhhh', 'hhhhhhhhhhhh', '2022-01-16 00:05:28', 18, 0, '', 1, 0, 0, '怪蜀黍');
INSERT INTO `speech` VALUES (257, '离职一个月了', '# 离职一个月了...', '2022-01-22 01:27:54', 18, 0, '', 1, 0, 0, '怪蜀黍');
INSERT INTO `speech` VALUES (258, '', '![2q.png](http://127.0.0.1:3000/uploads/20220129/1643422589097.png)\n', '2022-01-29 10:17:14', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (259, '', '![afaw.jpg](http://127.0.0.1:3000/uploads/20220129/1643422776217.jpg)', '2022-01-29 10:19:39', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (260, '', '![markusspiskeoPDQGXW7i40unsplash.jpg](http://127.0.0.1:3000/uploads/20220130/1643506902221.jpg)\n\n\n![cbc36448.jpg](http://127.0.0.1:3000/uploads/20220130/1643506932531.jpg)', '2022-01-30 09:42:30', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (261, '', '```js\nhljs_lang: function (lang) {\n          return (\n            \'https://cdn.bootcdn.net/ajax/libs/highlight.js/11.3.1/languages/\' +\n            lang +\n            \'.min.js\'\n          );\n        },', '2022-03-04 03:18:02', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (262, '', '# \n- s', '2022-03-21 10:04:50', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (263, 'ffff', 'asfafa', '2022-03-25 01:49:07', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (264, 'da', 'wfaf', '2022-03-26 00:06:20', 18, 0, '', 1, 0, 0, '黄先森');
INSERT INTO `speech` VALUES (265, '', '# 一级标题\n````js\n\nfunction shouldLog(level) {\n	var shouldLog =\n		(logLevel === \"info\" && level === \"info\") ||\n		([\"info\", \"warning\"].indexOf(logLevel) >= 0 && level === \"warning\") ||\n		([\"info\", \"warning\", \"error\"].indexOf(logLevel) >= 0 && level === \"error\");\n	return shouldLog;\n}\n\nfunction logGroup(logFn) {\n	return function(level, msg) {\n		if (shouldLog(level)) {\n			logFn(msg);\n		}\n	};\n}\n\n```\n\n# 一级标题\n````js\n\nfunction shouldLog(level) {\n	var shouldLog =\n		(logLevel === \"info\" && level === \"info\") ||\n		([\"info\", \"warning\"].indexOf(logLevel) >= 0 && level === \"warning\") ||\n		([\"info\", \"warning\", \"error\"].indexOf(logLevel) >= 0 && level === \"error\");\n	return shouldLog;\n}\n\nfunction logGroup(logFn) {\n	return function(level, msg) {\n		if (shouldLog(level)) {\n			logFn(msg);\n		}\n	};\n}\n\n```', '2022-03-26 00:07:22', 18, 0, '', 1, 0, 0, '黄先森');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `head_img` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'http://112.124.52.188:4000/uploads/20220318/1647604499438.jpg',
  `grade` int(0) NULL DEFAULT 3,
  `is_apply` int(0) NULL DEFAULT 0 COMMENT '是否申请成为管理员，0为否，1为是',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username`) USING BTREE,
  UNIQUE INDEX `nickname_UNIQUE`(`nickname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (18, '999', '839b4756957cb5d3baf059de357345a5', '黄先森', 'http://127.0.0.1:4000\\uploads\\20220320\\1647716046666.jpg', 1, 1);
INSERT INTO `user` VALUES (19, '996996', 'e00907428df6d016772dfcdf0d881172', '酷酷的猫', 'http://127.0.0.1:3000\\uploads\\20210417\\1618656111250.jpg', NULL, 0);
INSERT INTO `user` VALUES (20, '9236', '885885', '前端工程师阿健', 'http://127.0.0.1:3000\\uploads\\20210417\\1618648235436.jpg', 3, 0);
INSERT INTO `user` VALUES (21, '123123', '54e5a8ebb77ed591a3b648418627f194', '123', '', NULL, 0);
INSERT INTO `user` VALUES (22, '741', '6640bf78cba8838826e8b37ecaaa3cf2', '741', 'http://127.0.0.1:3000\\uploads\\20210418\\1618733241548.jpg', NULL, 0);
INSERT INTO `user` VALUES (23, '92369236', '006d91c27c2420e369726b68b2c5cc9c', '9236', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', NULL, 0);
INSERT INTO `user` VALUES (24, '123999', '54e5a8ebb77ed591a3b648418627f194', 'max', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 0);
INSERT INTO `user` VALUES (25, '9877', '029a68e8c51de61e032b6b4b7f7a8402', 'qqx', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', NULL, 0);
INSERT INTO `user` VALUES (26, '987556', '0f0994ed40b5605c28b148cd8a2cc27b', '8888', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', NULL, 0);
INSERT INTO `user` VALUES (30, '帅哥gg', 'b818c422b9101d81dacc62c5f1fef88d', '9955', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 0);
INSERT INTO `user` VALUES (34, '923691372', '858717444987687f120a4593604bb6fa', 'hhhhhh', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 0);
INSERT INTO `user` VALUES (35, 'hrj123', '839b4756957cb5d3baf059de357345a5', 'hrj123', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 1);
INSERT INTO `user` VALUES (36, 'iop', '84c8bcd7a10ba3c296431cfe679eadb5', 'iop', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 0);
INSERT INTO `user` VALUES (37, 'qqq', '41332567500bbf6e460051a025dba447', 'qqq', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 0);
INSERT INTO `user` VALUES (38, '998998', 'dfc1f1a93c16f8d1eedab0b611497dfa', '前端小菜鸡', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 1);
INSERT INTO `user` VALUES (39, 'user', '3217b972a870bb3413f5b1a09597d38c', 'user', 'http://127.0.0.1:3000\\uploads\\20220124\\1643039739966.jpg', 3, 0);
INSERT INTO `user` VALUES (40, 'hrjhrj', 'e6a37aa9786c8d9d8fb22b9dbd38264c', 'hrjrhj', 'http://127.0.0.1:3000\\uploads\\20220126\\1643200209943.jpg', 2, 0);
INSERT INTO `user` VALUES (41, '天天酷跑', '839b4756957cb5d3baf059de357345a5', '123天天酷跑360', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 1);
INSERT INTO `user` VALUES (42, 'xxx', 'eb2196af31a092d20f9cd08c57994389', 'xxx', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 0);
INSERT INTO `user` VALUES (43, 'aaa', '16eacc17e763f000aa7e148c496ef0ea', 'aaa', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 0);
INSERT INTO `user` VALUES (44, 'bbc', '54e5a8ebb77ed591a3b648418627f194', 'bbc', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 0);
INSERT INTO `user` VALUES (45, 'qqe', '54e5a8ebb77ed591a3b648418627f194', 'QQE', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 2, 0);
INSERT INTO `user` VALUES (46, 'mmn', '43edc180857f452e422a452a8dc31cc2', 'mmn', 'http://b-ssl.duitang.com/uploads/item/201607/27/20160727112945_S2kR5.thumb.700_0.png', 3, 0);
INSERT INTO `user` VALUES (47, 'bnm', '155b64fad196d709e415dcff02bb8e95', 'bnm', 'http://127.0.0.1:4000\\uploads\\20220319\\1647690495961.jpg', 3, 0);
INSERT INTO `user` VALUES (48, 'xxxq', '5eb7a0e0df520cf853e84fd092e1f8f8', 'xxxq', 'http://127.0.0.1:4000\\uploads\\20220319\\1647691893630.jpg', 3, 0);
INSERT INTO `user` VALUES (49, 'pppo', '1ffe02add25f7a621f65462feaa7f522', 'pppo', 'http://127.0.0.1:4000\\uploads\\20220319\\1647692265081.jpg', 3, 0);
INSERT INTO `user` VALUES (50, 'ccv', '63cc34edfc59f0c06876fc17f754d6ce', 'ccv', NULL, 3, 0);
INSERT INTO `user` VALUES (51, 'cvv', '73231e26906c24212c65e04307b210d7', 'cvv', 'http://112.124.52.188:4000/uploads/20220318/1647604499438.jpg', 2, 1);
INSERT INTO `user` VALUES (52, 'qwe123', 'fda3797cbbcbf2754405d5bd3360e8c2', 'qwe1', 'http://112.124.52.188:4000/uploads/20220318/1647604499438.jpg', 2, 1);

SET FOREIGN_KEY_CHECKS = 1;
