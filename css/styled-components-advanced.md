# 主题
styled-components提供`<ThemeProvider>`来支持主题模式，底层实现是用React的context API。只要是被`<ThemeProvider>`包起来的组件，不管多深，都可以通过props访问到theme。
```jsx
// 使用props.theme获取到主题
const Button = styled.button`
	font-size: 1em;
	margin: 1em;
	padding: 0.25em 1em;
	border-radius: 3px;

	/* 根据theme.main来设置文本和边框的颜色
	color: ${props => props.theme.main};
	border: 2px solid ${props => props.theme.main};
`;

// 默认主题
Button.defaultProps = {
	theme: {
		main: 'palevioletred'
	}
}

// 设计新的主题
const theme = {
	main: 'mediumseagreen'
};

render(
	<div>
		<Button>Normal</Button>

		<ThemeProvider theme={theme}>
			<Button>Themed</Button>
		</ThemeProvider>
	</div>
);
```

# Refs
用ref只能获取到一个StyledComponent，因为styled-component是在原来的组件上包装了一层。要想获取到底层的DOM（比如为了调用focus方法），需要使用innerRef。
```jsx
const Input = styled.input`
	padding: 0.5em;
	margin: 0.5em;
	color: palevioletred;
	background: papayawhip;
	border: none;
	border-radius: 3px;
`;

const Form = () => (
	<Input
		placeholder="Hover here..."
		innerRef={x => this.input = x}
		onMouseEnter={() => this.input.focus()}
	/>
);

render(
	<Form />
);
```

# 安全性
由于styled-components能使用任意js作为插值，要小心用户的恶意输入，造成XSS。
```jsx
// 用户输入的可能是恶意接口，比如撤销转账
const userInput = '/api/withdraw-funds';

const ArbitraryComponent = styled.div`
  background: url(${userInput});
  /* More styles here... */
`;
```

# 对普通组件做样式化
styled-components的实现原理是生成实际的带class的css，然后把class通过className绑定到具体的DOM节点上，然后在运行的时候把实际生成的css加到html文档的head节点后面。

所以，如果你用styled(MyComponent)准备渲染MyComponent，而MyComponent并不渲染className，那就什么样式都不会出现咯！为了避免这个问题，需要将传入的className渲染到DOM节点上去。
```jsx
const MyComponent = (props) => <div className={props.className}>...</div>
```
如果你之前已经有className了， 那么可以把两者合并起来。
```jsx
const MyComponent = (props) => <div className=`your-global-class {props.className}`>...</div>
```

如果把全局的class跟styled-component混起来用，很可能得到莫名其妙的结果。主要问题来自于css的优先级，如果你忘了什么是css的优先级，请看[这里](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Specificity)。如果两个优先级相同，那么后者胜出。看下面代码：
```jsx
// MyComponent.js
const MyComponent = styled.div`background-color: green;`;

// my-component.css
.red-bg {
  background-color: red;
}

// For some reason this component still has a green background,
// even though you're trying to override it with the "red-bg" class!
<MyComponent className="red-bg" />
```
你可能会认为.red-bg会胜出所以显示红色，因为red-bg这个className在后面，结果却显示绿色，原因是styled-components是在运行的时候动态把生成的css注入到head后面的DOM节点，所以其实它在后面。

很难控制生成的css的插入位置的，所以还不如直接提升全局class的优先级，方法就是重复class名称。
```css
/* my-component.css */
.red-bg.red-bg {
  background-color: red;
}
```

# Media Templates
如果要开发响应式web页面，则media query是不可或缺的工具。方法也很简单，就直接用css的media query咯：
```jsx
const Content = styled.div`
	background: red;
	height: 3em;
	width: 3em;

	@media (max-width: 700px) {
		background: green;
	}
`;

render(
	<Content />
);
```
media query一般长而重复，所以我们可以写个模板方法。由于js的强大功能，你很容易就可以在media query里面写自定义的tagged template literal。
```jsx
const sizes = {
	desktop: 992,
	tablet: 768,
	phone: 376
}

// Iterate through the sizes and create a media template
const media = Object.keys(sizes).reduce((acc, label) => {
	acc[label] = (...args) => css`
		@media (max-width: ${sizes[label] / 16}em) {
			${css(...args)}
		}
	`
	return acc
}, {})
// 上面代码看不懂的，建议看看函数式编程和reduce的作用，上述代码等价于
const media = {};
for(let label of Object.keys(sizes)) {
	media[label] = (...args) => css`
		@media (max-width: ${sizes[label] / 16}em) {
			${css(...args)}
		}
	`
}

const Content = styled.div`
	height: 3em;
	width: 3em;
	background: papayawhip;

	/* Now we have our methods on media and can use them instead of raw queries */
	${media.desktop`background: dodgerblue;`}
	${media.tablet`background: mediumseagreen;`}
	${media.phone`background: palevioletred;`}
`;

render(
	<Content />
);
```

# Tagged Template Literals
参见[styled-components设计原理](styled-components-how.html)。

# 服务端渲染
参见[官网文档](https://www.styled-components.com/docs/advanced#server-side-rendering)。


# Rerfers
* https://www.styled-components.com/docs/advanced