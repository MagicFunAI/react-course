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


# 使用阿里云OSS和CDN
1. 开通OSS: https://www.aliyun.com/product/oss 和CDN: https://www.aliyun.com/product/cdn

2. CDN的回源地址配置成OSS。

3. 配置CDN的域名， 建议开启HTTPS

4. 开通访问控制https://www.aliyun.com/product/ram?spm=5176.product31815.765261.380.OHCIzI
 给每个员工开通上传特定OSS bucket的权限https://help.aliyun.com/document_detail/61950.html?spm=5176.doc31893.6.914.DFo6hr ， 员工通过OSS客户端工具： https://help.aliyun.com/document_detail/44075.html?spm=5176.product31815.6.1026.OHCIzI 登录， 然后直接把打包好的静态资源文件拖放上传到某个目录。  然后用cdn的地址访问静态资源即可。  


图片支持裁剪功能， 可以根据需要加载不同尺寸的图片https://help.aliyun.com/document_detail/44686.html?spm=5176.doc61950.6.944.ApX9RV

如果有需要用户上传图片的功能，建议采用OSS直传功能：
* https://help.aliyun.com/document_detail/31926.html?spm=5176.doc31927.6.632.olPlaQ
* https://help.aliyun.com/document_detail/31920.html?spm=5176.doc31926.6.626.bCwgsq


# REST接口设计
可以用http://rapapi.org/org/index.do 来管理接口。

接口设计需要注明的几点：
* URL
* http method
* request headers， 包括`Content-Type`, 是否需要带`cookie`等
* request参数，包括字段名称， 字段类型， 字段含义和具体的描述信息等。
* response headers，包括`Content-Type`, `CORS`头部等
* repsonse参数，包括字段名称， 字段类型， 字段含义和具体的描述信息等。 **注意，要包含正确和错误两种情况！**
