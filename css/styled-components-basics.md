# 安装
styled-componets的使用很简单，首先，需要安装。
```bash
$ npm install --save styled-components
```

# 基本用法
styled-components的想法是将样式“附着”在component上，使其变成“被样式化了的组件”。看一个最简单的例子：
```jsx
// 带样式的h1
const Title = styled.h1`
	font-size: 1.5em;
	text-align: center;
	color: palevioletred;
`;

// 带样式的section
const Wrapper = styled.section`
	padding: 4em;
	background: papayawhip;
`;

// Title和Wrapper就是正常的React Components，该咋用就咋用！
render(
	<Wrapper>
		<Title>
			Hello World, this is my first styled component!
		</Title>
	</Wrapper>
);
```

# 传递props
styled-components可以根据props设置不同的样式，例如：
```jsx
const Button = styled.button`
  // 根据props是否用primary来设置颜色和背景颜色
	background: ${props => props.primary ? 'palevioletred' : 'white'};
	color: ${props => props.primary ? 'white' : 'palevioletred'};

	font-size: 1em;
	margin: 1em;
	padding: 0.25em 1em;
	border: 2px solid palevioletred;
	border-radius: 3px;
`;
render(
	<div>
		<Button>Normal</Button>
		<Button primary>Primary</Button>
	</div>
);
```

# 格式化任意组件
styled其实是一个函数，可以将样式绑定在任意组件上，包括自己开发的组件或者第三方库提供的组件，只要这个组件支持接收className（因为styled-components会将template string里面的内容提出来生成真正的css，然后用class名称跟css关联起来）。
```jsx
// 一个链接，可以是react-router提供的组件
const Link = ({ className, children }) => (
	<a className={className}>
		{children}
	</a>
)

// 将Link组件附着上样式
const StyledLink = styled(Link)`
	color: palevioletred;
	font-weight: bold;
`;

render(
	<div>
		<Link>Unstyled, boring Link</Link>
		<br />
		<StyledLink>Styled, exciting Link</StyledLink>
	</div>
);
```
实际上styled.h1, styled.div这些就是styled('h1'), styled('div')的缩写。

# 扩展样式
css的全称是Cascading Stylesheet，这里Cascading就是指的“继承”，也就是子元素的会继承父元素的样式，这样可以大大节省css代码量。比如我已经有一个Button组件了，并且也配置好了样式，现在我只是想要换一下颜色，其他样式（包括边框，大小，字体等）都不变，可以这样写：
```jsx
const Button = styled.button`
	color: palevioletred;
	font-size: 1em;
	margin: 1em;
	padding: 0.25em 1em;
	border: 2px solid palevioletred;
	border-radius: 3px;
`;

// 继承其他样式， 覆盖颜色
const TomatoButton = Button.extend`
	color: tomato;
	border-color: tomato;
`;

render(
	<div>
		<Button>Normal Button</Button>
		<TomatoButton>Tomato Button</TomatoButton>
	</div>
);
```

# 动画
用css制作动画需要制作keyframes，styled-components也是支持的。由于keyframes不是绑定在某个具体的component上的，所以你不能像之前那么使用。当然，你也不希望因此就把keyframes写成全局的，不然又有命名冲突的问题了。需要使用styled-components提供的keyframes方法，它会产生一个unique的名字。
```jsx
// 这会根据keyframes的内容的hash生成一个唯一的名字
const rotate360 = keyframes`
	from {
		transform: rotate(0deg);
	}

	to {
		transform: rotate(360deg);
	}
`;

// 制作一个持续2s的旋转的div
const Rotate = styled.div`
	display: inline-block;
	animation: ${rotate360} 2s linear infinite;
	padding: 2rem 1rem;
	font-size: 1.2rem;
`;

render(
	<Rotate>&lt;旋转起来。。。&gt;</Rotate>
)
```

# 支持React Native
这也是选择styled-components的一个重要原因。别忘了在RN里面不能使用div，h1，以及keyframes等哦。
```jsx
import styled from 'styled-components/native';

const StyledView = styled.View`
  background-color: papayawhip;
`;

const StyledText = styled.Text`
  color: palevioletred;
`;

class MyReactNativeComponent extends React.Component {
  render() {
    return (
      <StyledView>
        <StyledText>Hello World!</StyledText>
      </StyledView>
    )
  }
}
```

# Refers
* https://github.com/styled-components/styled-components
* https://www.styled-components.com/docs/basics
* https://www.smashingmagazine.com/2017/01/styled-components-enforcing-best-practices-component-based-systems/