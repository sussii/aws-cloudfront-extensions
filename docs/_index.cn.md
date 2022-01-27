---
title: CloudFront Extensions workshop 
chapter: true
---

# Amazon CloudFront Extensions 

Amazon CloudFront Extensions包含覆盖常用用户场景的Lambda@Edge、CloudFront Functions、CDK模版和监控工具，方便用户一站式获取CloudFront拓展功能。本方案部署操作简单，用户可点击下方表格中的Deploy按钮进行部署。

![What is CloudFrontExt](/images/what-is-cloudfrontext.png)

CloudFront Extensions包含三个部分
- 覆盖如下用户场景的Lambda@Edge和CloudFront Function，例如鉴权、预热、根据设备类型跳转、图片缩放
- CDK模块，例如WAF&Shield自动部署模版，用户通过部署此模版可为CloudFront实现DDos、爬虫、XSS、SQL注入等的防御功能
- 监控工具，通过分析CloudFront实时日志获取缓存命中率、下载速率等指标，并通过Restful API输出 [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=cloudfront-monitoring&templateURL=https://aws-gcr-solutions.s3.amazonaws.com/aws-cloudfront-extensions/v2.0.0/CloudFrontMonitoringStack.template)

#### Lambda@Edge

|    **Name**   | **Description**    | **Deployment Type** | **Deploy** |
|------------------|--------------------|----------------|----------------|
| [Authentication by Cognito](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/authentication-with-cognito) | Cognito是亚马逊的鉴权服务，当用户通过Cognito进行鉴权时，本Lambda可验证Cognito返回的token是否合法([Workshop](./deploy/deploy-auth/readme)) | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/authentication-with-cognito), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/authentication-with-cognito) |
| [Adding security header](https://github.com/awslabs/aws-cloudfront-extensions/blob/main/edge/nodejs/add-security-headers) | 在响应中增加安全标头，例如通过添加HSTS'strict-transport-security'强制浏览器使用HTTPS，添加'x-frame-options'预防点击劫持 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/add-security-headers), SAM |  [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/add-security-headers) |
| [Serving Content Based on Device Type](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/serving-based-on-device) | 根据设备类型跳转到相应链接 ([Workshop](./deploy/deploy-device/readme))  | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/serving-based-on-device), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/serving-based-on-device) |
| [Cross Origin Resource Sharing](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/cross-origin-resource-sharing) | 在响应中添加CORS(Cross Origin Resource Sharing)标头，例如'access-control-allow-origin'、'access-control-allow-headers' | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/cross-origin-resource-sharing), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/cross-origin-resource-sharing) |
| [Modify response status code](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/modify-response-status-code)  | 修改响应的状态码，例如将状态码从500修改为200 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/modify-response-status-code), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/modify-response-status-code) |
| [Modify response header](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/modify-response-header) | 修改响应的标头 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/modify-response-header), SAM, [CDK](https://github.com/pahud/cdk-cloudfront-plus/tree/main/src/demo/modify-response-header) | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/modify-response-header) |
| [Access origin by weight rate](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/access-origin-by-weight-rate) | 根据提供的权重访问源站服务器，例如有两个源站服务器，权重分别是1和2，则会按照此权重比例进行回源 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/access-origin-by-weight-rate), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/access-origin-by-weight-rate) |
| [Failover to alternative origin](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/multiple-origin-IP-retry) | 用户可提供一个源站服务器列表，当列表中的第一个源站服务器不可用时，自动切换到下一个，直到找到可用源站并发起请求 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/multiple-origin-IP-retry), SAM, [CDK](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/multiple-origin-IP-retry) | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/multiple-origin-IP-retry) |
| [Support 302 from origin](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/http302-from-origin) | 当收到302状态码时，直接请求相应的源站，而不需要返回给客户端进行302跳转 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/http302-from-origin), SAM, [CDK](https://github.com/pahud/cdk-cloudfront-plus/issues/12) | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/http302-from-origin) |
| [Pre-warm](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/python/prewarm) | 用户可指定区域进行预热，例如将100个url在美国东部进行预热 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/prewarm), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/prewarm) |
| [Resize picture](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/resize-picture) | 根据提供的宽和高缩放图片，并将缩放后的图片保存到S3，提高下次相同请求的效率 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/resize-picture), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/resize-picture) |
| [Anti-hotlinking](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/anti-hotlinking) | 只允许referer白名单中的请求访问资源，从而达到防盗链的目的。目前白名单支持'*'、'?'等通配符。例如只允许referer是www.example.com的请求访问网站的图片 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/anti-hotlinking), SAM, [CDK](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/anti-hotlinking) | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/anti-hotlinking) |
| [Standardize query string](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/normalize-query-string) | 标准化query string从而CHR(提高缓存命中率)，此Lambda会将query string转为小写字母并按照升序排列。例如原url是www.example.com/index.html?B=1&a=2，标准化后会变为www.example.com/index.html?a=2&b=1，详情可参考[链接](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cache-hit-ratio.html#cache-hit-ratio-query-string-parameters) | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/normalize-query-string), SAM, [CDK](https://github.com/pahud/cdk-cloudfront-plus/pull/64) | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/normalize-query-string) |
| [OAuth2 Authentication](https://github.com/pahud/cdk-cloudfront-plus/issues/17) | 通过OAuth2进行鉴权 | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Authentication with AliYun](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/authentication-with-aliyun-cdn-typeA) | 由Goclouds提供，实现基于阿里云的鉴权 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/authentication-with-aliyun-cdn-typeA), SAM |  [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/authentication-with-aliyun-cdn-typeA) |
| [Default Directory Index for Amazon S3 Origin](https://github.com/pahud/cdk-cloudfront-plus/issues/9) |  为CloudFront的链接增加默认的结尾，例如为所有以'/'结尾的url增加example.html[Use case](https://aws.amazon.com/tw/blogs/compute/implementing-default-directory-indexes-in-amazon-s3-backed-amazon-cloudfront-origins-using-lambdaedge/) | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Rewrite host for Custom Origin](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/rewrite-url) | 当CloudFront的源站是自定义源站时，此Lambda可以重写请求中的host字段，从而实现重定向到其他源站的功能 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/rewrite-url) |  [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/rewrite-url) |
| [Redirect URL by Geolocation](https://github.com/pahud/cdk-cloudfront-plus/issues/11) | 根据地理位置，请求相应的源站服务器，此Lambda会返回302到客户端，然后由客户端再次发起请求。详情请参考[链接](https://aws.amazon.com/tw/blogs/networking-and-content-delivery/dynamically-route-viewer-requests-to-any-origin-using-lambdaedge/) | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Convert query string](https://github.com/pahud/cdk-cloudfront-plus/issues/23) | 将query string中的字段添加到header中，可用于将长url转成短url | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Serverless load balancer](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/python/serverless-load-balancer) | 通过Lambda@Edge实现负载均衡功能，负载会在Dynamodb表格中记录 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/serverless-load-balancer), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/serverless-load-balancer) |
| [Access origin by geolocation](https://github.com/pahud/cdk-cloudfront-plus/issues/41) | 根据地理位置，直接请求相应的源站服务器，不需要返回客户端进行302跳转 | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Custom Error Page](https://github.com/pahud/cdk-cloudfront-plus/pull/46) | 自定义错误页面和响应状态码[Use case](https://aws.amazon.com/blogs/networking-and-content-delivery/customize-403-error-pages-from-amazon-cloudfront-origin-with-lambdaedge/) | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Global Data Ingestion](https://github.com/pahud/cdk-cloudfront-plus/issues/14) | 将日志输出到Amazon Kinesis Firehose[Use case](https://aws.amazon.com/tw/blogs/networking-and-content-delivery/global-data-ingestion-with-amazon-cloudfront-and-lambdaedge/) | [CDK](https://www.npmjs.com/package/cdk-cloudfront-plus) | - |
| [Custom Response with New URL](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/edge/nodejs/custom-response-with-replaced-url) | 将响应中的body内容替换为自定义内容。例如响应返回的是个html，此Lambda可以将html中的所有'www.original.com'内容替换'www.new.com'，用户可通过此Lambda实现只维护一个S3桶，即可让两个不同的域名进行访问 | [SAR](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/custom-response-with-replaced-url), SAM | [![部署](/images/deploy_button.png)](https://serverlessrepo.aws.amazon.com/applications/us-east-1/418289889111/custom-response-with-replaced-url) |


#### CloudFront Function
|    **Name**   | **Description**    | **Deploy** |
|------------------|--------------------|----------------|
| [Add Security Headers](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/add-security-headers) | 在响应中增加安全标头，例如通过添加HSTS'strict-transport-security'强制浏览器使用HTTPS，添加'x-frame-options'预防点击劫持 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=add-security-headers&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fadd-security-headers.yaml) |
| [Cross Origin Resource Sharing](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/cross-origin-resource-sharing) | 在响应中添加CORS(Cross Origin Resource Sharing)标头，例如'access-control-allow-origin'、'access-control-allow-headers'  | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=cross-origin-resource-sharing&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fcross-origin-resource-sharing.yaml) |
| [Add Cache Control Headers](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/add-cache-control-header) | 添加Cache-Control标头，从而允许浏览器本地缓存 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=add-cache-control-header&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fadd-cache-control-header.yaml) |
| [Add Origin Headers](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/add-origin-header) | 添加Origin标头 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=add-origin-header&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fadd-origin-header.yaml) |
| [Add True Client IP Headers](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/add-true-client-ip-header) | 添加True-Client-IP标头，此标头是真正最终连接CloudFront的客户端的IP。如果没有此标头，由CloudFront到源站服务器的连接（即源请求Origin request）只会包含CloudFront服务器的IP地址，而不是用户的客户端的IP地址 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=add-true-client-ip-header&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fadd-true-client-ip-header.yaml) |
| [Redirect Based on Country](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/redirect-based-on-country) | 根据用户所在地区返回相应的内容 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=redirect-based-on-country&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fredirect-based-on-country.yaml) |
| [Default Dir Index](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/default-dir-index) | 为CloudFront的链接增加默认的结尾，例如为所有以'/'结尾的url增加index.html| [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=default-dir-index&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fdefault-dir-index.yaml) |
| [Verify Json Web Token](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/verify-jwt) | 验证query string中的JSON Web Token (JWT)，一般用于鉴权场景 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=verify-jwt&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fverify-jwt.yaml) |
| [Verify Token in URL](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/verify-jwt) | 根据时间戳、路径等验证URL中的Token是否有效，一般用于鉴权场景 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=verify-jwt-uri&templateURL=https://aws-cloudfront-extensions-cff.s3.amazonaws.com/verify-jwt-uri.yaml) |
| [Customize Request Host](https://github.com/awslabs/aws-cloudfront-extensions/tree/main/function/js/custom-host) | 将host替换为自定义的标头的内容，例如用户可自定义一个标头awscustomhost，最终host会被替换为此标头的内容 | [![部署](/images/deploy_button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=custom-host&templateURL=https:%2F%2Faws-cloudfront-extensions-cff.s3.amazonaws.com%2Fcustom-host.yaml) |
