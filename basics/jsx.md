# JSX

JSX即`Javascript Extension`，是在js语言上做的扩展，是为了在js里面更方便地书写html而开发。

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
注意，不要使用引号把{}包起来。

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

如果没有子元素的话，可以直接使用闭标签， 比如：
```jsx
<img src="x.jpg" alt="a pic" />
```
会被翻译成：
```js
React.createElement(
  'img',
  {src: 'x.jpg', alt: 'a pic'},
  null
)
```
你可以使用[在线Babel编译器](https://babeljs.io/repl/#?babili=false&browsers=&build=&builtIns=false&code_lz=GYVwdgxgLglg9mABACwKYBt1wBQEpEDeAUIogE6pQhlIA8AJjAG4B8AEhlogO5xnr0AhLQD0jVgG4iAXyA&debug=false&circleciRepo=&evaluate=true&lineWrap=false&presets=es2015%2Creact%2Cstage-0&prettier=false&targets=&version=6.26.0)来查看JSX具体编译成什么样的JS。

## 必须import React
因为JSX是编译成`React.createElement`，所以`React`必须在JSX文件中被import，否则会编译报错。比如下面的例子，虽然没有直接引用`React`，但是也需要import进来。这是初学者常犯的一个错误，经常出现在`stateless component`文件中， 因为`container component`里面需要显示地`extends React.Component`。
```jsx
import React from 'React';
import CustomButton from './CustomButton';

function WarningButton() {
  // return React.createElement(CustomButton, {color: 'red'}, null);
  return <CustomButton color="red" />;
}
```

## 自定义的组件必须大写开头
小写字母开头的组件是`built-in`的组件，比如`<div>`或者`<span>`等。如果你定义了一个小写字母开头的组件，那也可以， 不过在用在JSX之前，必须赋值给一个大写字母开头的变量。感觉有点奇怪， 所以不建议这样用，记住定义组件的时候就大写字母开头好了。
```jsx
import React from 'react';

// Wrong! This is a component and should have been capitalized:
function hello(props) {
  // Correct! This use of <div> is legitimate because div is a valid HTML tag:
  return <div>Hello {props.toWhat}</div>;
}

function HelloWorld() {
  // Wrong! React thinks <hello /> is an HTML tag because it's not capitalized:
  return <hello toWhat="World" />;

  // 可以这样修复
  //const Hello = hello;
  //return <Hello toWhat="World" />;
}
```
最好是定义的时候就定义成大写字母开头的：
```jsx
import React from 'react';

// Correct! This is a component and should be capitalized:
function Hello(props) {
  // Correct! This use of <div> is legitimate because div is a valid HTML tag:
  return <div>Hello {props.toWhat}</div>;
}

function HelloWorld() {
  // Correct! React knows <Hello /> is a component because it's capitalized.
  return <Hello toWhat="World" />;
}
```

## JSX Type用`.`表达式
如果你只有一个`module`export了很多`React components`，那么可以用`.`表达式直接访问，比如：
```jsx
import React from 'react';

const MyComponents = {
  DatePicker: function DatePicker(props) {
    return <div>Imagine a {props.color} datepicker here.</div>;
  }
}

function BlueDatePicker() {
  return <MyComponents.DatePicker color="blue" />;
}
```

## 运行时候动态选择组件类型
React组件的类型不能是一个表达式。如果需要根据运行时的状态（比如props的某个值）来渲染不同的组件类型， 可以先把表达式赋值给某个大写字母开头的变量。
```jsx
import React from 'react';
import { PhotoStory, VideoStory } from './stories';

const components = {
  photo: PhotoStory,
  video: VideoStory
};

function Story(props) {
  // Wrong! JSX type can't be an expression.
  return <components[props.storyType] story={props.story} />;
}
```
这样才可以：
```jsx
function Story(props) {
  // Correct! JSX type can be a capitalized variable.
  const SpecificStory = components[props.storyType];
  return <SpecificStory story={props.story} />;
}
```

## JSX的props
JSX中props的值可以是很多种类型。
### JS表达式
```jsx
<MyComponent foo={1 + 2 + 3 + 4} />
```
### 字符串
下面两种写法是一样的， 当然我们一般用第一种，因为简单啊！
```jsx
<MyComponent message="hello world" />

<MyComponent message={'hello world'} />
```
### 不指定值默认是`true`
下面两者等价，不过官方说不推荐第一种，因为容易与[ES6 object shorthand](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#New_notations_in_ECMAScript_2015)的写法`{autocomplete}`表达的是`{autocomplete: autocomplete}`混淆，官方提供这种写法只是为了跟HTML保持一致。
```jsx
<MyTextBox autocomplete />

<MyTextBox autocomplete={true} />
```
### 展开object
如果父组件传递的props你想全部传递给子组件，用`...`展开object操作符会很方便，这个也是ES6的新特性[Spread syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_operator)。
```jsx
function App1(props) {
  return <Greeting firstName={props.firstName} lastName={props.lastName} />;
}

function App2(props) {
  return <Greeting {...props} />;
}

<App1 props={firstName: 'Ben', lastName: 'Hector'} />
<App2 props={firstName: 'Ben', lastName: 'Hector'} />
```
不过这个功能要慎用，我见过很多人不管父组件传递过来的`props`包含多少个属性，统统都直接`{...props}`传递给子组件，而其实父组件传递过来的`props`可能有10个属性，而子组件只需要1个。而且这样写也看不出来子组件具体需要那几个参数，所以如果不是特别多的话，最好还是显示地写出来传递的`props`值。记住：
> Explicit is better than implicit.。

## 子组件
JSX中在开标签和闭标签之间的内容会通过`props.children`传递给组件，值的类型有很多种。
### 字符串
```jsx
<ComponentA>Hello, React!</ComponentA>
```
上述写法`ComponentA`中可以通过`props.children`拿到字符串`Hello, React!`。字符串是`unescaped`的，所以`<>`需要转义之后传递`&lt;&gt;`。
JSX会把下面这些空白去掉：
1. 每行开始和结尾的空白
2. 空行会去掉
3. 挨着标签的换行会去掉
4. 字符串中间的很多换行会合并成一个空格
5. 字符串中间的空格不会去除，不过HTML显示的时候本身多个空格只会显示一个

所以下面这几种都是一样的， 大家可以合理利用空白来增强代码的阅读性。
```jsx
    <div>Hello World</div>

    <div>
      Hello            World
    </div>

    <div>
      Hello


      World
    </div>

    <div>

      Hello World
    </div>
```
### JSX组件
跟HTML一样，JSX组件可以嵌套，不同种类的子组件也可以混用，比如：
```jsx
<MyContainer>
  Here is a list:
  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
  </ul>
  <ComponentA>sth...</ComponentA>
  <ComponentB />
</MyContainer>
```

### JS表达式
比如：
```jsx
<MyComponent>foo</MyComponent>

<MyComponent>{'foo'}</MyComponent>

<MyComponent>{1 + 2 * 3}</MyComponent>
```
这种方式用来循环渲染列表的时候很适合，如：
```jsx
function Item(props) {
  return <li>{props.message}</li>;
}

function TodoList() {
  const todos = ['finish doc', 'submit pr', 'nag dan to review'];
  return (
    <ul>
      {todos.map((message) => <Item key={message} message={message} />)}
    </ul>
  );
}
```

### 函数！！！
JS里面函数是第一等公民，也是可以像数字、字符串一样传递的。当然传递一个函数拿来显示会很奇怪（试一下，发现不会渲染，除非调用`toString()`转化为String），所以一般传递过去的函数会被调用进行一些转换，转化为React可以渲染的东西。
```jsx
// Calls the children callback numTimes to produce a repeated component
function Repeat(props) {
  let items = [];
  for (let i = 0; i < props.numTimes; i++) {
    items.push(props.children(i));
  }
  return <div>{items}</div>;
}

function ListOfTenThings() {
  return (
    <Repeat numTimes={10}>
      {(index) => <div key={index}>This is item {index} in the list</div>}
    </Repeat>
  );
}
```
### Booleans, Null, Undefined会被忽略
`false`, `null`, `undefined`, 以及***`true`***都是合法的子元素，但是不会被渲染出来。下面这些JSX渲染出来对的都是一样的： 空元素！
```jsx
<div />

<div></div>

<div>{false}</div>

<div>{null}</div>

<div>{undefined}</div>

<div>{true}</div>
```
这样做条件渲染就比较方便了，下面这样写的话只有`showHeader`为`true`的时候`<Header />`才会被渲染：
```jsx
<div>
  {showHeader && <Header />}
  <Content />
</div>
```
注意有些所谓的[`falsy value`](https://developer.mozilla.org/en-US/docs/Glossary/Falsy)，比如`0`是会被React渲染的。所以下面的例子中，如果`messages`是空的话，是会显示`0`的。
```jsx
<div>
  {props.messages.length &&
    <MessageList messages={props.messages} />
  }
</div>
```
可以把`&&`之前的表达式变成`boolean`来修复：
```jsx
<div>
  {props.messages.length > 0 &&
    <MessageList messages={props.messages} />
  }
</div>
```
如果确实需要显示`false`, `null`, `undefined`以及`true`的话，需要转化为`String`。
```jsx
value is {String(true)}
value is {'' + null}
value is {`${undefined}`}
```


## Rerfers
* https://facebook.github.io/react/docs/introducing-jsx.html
* https://facebook.github.io/react/docs/jsx-in-depth.html