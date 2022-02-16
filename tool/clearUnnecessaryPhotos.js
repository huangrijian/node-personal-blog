// 引入连接数据库的方法
const querySql = require('../db/index')
let fs = require("fs");
let path = require('path');

// 遍历每个数组列表的url, 截取url,从 'u'开始截取到最后 比如: uploads\20220127\1643243684412.jpg
function forEachData(arry, url) {
  let arr = []
  arry.forEach((item) => {
    if (item[url] && item[url] !== '') {
      let a = item[url].indexOf("u")
      let c = item[url].substring(a);
      arr.push(c)
    }
  })
  return arr
}

// 获取数据库里引用的图片地址,返回图片地址列表
async function getImgUrl() {
  let a = await querySql('select pic_url from article');
  let b = await querySql('select head_img from comment');
  let c = await querySql('select url from photoWall');
  let d = await querySql('select head_img from user');

  let res = [...new Set([
    ...forEachData(a, 'pic_url'),
    ...forEachData(b, 'head_img'),
    ...forEachData(c, 'url'),
    ...forEachData(d, 'head_img'),])]
  return res
}

// 读取文件里面的所有文件(不含文件夹)
function readFileList(dir, filesList = []) {
  const files = fs.readdirSync(dir);
  files.forEach((item, index) => {
    let fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      readFileList(path.join(dir, item), filesList); //递归读取文件
    } else {
      filesList.push(fullPath);
    }
  });
  return filesList;
}
let filesList = [];//当前所有的图片列表
readFileList('./public/uploads', filesList);


function clearPhotos() {
  console.log('所有文件', filesList)
  getImgUrl().then(res => {
    //res: 当前数据库引用的图片列表
    let quotative = [];//存储 当前数据库引用的图片列表 中 本地存在的图片地址
    filesList.forEach(item => {
      let c = item.substring(7);
      res.forEach(items => {
        if (items === c) {
          // 一旦发现本地图片地址和数据库里图片地址相等,说明该图片地址是被引用的
          quotative.push(items)
        }
      })
    })
    console.log("数据库引用的", quotative);

    for (let i = 0; i < filesList.length; i++) {//外层 filesList:本地图片列表
      let local = filesList[i].substring(7);
      let flag = false
      for (let j = 0; j < quotative.length; j++) {// 里层 quotative:数据库和本地都有的图片列表
        if (local === quotative[j]) { 
          // 一旦发现本地的图片和 quotative的图片地址相等,说明当前local有被数据库引用,则修改flag为真
          flag = true
        }
      }
      if (!flag) {
        // 第一次外层循环走完,如果flag为假,说明该local在数据库无引用,则删除
        console.log('无引用的', local)
        fs.unlink(filesList[i], function (err) {
          if (err) {
            return console.error(err);
          }
          console.log("文件删除成功！");
        });
      }
    }
  })
}

module.exports = clearPhotos;

