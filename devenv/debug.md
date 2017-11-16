# 调试工具

## Chrome DevTools

## React Developer Tools

## Redux DevTools Extension

## VSCode Debugger

## 热更新
我觉得热更新(Hot Module Replacement)，简直就是神器， 可以动态更新组件而保持状态， 真的是大大改善了开发效率。

不过遗憾的是，目前CRA还不支持`保持状态`， 可以看这里：https://github.com/facebookincubator/create-react-app/issues/2317
> If you are using external state management such as Redux, you can have your redux state remain when component changes are made.

> Note: This is not same a component based hot-module-reloading where state within your react application remains unchanged when making changes to your source code. HMR will remove any component-based state. That is currently unsupported by CRA, more information see react-hot-loader and status post by gaereon.

并且要手动配置一下， 写如下代码：
```jsx
// regular imports
ReactDOM.render(<App /> , document.getElementById('root'))

if (module.hot) {
  module.hot.accept('./App', () => {
    ReactDOM.render(<App />, document.getElementById('root'))
  })
}
```

[gaearon](https://github.com/gaearon)大大也说了： https://github.com/facebookincubator/create-react-app/issues/2972
> We may implement hot reloading of React components in the future (there is a pending PR) but we haven't had time to finish it yet.

https://github.com/facebookincubator/create-react-app/issues/93

可以关注https://github.com/facebookincubator/create-react-app/pull/2304 ， 估计应该快了。

[webpack本身是支持的](https://webpack.js.org/concepts/hot-module-replacement/)， 如果你实在现在就要用（而且没有用redux），应该可以自己`eject`之后自己修改`webpack.config.js`实现。