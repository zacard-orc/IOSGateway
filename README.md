# IOSGateway
```text
在 https://github.com/Q14/QJRouter 基础上增加了若干功能，实现不同逻辑的分层和路由。
基于runtime和约定进行了修改。
按atom、basic、component、scene进行了分层

这仅仅是一个play demo参考，如需生产请加入更多robust。

Attention！！
It's only a play demo, you should add more robust when used in production!!
```

<img src="https://s3.ax1x.com/2021/01/25/sq0B2n.jpg" width="30%"/>

## Feature
- 🎉  按约定对atom、basic、component、scene进行了分层
- 🎉  基于官方Runtime、C99。无hack语法
- 🎉  基于url schema约定/${layer}/${Class}/${Method}来实现业务调用
- 🎉  增加了对block的支持
- 🎉  增加了对invocation的支持
- 🎉  增加了对multi withObject的支持
- 🎉  收敛网关，暴露相关api，以便支持审计、限流、打点等能力

## Version 1.2.0


## How to use

### register
```objective-c
#import "xxxxxxx"

QJRouter.sharedInstance.atomArray = @[
NSStringFromClass([Imei class]),
NSStringFromClass([OpsTime class])
];

QJRouter.sharedInstance.basicArray = @[
NSStringFromClass([UserInfo class]),
];
```

### use normal
```objective-c
NSString *imei = [QJRouter.sharedInstance
    post:@"qj://atom/Imei/getImei"
    withParam:[NSNumber numberWithInteger:1]
    useCb:nil
    useCache:FALSE
    ];
NSLog(@"ret imei = %@",imei);
[self alert:imei];
```

### use block
```objective-c
[QJRouter.sharedInstance
 post:@"qj://basic/UserInfo/getName"
 withParam:@"Tom"
 useCb:(__bridge id)(__bridge void*)^(NSString *name){
     NSLog(@"cb ret = %@", name);
     [self alert:name];
 }
 useCache:TRUE
 ];
 ```
 
 ### use vc
 ```objective-c
 id vc = [QJRouter.sharedInstance
          post:@"qj://scene/ItemListVC/initvc"
          withParam:nil
          useCb:nil
          useCache:TRUE
          ];
 NSLog(@"vc class %@",NSStringFromClass([vc class]));
 [self.navigationController pushViewController:vc animated:YES];
  ```
