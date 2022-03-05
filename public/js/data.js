/*
 * @Author: N0ts
 * @Date: 2021-06-12 20:02:41
 * @LastEditTime: 2022-03-05 19:37:08
 * @Description: 我的第三个个人主页
 * @FilePath: /NutssssIndex3/js/data.js
 * @Mail：mail@n0ts.cn
 */

export default {
  themeSelect: "white",
  // 主题
  themes: {
    white: [
      // 背景颜色
      ["--bgColor", "rgb(255, 165, 92)"],
      // 第一屏背景颜色
      ["--firstBgColor", "linear-gradient(to top, rgb(255, 165, 92), rgb(255, 159, 49))"],
      // 山颜色
      ["--hillColor1", "rgb(115, 49, 54)"],
      ["--hillColor2", "rgb(131, 55, 59)"],
      ["--hillColor3", "rgb(162, 72, 80)"],
      ["--hillColor4", "rgb(221, 102, 107)"],
      // 大地颜色
      ["--earth", "linear-gradient(to top right, rgb(202, 112, 117), rgb(126, 50, 53))"],
      // 小草颜色
      ["--cao", "linear-gradient(to top, rgb(202, 112, 117), rgb(126, 50, 53))"],
      // 标题文字颜色
      ["--titleColor", "rgb(255, 69, 32)"],
      // 标题文字阴影
      ["--titleShadow", "2px 2px 0px rgba(255, 255, 255, .8), 0 0 10px rgba(0, 0, 0, .5)"],
      // 图标菜单阴影
      ["--iconShadow", "0 0 5px white"],
    ],
    dark: [
      // 背景颜色
      ["--bgColor", "rgb(48, 37, 95)"],
      // 第一屏背景颜色
      ["--firstBgColor", "linear-gradient(to top, rgb(78, 36, 88), rgb(13, 18, 51))"],
      // 山颜色
      ["--hillColor1", "rgb(36, 32, 74)"],
      ["--hillColor2", "rgb(41, 35, 94)"],
      ["--hillColor3", "rgb(65, 37, 71)"],
      ["--hillColor4", "rgb(87, 50, 95)"],
      // 大地颜色
      ["--earth", "linear-gradient(to top right, rgb(43, 38, 95), rgb(61, 36, 95))"],
      // 小草颜色
      ["--cao", "linear-gradient(to top, rgb(85, 49, 96), rgb(78, 72, 128))"],
      // 标题文字颜色
      ["--titleColor", "rgb(136, 65, 167)"],
      // 标题文字阴影
      ["--titleShadow", "2px 2px 0px rgba(255, 255, 255, .8), 0 0 10px rgba(0, 0, 0, .5)"],
      // 图标菜单阴影
      ["--iconShadow", "0 0 2px white"],
    ]
  },
  lovexhj1: {
    title: "我是阿健",
    subTitle: "爱好编程，运动，吉他与红烧肉",
    menu: [{
      name: "Blog",
      icon: "fa-wordpress",
      link: "http://www.hrjblog.top/"
    },
    {
      name: "Gitee",
      icon: "fa-github",
      link: "https://gitee.com/huang-rijian"
    },
      // {
      //   name: "QQ",
      //   icon: "fa-qq",
      //   link: "https://wpa.qq.com/msgrd?v=3&uin=1656071287&site=qq&menu=yes"
      // },
      // {
      //   name: "坚果小栈 - 技术交流",
      //   icon: "fa-code",
      //   link: "https://jq.qq.com/?_wv=1027&k=qMNJqj3F"
      // }
    ]
  },
  lovexhj2: {
    content: `                    <h1>你好！</h1>
        <h2>node博客后端服务已启动为http://127.0.0.1:4000，下面是部分不需要登录验证的接口：</h2>
        <p>
          <a href="http://127.0.0.1:4000/api/article/classify">
            文章分类：http://127.0.0.1:4000/api/article/classify
          </a>
        </p>
        <p>
          <a href="http://127.0.0.1:4000/api/article/detail?article_id=149">
            某文章详情：http://127.0.0.1:4000/api/article/detail?article_id=149
          </a>
        </p>
        <p>
          <a href="http://127.0.0.1:4000/api/comment/list?article_id=0&list=5&offset=0">
          网站第一页留言：http://127.0.0.1:4000/api/comment/list?article_id=0&list=5&offset=0
          </a>
        </p>
        <p>
          <a href="http://127.0.0.1:4000/api/article/timeShaft">
            文章时间轴：http://127.0.0.1:4000/api/article/timeShaft
          </a>
        </p>
        <p>
          <a href="http://127.0.0.1:4000/api/photoWall/getPhoto">
            图片墙：http://127.0.0.1:4000/api/photoWall/getPhoto
          </a>
        </p>
        <p>
          <a href="http://127.0.0.1:4000/api/speech/getSpeech">
            站主发言：http://127.0.0.1:4000/api/speech/getSpeech
          </a>
        </p>
        <p>如访问成功，则说明数据库已经成功连接后端服务</p>
        <p>剩下的接口请到源码里查找</p>`
    // img: "https://lovexhj.oss-cn-beijing.aliyuncs.com/me/images/me.jpg"
  }
}