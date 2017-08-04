# 事件

在React里面处理事件，跟在html DOM节点上很像，区别有两点：
1. react里用camelCase而不是lowercase
2. JSX里传递函数，而不是string

比如，html里你这样写：
```html
<button onclick="clickme()">
  Click me!
</button>
```
在React里你要这样写：
```jsx
<button onClick={clickme}>
  Click me!
</button>
```
注意上面clickme后面没有括号哦， react里面是传递函数本身，如果加了()就变成了函数调用咯。

另外，在html里一般可以用`return false`的方式来阻止默认行为，在react里面不行，必须用`preventDefault`。
html里：
```html
<a href="#" onclick="console.log('clicked'); return false">
  Click me!
</a>
```
react里：
```jsx
const handleClick = e => {
  e.preventDefault();
  console.log('clicked');
}
<a href="#" onClick={handleClick}>
  Click me!
</a>
```
其中`e`是react封装的[SyntheticEvent](https://facebook.github.io/react/docs/events.html)，所以可以不用考虑浏览器兼容性问题。 God bless!

## this问题
我们在[30分钟简介](../quickintro/)中提到过这个问题， 再来看看。
```jsx
class Toggle extends React.Component {
  constructor(props) {
    super(props);
    this.state = {isToggleOn: true};

    // 如果没有这行，在button被click然后执行handleClick的时候this是undefined
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    this.setState(prevState => ({
      isToggleOn: !prevState.isToggleOn
    }));
  }

  render() {
    return (
      <button onClick={this.handleClick}>
        {this.state.isToggleOn ? 'ON' : 'OFF'}
      </button>
    );
  }
}
```
所以经常看到很多人写的constructor里面一堆bind
```js
  this.function1 = this.function1.bind(this);
  this.function2 = this.function2.bind(this);
  this.function3 = this.function3.bind(this);
  ......
```
解决方法是用[箭头函数](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)，因为[箭头函数](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)自己没有绑定this，所以它里面的this是自己被定义时候的this。

箭头函数可以写在JSX上，比如：
```jsx
    return (
      <button onClick={(e) => this.handleClick(e)}>
        {this.state.isToggleOn ? 'ON' : 'OFF'}
      </button>
```
也可以用js的一个新特性，所谓的[property initializer syntax](https://babeljs.io/docs/plugins/transform-class-properties/)，如下：
```jsx
class Toggle extends React.Component {
  constructor(props) {
    super(props);
    this.state = {isToggleOn: true};
  }

  handleClick = () => {
    this.setState(prevState => ({
      isToggleOn: !prevState.isToggleOn
    }));
  }

  render() {
    return (
      <button onClick={this.handleClick}>
        {this.state.isToggleOn ? 'ON' : 'OFF'}
      </button>
    );
  }
}
```