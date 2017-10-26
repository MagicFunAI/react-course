# map/filter/reduce

这三个函数其实是函数式编程里面最基础的三个函数，早就有[Underscore](http://underscorejs.org/)或者[Lodash](https://lodash.com/)支持了，后来ES5里javascript在数组上内置了这两个函数。 当然，自己实现这几个函数也是分分钟的事。

当然，我们还是先来看看为什么要用这三个函数呢？

# map

假设有一个数组`arr = [1, 2, 3, 4, 5]`，现在有个需求是让你得到一个新数组，每个元素是在`arr`基础上`+1`， 怎么做呢？
```js
const arr = [1, 2, 3, 4, 5];

let arr2 = [];
for (let i = 0; i < arr.length; i += 1) {
  arr2.push(arr[i] + 1);
}
console.log(arr2);// [2, 3, 4, 5, 6]
```
写程序唯一不变的就是需求经常变！ ok， 现在需求变成获得一个新数组，每个元素是`arr`基础上`*2`，怎么做呢？ So easy！
```js
let arr3 = [];
for (let i = 0; i < arr.length; i += 1) {
  arr3.push(arr[i] * 2);
}
console.log(arr3);// [2, 4, 6, 8, 10]
```
写程序唯一不变的就是需求经常变！ ok， 现在需求变成获得一个新数组，每个元素是`arr`基础上`*3`，怎么做呢？ So easy！滚！

我们仔细看一下， 上面两段代码都是先定义一个新的空数组，然后`for`循环遍历`arr`，然后对每个元素做一些转化，放到新数组里，最后返回新数组。 其实真正不一样的只有对数组元素转化那很小一部分代码， 那我们是否可以把不变的固定下来， 每次只写变化的那一小部分代码呢？ Yes！我们来定义一个函数`map`：
```js
function map(arr, f) {
  let arr3 = [];
  for (let i = 0; i < arr.length; i += 1) {
    arr3.push(f(arr[i]));
  }
  return arr3;
}
```
函数完成了刚刚说的重复的工作，包括新建空数组，`for`循环遍历元素， 将转化过的元素放入新数组， 返回新数组。 而不同的部分：对每个数组元素进行转化，通过函数`f`传递给`map`函数。 于是第一个需求我们可以改写成：
```js
const arr4 = map(arr, e => e + 1)
console.log(arr4)
```
第二个需求：
```js
const arr5 = map(arr, e => e * 2)
console.log(arr5)
```
第三个需求：
```js
const arr5 = map(arr, e => e * 3)
console.log(arr5)
```
终于可以早点下班陪妹纸逛街了。。。。

# filter
需求1：找出`arr`中的奇数。
```js
let arr6 = [];
for (let i = 0; i < arr.length; i += 1) {
  if (arr[i] % 2 === 1) {
    arr6.push(arr[i]);
  }
}
console.log(arr6);//[1, 3, 5]
```
需求2：找出`arr`中的偶数。O__O "…， 好吧。。。
```js
let arr7 = [];
for (let i = 0; i < arr.length; i += 1) {
  if (arr[i] % 2 === 0) {
    arr7.push(arr[i]);
  }
}
console.log(arr7);//[2, 4]
```
需求3：找出`arr`中大于3的数。O__O "…， 滚！

同样我们也发现大部分代码都是一样的， 除了判断是否该加入新数组的那个`if`判断， 所以我们提取出如下函数：
```js
function filter(arr, f) {
  let newArr = [];
  for (let i = 0; i < arr.length; i += 1) {
    if (f(arr[i])) {
      newArr.push(arr[i]);
    }
  }
  return newArr;
}
```
然后需求1：
```js
const arr2 = filter(arr, e => e % 2 === 1);
```
然后需求2：
```js
const arr3 = filter(arr, e => e % 2 === 0);
```
然后需求3：
```js
const arr4 = filter(arr, e => e > 2);
```

# reduce
需求1：求`arr`所有元素的和
```js
let sum = 0;
for (let i = 0 ; i < arr.length; i += 1) {
  sum = sum + arr[i];
}
console.log(sum);//15
```
需求2：求`arr`所有元素的积
```js
let sum = 1;
for (let i = 0 ; i < arr.length; i += 1) {
  sum = sum * arr[i];
}
console.log(sum);//120
```
需求3：滚！。。。。。
我们来提取一个新函数`reduce`：
```js
function reduce(arr, a, f) {
  let result = a;
  for (let i = 0 ; i < arr.length; i += 1) {
    result = f(result, arr[i]);
  }
  return result;
}
```
于是， 需求1：
```js
const r1 = reduce(arr, 0, (a, b) => a + b)
```
于是， 需求2：
```js
const r2 = reduce(arr, 1, (a, b) => a * b)
```

# Array.map / Array.filter / Array.reduce
上面我们解释了为什么会有map/filter/reduce这三个函数：无非就是为了少写点代码，早点下班陪妹纸逛街。。。

Javascript语言的设计者作为程序员当然也体量各位程序员的辛苦，于是干脆内置了这三个函数，于是前面的需求分别一行代码就可以搞定：
```js
const arr1 = arr.map(e => e + 1);
const arr2 = arr.map(e => e * 2);
const arr3 = arr.map(e => e * 3);
const arr4 = arr.filter(e => e % 2 === 1);
const arr5 = arr.filter(e => e % 2 === 0);
const arr6 = arr.filter(e => e > 2);
const r1 = arr.reduce((acc, e) => acc + e, 0);
const r2 = arr.reduce((acc, e) => acc * e, 1);
```
注意我定义的`reduce`函数跟内置的`Array.reduce`函数两个参数顺序是反的哈。

下班！


# 作业
给定一个数组，求数组里面奇数的平方和。比如`arr`， 则答案应该是`1*1 + 3*3 + 5*5 => 35`。 