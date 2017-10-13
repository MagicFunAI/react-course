# history


Router的实现原理无非就是实现当URL变化的时候渲染的组件跟着变化。 要实现这个功能，就需要监听URL的变化，有两种方式可以实现，一是通过`onhashchange`监听`#`的变化，一是用`history`的新的API，包括`pushState()`, `replaceState()`, `popstate`等。具体实现细节我们暂时不讲， 有兴趣的可以看看下面几篇资料。

# Refers
* http://www.ruanyifeng.com/blog/2011/03/url_hash.html
* https://developer.mozilla.org/en-US/docs/Web/API/History_API
* https://code.tutsplus.com/tutorials/an-introduction-to-the-html5-history-api--cms-22160
* http://blog.httpwatch.com/2011/03/01/6-things-you-should-know-about-fragment-urls/