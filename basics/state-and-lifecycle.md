# State and Lifecycle

组件化开发思想第二条是：
> 1. 样式跟状态分离。

现在我们来实现一个时钟应用：只是显示当前时间！

# 显示
用stateless组件，so easy:
```jsx
const Clock = (props) => {
  return <h1>{new Date().toLocaleTimeString()}</h1>
}
```

# state
stateless组件和props都是静态的，只能显示出固定的内容， 如果我们要显示动态内容（每一秒的时间都不一样呢），需要用到state。so，我们转化为class组件。
```jsx
class Clock2 extends React.Component {
  constructor(props) {
    super(props);// constructor里第一行必须是这行，否则会报错
    this.state = {
      time: new Date().toLocaleTimeString(), // 这里是唯一一处直接复制给this.state的，其他地方请用this.setState({...})
    }
  }
  render() {
    return <h1>{this.state.time}</h1>
  }
}
```

# 添加定时器
然而上述代码还是静态的，只能显示constructor执行那一秒时的时间，我们需要用setInterval起一个定时器，每秒去更新时间。

在哪里起定时器呢？ 应该是在DOM节点被渲染的时候， 这个叫`Mounting`。 同样，在不需要Clock组件的时候，我们也需要清除定时器，否则会出现内存泄露。那应该在哪里清除呢？应该在DOM节点被卸载的时候， 叫`Unmounting`。

React提供了这两个时间点的回调函数给我们用。
```jsx
class Clock2 extends React.Component {
  constructor(props) {
    super(props);// constructor里第一行必须是这行，否则会报错
    this.state = {
      time: new Date().toLocaleTimeString(), // 这里是唯一一处直接复制给this.state的，其他地方请用this.setState({...})
    }
  }
  componentDidMount() {
    console.log('componentDidMount');
    // timer不需要拿来渲染， 所以不要把timer让在this.state里
    this.timer = setInterval(() => {
      this.setState({
        time: new Date().toLocaleTimeString(),
      }) // 注意，如果直接修改this.state.time = new Date().toLocaleTimeString()是不行的， 不会渲染页面！
    })
  }
  componentWillUnmount() {
    console.log('componentDidMount');
    clearInterval(this.timer);
  }
  render() {
    return <h1>{this.state.time}</h1>
  }
}
```

一定要注意代码里面的几条注释！

# 重构：显示和状态分离
我们之前说了，用stateless组件来负责显示，class组件来负责状态和逻辑，代码可以改为：
```jsx
import React from 'react';

const Clock = (props) => {
  return <h1>{props.time}</h1>
}

class ClockContainer extends React.Component {
  constructor(props) {
    super(props);// constructor里第一行必须是这行，否则会报错
    this.state = {
      time: new Date().toLocaleTimeString(), // 这里是唯一一处直接复制给this.state的，其他地方请用this.setState({...})
    }
  }
  componentDidMount() {
    console.log('componentDidMount');
    // timer不需要拿来渲染， 所以不要把timer让在this.state里
    this.timer = setInterval(() => {
      this.setState({
        time: new Date().toLocaleTimeString(),
      }) // 注意，如果直接修改this.state.time = new Date().toLocaleTimeString()是不行的， 不会渲染页面！
    })
  }
  componentWillUnmount() {
    console.log('componentDidMount');
    clearInterval(this.timer);
  }
  render() {
    return <Clock time={this.state.time} />
  }
}
export default ClockContainer;
```
这样我们就把负责静态内容显示的组件拆为`Clock`，而用`ClockContainer`专门负责逻辑：每秒更新一次状态。

肯定会有人说，这完全就是多此一举把代码搞复杂了啊。 是的！在这个简单的例子里面确实没必要，但是如果你是在实战中，可能`Clock`这个负责显示的组件会很复杂，有颜色，有布局，有不同的形状吗，甚至可能还会调用很多其他更小的组件，这样拆分后你在修改`Clock`的时候就完全不用管`ClockContainer`。 同样，如果有一天你想把显示逻辑改为精确到毫秒，你也只用修改`ClockContainer`而完全不用动`Clock`。

当然，如果你的实际项目就是像demo这么简单的话， 我觉得你应该使用[jQuery](https://jquery.org/)甚至直接用原生js而不用React的啊！ I really mean it!