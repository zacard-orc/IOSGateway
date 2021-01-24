//
//  GMRouter.m
//  GMRouter
//
//  Created by Q14 on 2019/11/28.
//  这个地方是根据CTMediator思路改编而成

#import "QJRouter.h"
#import "QJRouter+gm.h"
#import "QJCommon.h"
#import <objc/runtime.h>

//test
//#import "../Atom/OpsTime.h"

NSString * const GMRouterParamsKeySwiftTargetModuleName = @"GMRouterParamsKeySwiftTargetModuleName";

@interface QJRouter()
@property (nonatomic, strong) NSMutableDictionary *cachedTarget;
@end

@implementation QJRouter

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static QJRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[QJRouter alloc] init];
    });
    return router;
}

- (void)setAtomArray:(NSArray *)atomArray {
    _atomArray = atomArray;
    [self initializeRouteMap:atomArray];
}
- (void)setBasicArray:(NSArray *)basicArray {
    _basicArray = basicArray;
    [self initializeRouteMap:basicArray];
}
- (void)setComponentArray:(NSArray *)componentArray {
    _componentArray = componentArray;
    [self initializeRouteMap:componentArray];
}
- (void)setSceneArray:(NSArray *)sceneArray {
    _sceneArray = sceneArray;
    [self initializeRouteMap:sceneArray];
}


/*
 scheme://[target]/[action]?[params]
 url sample:
 aaa://targetA/actionB?id=1234
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id result = [self performTarget:url.host action:actionName params:params useCb:nil shouldCacheTarget:NO];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
             useCb:(nullable id)callback
             shouldCacheTarget:(BOOL)shouldCacheTarget
{
    NSObject *target = self.cachedTarget[targetName];
    if (target == nil) {
        Class targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    
    NSLog(@"boneMap %@",self.boneMap);
    // generate action
    NSString *actionString  = [self.boneMap objectForKey:
                               [NSString stringWithFormat:@"%@/%@",targetName,actionName]
                               ];
    if(actionString==nil){
        NSLog(@"no sel %@",actionName);
        id x;
        return x;
    }
    SEL action = NSSelectorFromString(actionString);
    
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    } else{
        self.cachedTarget[targetName] = nil;
    }
    
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params useCb:callback];
    } else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
//        SEL action = NSSelectorFromString(@"notFound:");
//        if ([target respondsToSelector:action]) {
//            return [self safePerformAction:action target:target params:params];
//        } else {
//            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
//            [self NoTargetActionResponseWithTargetString:targetName selectorString:actionString originParams:params];
//            [self.cachedTarget removeObjectForKey:targetName];
//            return nil;
//        }
        return nil;
    }
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - private methods
- (void)NoTargetActionResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams
{
    SEL action = NSSelectorFromString(@"Action_response:");
    NSObject *target = [[NSClassFromString(@"Target_NoTargetAction") alloc] init];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"originParams"] = originParams;
    params[@"targetString"] = targetString;
    params[@"selectorString"] = selectorString;
    
    [self safePerformAction:action target:target params:params useCb:nil];
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(id)params useCb:(nullable id)callback
{
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    
    const char* retType = [methodSig methodReturnType];
    Method runMethod = class_getInstanceMethod([target class], action);
    int arguments = method_getNumberOfArguments(runMethod);
    
    NSString *selString = NSStringFromSelector(action);
    NSString *cbStr = @"useCb";
    
    int blockIdx = -1;
    BOOL isRetVoid = FALSE;
    
    // found block
    for(int i=0;i<arguments;i++){
        char *argend = malloc(20);
        method_getArgumentType(runMethod,i,argend,20);
        NSLog(@"arg[%d] => %s",i,argend);
        
        if(strcmp(argend,"@?")==0){
            blockIdx = i;
            NSLog(@"has block argu");
        }
        
        free(argend);
    }
   
    NSLog(@"rettype = %s, argcount = %d",retType,arguments);
    
    id result;
    
    if (strcmp(retType, @encode(void)) == 0){
        isRetVoid = TRUE;
        result = nil;
    }
//    if (strcmp(retType, @encode(NSString*)) == 0) {
//        result = (NSString*)result;
//    }
//    if (strcmp(retType, @encode(NSNumber*)) == 0) {
//        result = (NSNumber*)result;
//    }
//    if (strcmp(retType, @encode(NSArray*)) == 0) {
//        result = (NSArray*)result;
//    }

    
    /*
     *  参数数量 <3 args
     *   无 performSelector
     *  >=3 args  1,2,3 argument,是否包含callback
     *      是=> invocation
     *      否=> performSelector
     *          1 performSelector withObject
     *          2 performSelector withObject withObject
     *          3 invocation
     */
    
    if( arguments == 2 ) {
        NSLog(@"do arg=2");
        return [target performSelector:action];
    } else if ( arguments == 3) {
        NSLog(@"do arg=3");
        // only demo, for return NSString
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setTarget:target];
        [invocation setSelector:action];
        if(blockIdx<0){
            [invocation setArgument:&params atIndex:2];
        } else{
            [invocation setArgument:&callback atIndex:2];
        }
        [invocation invoke];
        if (!isRetVoid) {
            [invocation getReturnValue:&result];
        }
        return result;
    } else{
        NSLog(@"do arg=4 & block");
        // only demo, not support multi params
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setTarget:target];
        [invocation setSelector:action];
        [invocation setArgument:&params atIndex:2];
        [invocation setArgument:&callback atIndex:3];
        [invocation invoke];
        if (!isRetVoid) {
            [invocation getReturnValue:&result];
        }
        return result;
    }
    
    id x;
    return x;

    
    //
//    if (strcmp(retType, @encode(NSInteger)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        NSInteger result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(BOOL)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        BOOL result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(CGFloat)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        CGFloat result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(NSUInteger)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        NSUInteger result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    return [target performSelector:action withObject:params];
//#pragma clang diagnostic pop
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}
@end
