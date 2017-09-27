一开始看到styled-components的写法的时候， 我也是一脸懵逼，这是什么鬼？！！
```js
const Title = styled.h1`
	font-size: 1.5em;
	text-align: center;
	color: palevioletred;
`;
```
这又是什么语法， js? jsx?还是其他什么自定义的语法？需要babel支持么？需要webpack配置插件么？最后发现它居然就是正宗的Javascript！！！就是正宗的Javascript！！！就是正宗的Javascript！！！

原来是ES6的一个新特性，[Tagged Template Literals！](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/template_strings)

# Template literals
模板字符串大家应该都熟悉了吧，就是
> 模板字面量/Template literals 是允许嵌入表达式的字符串字面量。你可以使用多行字符串和字符串插值功能。它们在ES2015规范的先前版本中被称为“模板字符串/template strings”。
比如:
```js
`普通的字符串就ok，只需要把字符串的单/双引号改为反引号就可以啦`// 普通的字符串就ok，只需要把字符串的单/双引号改为反引号就可以啦
`里面也可以插入表达式${1 + 1}, ${Date.now()}, ${true ? 'true!' : 'false!'}...` // 里面也可以插入表达式2, 1501229051899, true!...`
```

# Tagged Template Literals
template string既然就是字符串，那就可以作为参数传递给函数，而ES6对将template strings传递给函数做了新的语法支持。我们先来定义一个函数：
```js
const f = (...args) => console.log(...args);
```
这个函数只是简单地输出传入的参数，大家可以在自己的chrome console里面执行一下， 然后自己跑一下代码：
```
f(1, 2) // 1 2
```
如果我们传入template strings呢？
```js
f(``) // ""
f(`12`) // "12"
f`` // [""]
f`12` // ["12"]
```
对比发现，如果是把template string放在括号里面，那其实就是把template string执行结果的字符串传给函数，没什么稀奇的。 但是如果直接把template string放在函数后面， 没有括号的话， 得到的居然是包含字符串的数组？！

我们前面说了template string里面是可以有“插值（interpolations）”的，比如`abc${1 + 1}`，如果我们把这个传递给函数f会得到什么呢？
```js
f(`abc${1 + 1}edf, now=${Date.now()}.`) // abc2edf, now=1501230160188.
f`abc${1 + 1}edf, now=${Date.now()}.` // ["abc", "edf, now=", "."] 2 1501230160188
```
可以看出，将带interpolations的template string用括号包起来传入函数f，则得到的参数就是一个执行过的string，没有什么稀奇的。但是如果直接把template string放在函数后面， 没有括号的话， 得到的第一个参数是是包含字符串的数组，并且这些字符串是由interpolations分隔开的字符串，而后面的第2个参数是第1个interpolations的value，第3个参数是第2个interpolations的value......

然而这又有什么用呢？我们刚说了，“后面的参数是某个interpolations的value”，关键就在这value上。在js里面，value可以是数字123，可以是string"abc"，可以是数组[1, 2, 3]， 可以是对象{a: 1}， 也可以是函数(a, b) => {return a + b;}啊！so，如果我们的template string里面有某个函数又会怎样呢？
```js
f(`test ${() => console.log('test function')}`) // test () => console.log('test function')
f`test ${() => console.log('test function')}` // ["test", ""] () => console.log('test function')
```
肉眼上可能很难看出来，但是第一个调用里面，输出的是函数toString()转为字符串后的结果，也就是并非真正的函数，所以不能执行。而第二个调用，输出的是真正的函数，那就可以执行这个函数！

我们再定义一个函数：
```js
const execArgs = (...args) => args.forEach(arg => {
  if (typeof arg === 'function') {
    arg()
  }
})
```
然后调用一下：
```js
execArgs(1, 2) // undefined
execArgs(() => {console.log('a function!')}) // a function!
execArgs(1, 'a', () => {console.log('another function!')}) // another function!
```
试试template string呢？
```js
execArgs(`template string, ${() => {console.log('template string!')}}`) // undefined
```
可以看到，传递过去的确实已经不是function了。
```js
execArgs`template string, ${() => {console.log('template string!')}}` // template string!
```
再次证明，传递过去的确实是函数本身！

现在我们可以转到styled-components上来了。
```js
styled.h1`
font-size: 1.5em;
`
```
就等于如下
```js
styled.h1('font-size: 1.5em;')
```
so, 其实styled.h1， styled.div等就是一个函数， 他们接受Tagged Template Literals这样的参数。

而为了实现根据传入的props显示不同样式，我们可以这样定义:
```jsx
const MyDiv = styled.div`
  color: ${props => props.color};
  font-size: ${props => props.bigger ? '2em' : '1em'};
`
```
然后我们在使用的时候就可以这样使用：
```jsx
<MyDiv color="green" bigger>anything in div...</MyDiv>
```
然后styled-components在render的时候会把props传递给template string里面的interpolations函数，这些函数就能根据props的值来显示不同的样式了。

# Refers
* https://mxstbr.blog/2016/11/styled-components-magic-explained/
* https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/template_strings