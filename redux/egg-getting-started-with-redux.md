# egg-getting-started-with-redux

# 三原则
## Store
Single Immutable State Tree

## Actions
action只是简单的JS Object， 必须包含一个key：`type`， 可以序列化。

## Reducer
Pure Function, 
```
reducer = (previousState, action) => nextState
```
**Pure vs Impure**
```js
function squareAll(items) {
  return items.map(square);
}
```
```js
function squareAll(items) {
  for (let i = 0; i < items.length; i++) {
    items[i] = square(items[i]);
  }
}
```
**UI = PureFunction(state)**

# 创建Store 
```js
const counter = (state = 0, action) => {
  switch (action.type) {
    case 'INCREMENT':
      return state + 1;
    case 'DECREMENT':
      return state - 1;
    default:
      return state;
  }
}
```
```js
import { createStore } from 'redux' // npm module syntax

const store = createStore(counter);

    this.store.subscribe(() => {
      console.log(this.store.getState());
      this.setState({
        value: this.store.getState(),
      })
    })
```

# 自己实现createStore
```js
const createStore = (reducer) => {
  let state;
  let listeners = [];

  const getState = () => state;

  const dispatch = (action) => {
    state = reducer(state, action);
    listeners.forEach(listener => listener());
  };

  const subscribe = (listener) => {
    listeners.push(listener);
    return () => {
      listeners = listeners.filter(l => l !== listener);
    }
  };

  // dispatch({}); // dummy dispatch

  return { getState, dispatch, subscribe };

};
```

# 修改数组返回新的数组
```js
const addCounter = (list) => {
  // return list.concat([0]); // old way
  return [...list, 0]; // ES6 way
};
```
```js
const incrementCounter = (list, index) => {
  // Old way:
  // return list
  //  .slice(0, index)
  //  .concat([list[index] + 1])
  //  .concat(list.slice(index + 1));

  // ES6 way:
  return [
    ...list.slice(0, index),
    list[index] + 1,
    ...list.slice(index + 1)
  ];
};
```

# 修改对象返回新的对象
```js
return Object.assign({}, todo, {
    completed: !todo.completed
  });
```
```js
return {
    ...todo,
      completed: !todo.completed
  };
```

# Reducer Composition with Arrays
一个小的`reducer`处理每一个元素， 然后大的`reducer`去调用。
> Since reducers are normal JS functions, they can call other reducers to delegate & abstract away updates to the state.

> Reducer composition can be applied many times. While there's a single top-level reducer managing the overall state of the app, it's encouraged to have reducers call each other as needed to manage the state tree.

# Reducer Composition with Objects
> To store this new information, we don't need to change the existing reducers.
> We will use reducer composition to create a new reducer that calls existing reducers to manage their parts of the state, then combine the parts into a single state object.

```js
const todoApp = (state = {}, action) => {
  return {
     // Call the `todos()` reducer from last section
     todos: todos(
      state.todos, // 第一次的时候undefined， 刚好从子reducer里获取到默认值
      action
    ),
    visibilityFilter: visibilityFilter(
      state.visibilityFilter,
      action
    )
  };
};
```

# combineReducers
reducer composition太常用了，所以提供一个工具函数。
```js
const todoApp = combineReducers({
  todos: todos,
  visibilityFilter: visibilityFilter
});
```
> By convention, the state keys should be named after the reducers that manage them.

可以用ES6语法更简洁:
```js
const todoApp = combineReducers({
  todos,
  visibilityFilter
});
```
## 自己实现combineReducers
```js
const combineReducers = reducers => {
  return (state = {}, action) => {

    // Reduce all the keys for reducers from `todos` and `visibilityFilter`
    return Object.keys(reducers).reduce(
      (nextState, key) => {
        // Call the corresponding reducer function for a given key
        nextState[key] = reducers[key] (
          state[key],
          action
        );
        return nextState;
      },
      {} // The `reduce` on our keys gradually fills this empty object until it is returned.
    );
  };
};
```

# Example: TodoList
## Adding a Todo
## Toggling a Todo
## Filtering Todos
## Refactor
### Extracting Presentational Components
* Todo
* TodoList
> One of the downsides to having separate presentational components is that we have to move around a lot of props, including the callbacks. However, we can easily solve this problem by introducing many intermediate container components.

### Extracting Container Components
* FilterLink
* VisibleTodoList
* AddTodo
### Passing Store
* Explicitly via Props
* Implicitly via Context
* <Provider>
### Generating Containers with connect() from React Redux
* VisibleTodoList
* AddTodo
* FooterLink
### Extracting Action Creators
