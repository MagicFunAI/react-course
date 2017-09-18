# create-react-app

在[create-react-app](https://github.com/facebookincubator/create-react-app)的项目页面写着：
> Create React apps with no build configuration.

React的[一篇blog](https://facebook.github.io/react/blog/2016/07/22/create-apps-with-no-configuration.html)上说明了为什么会有create-react-app这个项目，原因很简单：上手开发React太难了！！！尤其是配置各种环境，JSX、Babel、Webpack。。。。。
> Ultimately, the problem is that by choosing React (and inherently JSX), you’ve unwittingly opted into a confusing nest of build tools, boilerplate, linters, & time-sinks to deal with before you ever get to create anything.

github上出现过大量react starter项目， 然而似乎并没有改善这个问题， 所以Facebook终于官方出了一个，目前github stars在30000+，可以看出还是深得大家支持。

## 快速上手
```bash
npm install -g create-react-app

create-react-app my-app
cd my-app/
npm start
```
现在打开浏览器，访问[http://localhost:3000/](http://localhost:3000/)， 可以看到项目启动起来了。
如果开发完之后要上线的话， 可以执行下面的命令，会打包压缩文件：
```bash
npm run build
```

create-react-app已经预先配置好了Webpack和Babel，你可以直接使用。ES6、热更新、编译检查Flow、测试、代码压缩、文件名带hash、service worker等都已经支持了。