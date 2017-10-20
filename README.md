# React学习课程

课程地址 https://react-course.magicfun.ai/

作者使用React + Redux + webpack开发两年有余， 也用过React Native，期间既有发现新功能时的惊喜，也有踩坑时的痛苦，希望将这两年多的所学所思整理成文，让新人少踩坑，早入React之门。

内容主要包括：
* React基础知识，包括JSX，Component，props vs state，生命周期函数等
* React里如何组件化地写样式
* router
* 状态管理之Redux
* 静态代码检查
* 测试
* 性能优化
* 不可变对象

最后会安排一个完整的实战项目，覆盖React绝大部分知识点。

# FAQ
## 关于作者
作者谦谦君子，网名[magicly](https://magicly.me/)，2010年毕业于北大，获信息管理学士学位和计算机软件学士学位，毕业之后先后在酷我音乐，人人游戏，腾讯等知名互联网公司工作，之后在成都一家创业公司担任CTO，带过一年多的团队。从前到后，网页设计、微信公众号、小程序、后端接口、数据库设计优化、运维脚本、数据统计分析等都做过，使用过Java、JS、Scala、Python、Bash、C++、Rust等语言，算不上精通，但也远非只会写`Hello World`。最近关注大前端（包括[Node.js](https://nodejs.org/en/), [React](http://facebook.github.io/react/), [React Native](https://facebook.github.io/react-native/), [Electron](https://electron.atom.io/), [Web Workers](https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API/Using_web_workers), [WebAssembly](http://webassembly.org/), [WebGL](https://developer.mozilla.org/zh-CN/docs/Web/API/WebGL_API), [Three.js](https://threejs.org/), [D3.js](https://d3js.org/)等）以及[深度学习算法](https://magicly.me/iamtrask-anyone-can-code-lstm/)等。

欢迎关注[微博](https://weibo.com/magicly)，或者扫描关注微信公众号![jsforfun](https://static.magicfun.ai/qrcode/jsforfun.jpg)

## 适用于什么人群？
适合有一定前端基础，掌握HTML、CSS、Javascript基础知识，想了解React生态系统以及组件化开发思想的同学。对于非前端同学，建议先自行学习HTML、CSS、Javascript基础知识，推荐[w3schools](https://www.w3schools.com/)，或者中文版[W3School](http://www.w3school.com.cn/)。

如果你有还完全不了解React，那么恭喜你，学习完这门课程， 你可以掌握React生态系统中的绝大多数核心东西，并可以少走很多弯路，为进阶中高级工程师打下坚实的基础。

如果你已经了解或使用过React，你可以选择某部分章节学习，当然你也可以选择全部学习，也会有很多收获，你也许会发现本课程提供的许多最佳实践是你没尝试过或者跟你之前所学不一致的，欢迎讨论。

如果你已经很熟悉React，欢迎对文中任何有问题的地方提出意见和建议，我们一起探讨学习。

## 为什么是React？
一般问这个问题的同学，如果我们是在讲Vue，他也会问为什么是Vue呢？O__O "…， 这个问题实在不好回答， 所以我的回答一般是：为什么不呢？

目前流行的三大框架[Angular](https://angular.io/), [React](https://facebook.github.io/react/), [Vue](https://vuejs.org/)，其实都很强大，都很值得学习。 我第一次看到[Angular](https://angular.io/)的双向绑定的时候， 都惊呆了， 原来前端还可以这样写。同样，当我看到[React](https://facebook.github.io/react/)的时候，也是同样的感受。而[Vue](https://vuejs.org/), 不好意思，因为我还没有系统学习过，只是听很多用过的人说挺不错的， 上手也快， 我也打算有空的时候学习一下。

所以如果非得要回答这个问题，我的回答可能是：因为我最熟悉React啊！另外，这三个中React是现在[github](https://github.com/facebook/react)上star最多的一个（此刻2017-09-04 10：06，74904）。PS，不知道我这样说是不是会让一部分人开心，又有一部分愤怒呢。 所以别纠结了，纠结这么久， 别人都已经学好一个，工资double了！

## 为什么是X?
对了，接上一个问题，我再提一点，本课程会带有很强的“个人色彩”，包括css-in-js的选择选用[styled-components](https://github.com/styled-components/styled-components/)，状态管理的选择选用[Redux](https://github.com/reactjs/redux)以及代码检查、代码风格、测试库等其他的一些选择。这些都是我基于两年多使用经验总结的“最佳实践”，当然React的生态系统很活跃，几乎每一个问题都有很多开源的库来解决，我的选择并不代表其他方案不好，可能更多的是符合我的“品味”吧， 希望大家可以理解，也鼓励大家自行探索尝试更多的选择。

所以当再有人问我“为什么是X而不是Y”的时候，我的回答可能是“不好意思，Y我没有用过”，或者是”因为我喜欢！”。希望到时候大家不要觉得我是在敷衍。

生命苦短，何必[纠结](https://read.douban.com/ebook/13351764/)！

## 课程形式是什么样的呢？
会以文字、图片的形式写成书籍放到网上，另外会录制视频讲解实例代码等，代码会托管到[github](https://github.com/MagicFunAI/react-course)上。

每周一我们会发布一章，核心内容大概两个月课程，最后一个月会是一个完整的项目实战。

## 课程时间安排
课程从9.18正式开始，每周会发布一章教学内容。

## 费用如何？
课程内容本身（包括文字和视频）所有都免费（如果真觉得好，可以打赏哈<img src="https://static.magicfun.ai/qrcode/wxpay.png" alt="扫码打赏" width="200" height="200" />）。

## 有交流微信、QQ群么？
没有！从我经验而言，很多所谓的技术交流微信、QQ群过不了多久就会变成各种吹水群，而且微信、QQ群也不利于知识的沉淀积累。

那有问题如何交流呢？咱可是程序员啊！当然得用程序员的方式！可以用[gitter](https://gitter.im/react-magicfun)或者直接在github上提交[Issues](https://github.com/MagicFunAI/react-course/issues)。

## 可以给公司做技术培训么？
可以，请扫码联系作者。<img src="https://static.magicfun.ai/qrcode/qqjz.png" width="200" alt="谦谦君子" />