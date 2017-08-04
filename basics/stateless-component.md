# stateless component

组件化开发思想第一条是：
> 1. 函数就是组件，组件就是函数。 

```jsx
import React from 'react';

const ComponentA = (props) => {
  return <h1>ComponentA, welcome {props.name}</h1>
}
const App = () => {
  const componentA1 = <ComponentA name="magicly" />
  const componentA2 = ComponentA({ name: "magicly" });
  console.log(typeof componentA1, typeof componentA2, typeof ComponentA);
  console.log(componentA1, componentA2);
  return (
    <div className="App">
      <componentA1 />
      {componentA1}
      {componentA2}
    </div>
  );
}

export default App;
```
可以看到`ComponentA`是函数，所以`ComponentA({ name: "magicly" })`是函数调用，所以`componentA1`其实就是函数调用的结果，类型是object。而`<ComponentA name="magicly" />`其实也是调用了函数，所以两种写法结果是一样的。

但是我把`componentA1`和`componentA2`打印出来，发现两个object并不完全一致:
```
componentA1的type是function ComponentA(props)
componentA2的type是"h1"
```
而实际渲染出来的DOM结构则完全一样。

还要注意，因为`componentA1`和`componentA2`已经是React组件了， 所以再写`<componentA1 />`或`<componentA2 />`没有意义，相当于是在一个object上做函数调用，是会报错的， 不过React没有报错， 只是什么都没有输出而已。而如果你直接写`{componentA1()}`则会得到报错说`TypeError: componentA1 is not a function`， 从这里可以看出`<ComponentA />`这种方式确实不完全等同于`ComponentA()`。

当然， 按照习惯， 我们还是用JSX的语法，写成html标签的形式:
```jsx
<ComponentA name="magicly" />
```

# Stateless Component vs Class Component
React里面有两种定义Component的方式，另外一种是基于class的：
```jsx
class ComponentB extends React.Component {
  render() {
    return <h1>ComponentB, welcome {this.name}</h1>
  }
}
```
那应该选哪种方式呢？每个人都有自己的taste，但我的建议是：** Stateless Component **。 stateless顾名思义就是没有state，实际上用函数定义的component除了没有state，还没有任何react组件的生命周期方法，也没有this！就是一存粹天真的函数，如此而已。所以简单直接，代码还可以少敲几行！

best practice是：
> 用Stateless组件定义一堆小组件，并包含样式。 然后在要用到state或者生命周期函数的时候再用class组件包一层，只写逻辑，而把渲染样式等转发给stateless组件。

> 如果你用redux等来管理状态了， 那么理论上而言，你是不会需要写这些包装组件的，因为react-redux自己会包装一层，也就是说你再也不需要class定义的组件了。

注意，我说的是如果你用redux的话应该是不用class组件的， 我并没有说为了不用class组件，你要用redux哈！

下次再看到class定义的组件， 请考虑一下重构成stateless component，如果你觉得实在没法重构，请出门散散步，回来继续思考！

# Refers
* https://facebook.github.io/react/docs/components-and-props.html