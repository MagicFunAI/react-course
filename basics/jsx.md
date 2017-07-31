# JSX

JSX即`Javascript Extension`，是在js语言上做的扩展，是为了在js里面更方便的书写html而开发。

以下即是最简单的一段JSX。
```jsx
const hi = <h1>Hello, JSX!</h1>
```

## 嵌入JS表达式
JSX里面可以很容易地嵌入JS表达式，比如：
```jsx
const hi = <h1>Hello, JSX! 1 + 1 == {1 + 1}. today is {new Date()}</h1>
```

## JSX也是表达式
而JSX本身也是一个表达式，会被Babel等编译成普通的JS对象，所以任何可以使用对象的地方都可以使用JSX，比如if判断，for循环里面，赋值给变量，作为函数参数传递或者返回值返回。比如：
```jsx
function getGreeting(user) {
  if (user) {
    return <h1>Hello, {formatName(user)}!</h1>;
  }
  return <h1>Hello, Stranger.</h1>;
}
```

## 指定属性
JSX跟html很像（其实就是为了方便使用html才发明了JSX），所以支持指定属性。比如:
```jsx
const img = <img src={user.photo} alt="this is a photo." />
```
注意，如果使用了{}，就不能再用引号包起来。

## 子元素
JSX可以包含子元素（就跟html标签一样），如果没有子元素可以直接用/>来结束标签。
```jsx
const element = (
  <div>
    <h1 className="hi">Hello!</h1>
    <h2>Good to see you here.</h2>
  </div>
);
```
注意JSX其实是JS，所以各种命名等都习惯用JS常用的camelCase风格，并且由于class是JS的关键字，所以标签里面要用className。

## 避免XSS
JSX会帮你做正确的[escape](http://stackoverflow.com/questions/7381974/which-characters-need-to-be-escaped-on-html)，避免受到[XSS](https://en.wikipedia.org/wiki/Cross-site_scripting)攻击。
```jsx
const title = response.potentiallyMaliciousInput;
// This is safe:
const element = <h1>{title}</h1>;
```
所以如果title里面有标签`<>`，则会被转义为`&lt;&gt;`，如果你确保要插入的html没有问题（比如就是你自己生成的），你可以使用`dangerouslySetInnerHTML`属性插入未被转义的html内容：
```jsx
const element = <div dangerouslySetInnerHTML={{__html: '<h1>Dangerous!</h>'}} />
```
注意这里是两个{}包起来哦， 因为外面一层是JSX里面写JS表达式， 里面一层是JS对象本身。

## JSX的内部表示
Babel会把JSX编译成`React.createElement()`调用，如下两者是完全等同的：
```jsx
const element = (
  <h1 className="greeting">
    Hello, world!
  </h1>
);
```
```jsx
const element = React.createElement(
  'h1',
  {className: 'greeting'},
  'Hello, world!'
);
```
`React.createElement()`会做一些检查（比如props类型等）来减少bug，然后生产如下的对象：
```jsx
// Note: this structure is simplified
const element = {
  type: 'h1',
  props: {
    className: 'greeting',
    children: 'Hello, world'
  }
};
```
这些对象叫“React elements”，可以把它看成是对想要展现在屏幕上的内容描述。React读取这些对象，然后用它们构造DOM节点，并保持状态一致。

## Rerfers
* https://facebook.github.io/react/docs/introducing-jsx.html
* https://zhuanlan.zhihu.com/p/28035334