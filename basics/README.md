# React基础知识

在几年前开发web页面的标准思路还是HTML写内容，CSS控制样式，JS控制逻辑和动态效果，三者要分开，目录结构也是按文件类型分开的。然后随着web基础的飞速发展，浏览器性能越来越好，支持的功能越来越多，前端工程化越来越强，web开发已经从原来的写“页面”变成了开发web APP！以前的按照文件类型组织项目的方式也已经越来越满足不了现在复杂的需求了。随着[React](https://facebook.github.io), [Ember](https://www.emberjs.com/), [Angular 2](https://angular.io/)等的出现以及W3C本身也提出的web component技术，我们已经进入了组件化的开发时代，思路、工具以及开发方式等都要有重大转变，才能适应目前日益复杂和快速多变的web开发工作。

下面是我两年多学习使用React的经验总结，希望能对大家有所帮助。

1. 函数就是组件，组件就是函数。 
2. 每一个组件只做一件事。
3. 显示组件和逻辑组件分开。

接下来的章节，我们会反复强调这几个基本思路，现在我们先来看看函数和组件的关系。

开始学习React之前，**强烈建议先看一下下面这篇关于React开发思想的文章**，思想上转化过来，后面会事半功倍。
* https://reactjs.org/docs/thinking-in-react.html

===============

最近不知道是B站抽风还是修改了分享规则， 分享出来的视频看不了， 大家也可以直接打开此链接：https://www.bilibili.com/video/av14819635/

<embed height="415" width="544" quality="high" allowfullscreen="true" type="application/x-shockwave-flash" src="//static.hdslb.com/miniloader.swf" flashvars="aid=14819635&page=1" pluginspage="//www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"></embed>