> "There are only two hard things in Computer Science: cache invalidation and naming things" - Phil Karlton

我们这一章其实都是在围绕着解决"naming things"这个问题。why？因为CSS不支持变量作用域啊😂😂😂😂😂😂

# 普通CSS
可以直接在jsx文件import css文件， 然后在component上写上className就可以了。注意这里是className而不是class，因为class是js的关键字。
```jsx
import './styleA.css'

<MyComponentA clssName="red" />
```
```css
.red {
  color: red;
  background-color: green;
}
```
用这种方式，最大的好处就是跟原来没有太大区别， 还是直接写css，代码迁移成本最低。但是跟原来一样， 同样没办法解决命名冲突的问题。比如还有一个componentB，如下：
```jsx
import './styleB.css'

<MyComponentB clssName="red" />
```
```css
.red {
  color: red;
  background-color: white;
}
```
那么两个css文件， 由于className都是.red，则会产生冲突，至于具体background-color最后会是白色还是绿色，则取决于两个组件的出现顺序，总之不会是你想要的结果。

# React内联样式

React可以直接在component上写样式，属性是style，但是值必须值一个对象，且要用驼峰格式，如下：

```jsx
<div style={{color: "red", backgroundColor: "green"}}>react inline style</div>
```

很多人一开始会觉得奇怪，为什么是两个大括号```{{}}```呢？注意本身props传属性的时候，如果是javascript值的话就要用{}包起来，然后因为里面的样式本身是javascript object，所以还有一层{}。代码改成如下形式就一目了然了：

```jsx
cosnt myStyle = {color: "red", backgroundColor: "green"}
<div style={myStyle}>react inline style</div>
```
最后生成的html如下：
```html
<div style="color: red; background-color: green;">react inline style</div>
```
inline样式不存在样式命名冲突的问题，但是inline style有自己的问题，比如大家都知道的代码重复啊，没法缓存啊等等。

# CSS modules
[css modules](https://github.com/css-modules/css-modules)是[Glen Maddern](https://twitter.com/glenmaddern)开发的一套工具，用于解决css样式冲突问题，目前也很是流行。[Glen Maddern](https://twitter.com/glenmaddern)在他的[blog](https://glenmaddern.com/articles/css-modules)上详细介绍了css modules的好处和设计理念， 有兴趣的可以看看。

经过对比，我发现[styled-components](https://github.com/styled-components/styled-components)要更方便好用一些，因此我们主要讲解[styled-components](https://github.com/styled-components/styled-components)。 [Glen Maddern](https://twitter.com/glenmaddern)本人后来也参与了[styled-components](https://github.com/styled-components/styled-components)的核心开发工作，由此也可以作为一个考量依据，建议大家选择[styled-components](https://github.com/styled-components/styled-components)。

# 总结
由于CSS本身不支持命名作用域（或者说只有一个global作用域），因此很容易出现命名冲突。出现的很多技术都是为了解决命名冲突的问题。本章简要介绍了用普通的CSS，React inline style，css modules的方法以及存在的问题，这里推荐一篇讲[CSS各种技术发展](https://m.alphasights.com/css-evolution-from-css-sass-bem-css-modules-to-styled-components-d4c1da3a659b)的blog，大家有兴趣的可以看看。还有一个[github repo对各种方法进行了对比](https://github.com/styled-components/comparison)，这个repo是styled-components提供的，也就是接下来我们要讲的重点。

# Refers
* https://www.zhihu.com/question/30757566
* https://m.alphasights.com/css-evolution-from-css-sass-bem-css-modules-to-styled-components-d4c1da3a659b
* https://facebook.github.io/react/docs/dom-elements.html#style
* https://github.com/css-modules/css-modules
* https://glenmaddern.com/articles/css-modules
* https://github.com/styled-components/comparison
* https://github.com/styled-components/styled-components
* https://www.smashingmagazine.com/2017/01/styled-components-enforcing-best-practices-component-based-systems/
