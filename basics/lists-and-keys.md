# Lists and Keys

程序里面经常会用到for循环来处理大量的数据，js的数组自带map方法可以很方便地进行数组转化操作。比如：
```js
const nums = [1, 2, 3, 4];
const nums2 = nums.map(num => num * 2); // [2, 4, 6, 8]
```

React里面也可以用map来显示大量的组件，只要map返回的是合法的react组件即可，比如：
```jsx
const libs = ['react', 'vue', 'angular'];
const listItems = libs.map(lib => <li>{lib}</li>);
```
注意这里`listItems`是数组，所以如果直接render的话会报错，必须用一个组件包起来：
```jsx
ReactDOM.render(
  <ul>{listItems}</ul>,
  document.getElementById('app')
);
```

# Keys
前面代码会在console里面报错
```js
Warning: Each child in an array or iterator should have a unique "key" prop. Check the render method of `ListsAndKeys`. See https://fb.me/react-warning-keys for more information.
```
`key`能帮助React知道哪些组件有变化，有助于提升DOMDiff算法的效率，我们后面再细讲，这里只需要知道把`key`设置成一个唯一的值（尽量是item的ID，不行直接用item.toString()也行）就可以了。比如：
```jsx
  const libs = ['react', 'vue', 'angular'];
  const listItems = libs.map(lib => <li key={lib}>{lib}</li>);
```
注意，`key`只在数组map那里有意义，比如我们重构一下代码，把`<li key={lib}>{lib}</li>`提取成一个组件。
```jsx
  const Item = (props) => <li key={props.lib}>{props.lib}</li>; // wrong!!! key写在这里没有用

  // 这才是正确的写法！
  const Item = (props) => <li>{props.lib}</li>;
  const listItems = libs.map(lib => <Item key={lib}></Item>);
```
对了， `key`是React内部为了提高算法效率使用的， 所以通过`props.key`你是拿不到`key`值的，如果组件需要，那只能换个名字传递，比如：
```jsx
  const Item = (props) => <li id={props.id}>{props.lib}</li>;
  const listItems = libs.map(lib => <Item key={lib} id={lib}></Item>);
```