# 部署

## 打包
`npm run build`

## 本地启静态服务器
* [serve](https://github.com/zeit/serve)，默认支持404跳转到index.html
* [http-server](https://github.com/indexzero/http-server)
* [live-server](https://github.com/tapio/live-server)， 可以配置404跳转页面

## 跨域
### Same-origin policy
* https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy
* http://www.ruanyifeng.com/blog/2016/04/same-origin-policy.html
### CORS
* https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS
* http://www.ruanyifeng.com/blog/2016/04/cors.html
* https://www.slideshare.net/vladimirdzhuvinov/crossdomain-requests-with-cors

## Ajax请求
* https://github.com/camsong/blog/issues/2
* https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API

## 部署CDN
* Cache
* HTTPS & HTTP2
* http://7xp1wl.com1.z0.glb.clouddn.com/fe-develop-build-deploy/fe.htm

## 相对目录
```js
// package.json
"homepage": ".",

"homepage": "http://static.magicfun.ai/test/",
```

https://github.com/facebookincubator/create-react-app/pull/937
> With this PR the %PUBLIC_URL% in static assets and the output.publicPath variable set in webpack configs follow the following behavior:

> "homepage" specified in package.json, PUBLIC_URL not set: only the pathname is used from "homepage" (as it is right now);

> PUBLIC_URL set, "homepage" might be set: the full url specified in the env variable is used

https://github.com/facebookincubator/create-react-app/blob/master/packages/react-scripts/template/README.md#advanced-configuration

```bash
PUBLIC_URL=http://static.magicfun.ai/test/ npm run build
```