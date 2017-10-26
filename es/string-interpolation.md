# 字符串插值(String interpolation or Template literals)

字符串是最常用的一种数据类型，我们经常做的一件事就是拼接字符串。比如：
```js
const name = 'magicly';
const age = 25;
const tel = 18600000000
console.log('my name is: ' + name + ', and age is: ' + age + ', and tel is: ' + tel + '.');
```
你会看到一个字符串被打断成了很多片段，然后用`+`拼接起来，阅读起来很不方便，尤其是拼接的内容是对象的属性的时候。比如：
```js
const me = {
  name: 'magicly',
  age: 25,
  tel: 18600000000,
}
console.log('my name is: ' + me.name + ', and age is: ' + me.age + ', and tel is: ' + me.tel + '.');
```
ES6里提供了字符串插值（又叫模板字符串），可以很方便的写成：
```js
const me = {
  name: 'magicly',
  age: 25,
  tel: 18600000000,
}
console.log(`my name is: ${me.name}, and age is: ${me.age}, and tel is: ${me.tel}.`);
```
用到是反引号，然后可以在里面用`${}`包任何的js表达式。

字符创插值还要另一个用处，就是`Tagged Template Literals`，我们后面讲解[`Styled Components`设计原理](../css/styled-components-how.html)的时候会讲到。