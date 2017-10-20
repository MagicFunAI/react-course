# 代码检查

代码检查包括代码规范[Airbnb](https://github.com/airbnb/javascript)，以及检查是否符合规范的工具如[ESLint](https://github.com/eslint/eslint)等。

另外，随着项目越来越大，动态语言的劣势逐渐暴露出来，包括没有编译器检查错误，代码提示不够强大， 重构代码不便等，于是大公司（一般都是有巨大的js代码量）开发了一些静态类型检查工具比如Facebook开发的[Flow][Flow]， 甚至是新的语言比如微软开发的[Typescript][TS]。

当然，将其他静态语言或动态语言编译为js的有很多，可以看这个列表： https://github.com/jashkenas/coffeescript/wiki/list-of-languages-that-compile-to-js 。 当然，我的建议是， 除非你有特殊原因比如强烈的语言偏好， 否则最好还是就在[Flow][Flow]和[Typescript][TS]之间选一个好了。

[Flow]: https://flow.org/
[TS]: https://www.typescriptlang.org/