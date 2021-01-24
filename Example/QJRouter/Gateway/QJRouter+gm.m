//
//  GMRouter+gm.m
//  GMRouter
//
//  Created by Q14 on 2019/11/28.
//

#import "QJRouter+gm.h"
#import "QJCommon.h"
#import <objc/message.h>

//nsstring
static inline BOOL verifiedString(id strlike) {
    if (strlike && ![strlike isEqual:[NSNull null]] && [[strlike class] isSubclassOfClass:[NSString class]] && ((NSString*)strlike).length > 0) {
        return YES;
    }else{
        return NO;
    }
}

NSString *const GMRouterActionPrefix = @"Action_";
NSString *const GMRouterActionSuffix = @":";
NSString *const GMRouterTargetPrefix = @"Target_";


//NSString *const GMRouterTargetA = @"Target_A";
//NSString *const GMRouterTargetB = @"Target_B";

static NSMutableDictionary *routeMap = nil;

@implementation QJRouter (gm)

- (void)initializeRouteMap:(NSArray*)arr {
    if (routeMap==nil) {
        routeMap = [[NSMutableDictionary alloc] initWithCapacity:50];
    }
//    NSArray *arr = self.atomArray;
    if (!arr) {
        NSLog(@"error array");
        return;
    }
    for (NSString *clsStr in arr) {
        NSDictionary *dict = [self getMethods:clsStr];
        [routeMap addEntriesFromDictionary:dict];
    }
    
//    NSArray *arr2 = self.basicArray;
//    if (!arr2) {
//        NSLog(@"error basic array");
//        return;
//    }
//    for (NSString *clsStr in self.basicArray) {
//        NSDictionary *dict = [self getMethods:clsStr];
//        [routeMap addEntriesFromDictionary:dict];
//    }
    
    
    
}


#pragma mark - 获取类的所有方法
// 获取所有的方法
- (NSDictionary *)getMethods:(NSString *)clsStr {
    Class cls = NSClassFromString(clsStr);
    NSRange range = [clsStr rangeOfString:@"Target_"];
    NSString *targetValue =  [clsStr substringFromIndex:range.length];
    
//    NSAssert(targetValue.length != 0, @"Target_后不能为空！请注意Target");
    
    unsigned int count = 0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 获取类的所有 Method
    Method *methods = class_copyMethodList([cls class], &count);
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        // 获取方法 Name
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        

        
        //        dict[[NSString stringWithUTF8String:methodName]] = targetValue;
        
        NSString *fullName = [NSString stringWithUTF8String:methodName];
        NSString *boneName = fullName;
        
        
        //获取到的是这样的 pushToHospitalDetail: 因此要去掉：
        NSString *rangeStr = @":";
        if ([fullName containsString:rangeStr]) {
            NSRange range = [fullName rangeOfString:rangeStr];
            boneName = [fullName substringToIndex:range.location];
        }
        
        if(boneMap==nil){
            boneMap =  [[NSMutableDictionary alloc] init];
        }
        //        self.boneMap[boneName]=fullName;
        [boneMap setValue:fullName forKey:
         [NSString stringWithFormat:@"%@/%@",clsStr,boneName]
         ];
        
        self.boneMap = boneMap;
        NSLog(@"%@",self.boneMap);
        
        NSString *cbStr = @"useCb";
        if ([fullName containsString:cbStr]) {
            NSLog(@"reg[callback]: %@ => %@",clsStr, boneName);
        } else{
            NSLog(@"reg: %@ => %@",clsStr, boneName);
        }
        
        // 获取方法的参数列表
//        int arguments = method_getNumberOfArguments(methods[i]);
        
        
        
        //        NSString *promoteStr = [NSString stringWithFormat:@"%@-内有重复的方法名-%@", clsStr, name];
        //        NSAssert(![dict.allKeys containsObject:name], promoteStr);
        
        //因为消息发送的时候会有两个默认的参数（消息接受者和方法名），所以需要减去2
        //        NSLog(@"reg: %@ => %@",clsStr, name);
        dict[boneName] = targetValue;
    }
    
    free(methods);
    return dict;
}



- (id)performAction:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    NSString *selName = @"createVC:";
    NSString *sel = [routeMap objectForKey:actionName];
    if (verifiedString(sel)) selName = sel;
    
    return [self performAction:actionName dstSel:selName params:params shouldCacheTarget:shouldCacheTarget];
}

- (id)performAction:(NSString *)actionName dstSel:(NSString *)dstSelName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    return nil;
    //    Class class = NSClassFromString(actionName);
    //    SEL sel = NSSelectorFromString(dstSelName);
    //    IMP imp = [class instanceMethodForSelector:sel];
    //    if (!imp || imp == _objc_msgForward) {
    //        imp = [class methodForSelector:sel];
    //    }
    //    SEL selector = NSSelectorFromString(enActionFuncName(actionName));
    //
    //    Class targetCls = NSClassFromString([NSString stringWithFormat:@"%@%@",GMRouterTargetPrefix,GMRouterTargetCommons]);
    //
    //    if (!class_respondsToSelector(targetCls, selector)) {
    //        BOOL flag = class_addMethod(targetCls, selector, imp, "@@:@");
    //        if (!flag) {
    //            return nil;
    //        }
    //    }
    //
    //    id action = [self performTarget:GMRouterTargetCommons action:actionName params:params shouldCacheTarget:shouldCacheTarget];
    //    if (![action isKindOfClass:class]) {
    //
    //        Class class = NSClassFromString(@"ErrorViewController");
    //        UIViewController *vc = [[class alloc] init];
    //        return vc;
    //    }else {
    //        return [action isKindOfClass:class] ? action : nil;
    //    }
}

- (id)pushScheme:(NSString *)urlScheme {
    //    NSString *encodeUrlScheme = [self URLEncodeString:urlScheme];
    //    NSURL *url = [NSURL URLWithString:encodeUrlScheme];
    //    if (!url) {
    //        //        debugLog(@"协议出错了!");
    //    }
    //    NSString *host = url.host;
    //    NSString *targetName = [routeMap objectForKey:host];
    //    NSDictionary *params = [self getParams:encodeUrlScheme withHost:host];
    //
    //    host = [self getHostWithEncodeUrlScheme:encodeUrlScheme host:host];
    //    id vc = [self performTarget:targetName action:host params:params shouldCacheTarget:NO];
    //    return vc;
    return nil;
}


- (id)post:(NSString *)urlScheme withParam:(nullable id)params useCb:(nullable id)callback
   useCache:(BOOL)shouldCacheTarget
{
    NSString *fullUrl = [self URLEncodeString:urlScheme];
    NSURL *url = [NSURL URLWithString:fullUrl];
    if (!url) {
        NSLog(@"post url schema error");
        //        debugLog(@"协议出错了!");
    }
    NSString *layer = url.host;
    NSString *path = url.relativePath; // path = /Imei/getImei /${Class}/${method}
    
    NSLog(@"type nsnumber %d", [params isKindOfClass:[NSNumber class]]);
    NSLog(@"type nsstring %d", [params isKindOfClass:[NSString class]]);
    
    NSArray *pathArr = [path componentsSeparatedByString:@"/"];
    NSString *clsString = [pathArr objectAtIndex:1];
    NSString *method = [pathArr objectAtIndex:2];
    
    id ret;
    if([layer isEqualToString:@"atom"]
       || [layer isEqualToString:@"basic"]
       || [layer isEqualToString:@"component"]
       || [layer isEqualToString:@"scene"]
       ){
        ret = [self performTarget:clsString
                           action:method
                           params:params
                            useCb:callback
                shouldCacheTarget:shouldCacheTarget];
    }
    return ret;
}


- (NSDictionary *)getParams:(NSString *)encodeUrlScheme withHost:(NSString *)host {
    NSDictionary *params;
    NSArray *array = [encodeUrlScheme componentsSeparatedByString:@"url="];
    if (([host isEqualToString:@"third_webview"] || [host isEqualToString:@"common_webview"]) && array.count > 1) {
        NSString *value = array[1];
        
        while ([value rangeOfString:@"%"].length != 0) {
            value = [self URLDecodedString:value];
        }
        params = @{@"url":value};
    } else {
        params = [self urlQueryToDictionary:encodeUrlScheme];
    }
    return params;
}

- (NSString *)getHostWithEncodeUrlScheme:(NSString *)encodeUrlScheme host:(NSString *)host {
    NSArray *array = [encodeUrlScheme componentsSeparatedByString:@"url="];
    if (([host isEqualToString:@"third_webview"] || [host isEqualToString:@"common_webview"]) && array.count > 1) {
        NSString *value = array[1];
        while ([value rangeOfString:@"%"].length != 0) {
            value = [ self URLDecodedString:value];
        }
    }
    return host;
}

- (id)pushScheme:(NSString *)urlScheme params:(NSDictionary *)params {
    return nil;
    //    NSString *encodeUrlScheme = [self URLEncodeString:urlScheme];
    //    NSURL *url = [NSURL URLWithString:encodeUrlScheme];
    //    if (!url) {
    //        //        debugLog(@"协议出错了!");
    //    }
    //    NSString *host = url.host;
    //    NSString *targetName = [routeMap objectForKey:host];
    //    NSDictionary *paramsDict = [self getParams:encodeUrlScheme withHost:host];
    //    host = [self getHostWithEncodeUrlScheme:encodeUrlScheme host:host];
    //    return [self performTarget:targetName action:host params:paramsDict shouldCacheTarget:NO];
}

#pragma mark - string to dict
- (NSDictionary*)urlQueryToDictionary:(NSString *)urlScheme {
    NSURL* url1 = [NSURL URLWithString:urlScheme];
    if (!url1) {
        return nil;
    }
    NSString *query = [url1 query];
    return [self queryToDictionary:query];
}



- (NSDictionary*)queryToDictionary:(NSString *)query {
    @try {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        NSArray* components = [query componentsSeparatedByString:@"&"];
        for (NSString* component in components) {
            NSArray* keyValue = [component componentsSeparatedByString:@"="];
            if ([keyValue count] > 1) {
                NSString * key = [self URLDecodedString:[keyValue objectAtIndex:0]];
                NSString * value = [keyValue objectAtIndex:1];
                
                //参数中依然包含超过2个“=”号（多数发生在common_webview后的url参数中），则后面的数组的元素需要拼接成一个字符串
                if ([keyValue count]>2) {
                    for (int i=2; i<[keyValue count]; i++) {
                        value=[value stringByAppendingString:@"="];
                        value=[value stringByAppendingString:keyValue[i]];
                    }
                }
                
                //因为这种情况服务器和客户端都转义了一次，所以要两次反转义还原中文
                while ([value rangeOfString:@"%"].length != 0) {
                    value = [self URLDecodedString:value];
                }
                [dict setObject: value forKey: key];
            }
        }
        return dict;
    }
    @catch (NSException *exception) {}
}

- (NSString*)URLDecodedString:(NSString *)urlStr {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)urlStr,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}


- (NSString *)URLEncodeString:(NSString *)urlStr {
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}



@end

NSString *enActionFuncName(NSString *actionName){
    return [NSString stringWithFormat:@"%@:",actionName];
}

NSString *deActionFuncName(NSString *action){
    if ([action hasPrefix:GMRouterActionPrefix] &&
        [action hasSuffix:GMRouterActionSuffix]) {
        return [action substringWithRange:NSMakeRange(GMRouterActionPrefix.length, action.length - GMRouterActionPrefix.length - GMRouterActionSuffix.length)];
    }
    return action;
}

Class getClassFromAtcion(SEL sel){
    return NSClassFromString(deActionFuncName(NSStringFromSelector(sel)));
}

void registerSelectorToMediator(NSString *clsName,NSString *selName){
    if (!routeMap) {
        routeMap = [[NSMutableDictionary alloc] init];
    }
    [routeMap setObject:selName forKey:clsName];
}

void removeSelectorToMediator(NSString *clsName){
    [routeMap removeObjectForKey:clsName];
}

