//
//  JmeVC.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/1/27.
//  Copyright © 2021 jz. All rights reserved.
//

#import "JmeVC.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface JmeVC()
@property (nonatomic, strong) NSString *rule;

@property (nonatomic, strong) UITextField *condField;
@property (nonatomic, strong) UITextView *retField;

@property (nonatomic, strong) JSContext *context;
@end

@implementation JmeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    label.text = @"JMES Path 体验";
    [self.view addSubview:label];
    
    _condField = [[UITextField alloc]initWithFrame:CGRectMake(20, 140, 300, 30)];
    
    _condField.borderStyle = UITextBorderStyleRoundedRect;
    _condField.text = @"aaa";
    _condField.placeholder = @"请输入规则表达式";
    _condField.delegate = self;
    
    
    _retField = [[UITextView alloc]initWithFrame:CGRectMake(20, 200, 300, 300)];
    _retField.text = @"这里是结果";
    _retField.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
    
    
    // 将控件添加到当前视图上
    [self.view addSubview:_condField];
    [self.view addSubview:_retField];
    
    [self loadJSEnv];
}

-(void)loadJSEnv{
    
    NSError *error=nil;
    
    NSString *libpath=[[NSBundle mainBundle] pathForResource:@"jmespath"ofType:@"js"];
    NSString *datapath=[[NSBundle mainBundle] pathForResource:@"rawdata"ofType:@"json"];
    NSString *rulepath=[[NSBundle mainBundle] pathForResource:@"rule"ofType:@"txt"];
    
    NSString *libstr=[[NSString alloc] initWithContentsOfFile:libpath encoding:NSUTF8StringEncoding error:&error];
    NSString *datastr=[[NSString alloc] initWithContentsOfFile:datapath encoding:NSUTF8StringEncoding error:&error];
    NSString *rulestr=[[NSString alloc] initWithContentsOfFile:rulepath encoding:NSUTF8StringEncoding error:&error];
    
    rulestr = [rulestr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    rulestr = [rulestr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    _condField.text = rulestr;
    
    
    _context = [[JSContext alloc] init];
    _context[@"jsCatchErr"] = ^(JSValue* jsException) {
        NSLog(@"jsException = %@",jsException);
        _retField.text = [NSString stringWithFormat:@"%@",jsException];
    };
    [_context evaluateScript:libstr];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //    NSLog(@"end %@ =>",textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSError *error=nil;
    
    NSString *datapath=[[NSBundle mainBundle] pathForResource:@"rawdata"ofType:@"json"];
    NSString *datastr=[[NSString alloc] initWithContentsOfFile:datapath encoding:NSUTF8StringEncoding error:&error];
    
    
    NSLog(@"return %@ =>",textField.text);
    NSString *eva = [NSString stringWithFormat:
                     @"try{jmespath.search(%@, '%@')}catch(e){jsCatchErr(e)}",
                     datastr,
                     textField.text];
    
    NSLog(@"eva = %@",eva);
    NSDictionary *jret = [[_context evaluateScript:eva] toObject];
    NSLog(@"js ret = %@",jret);
    if(jret){
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jret options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        
        if (!jsonData) {
            NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        _retField.text = jsonString;
    }
 
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:
(NSRange)range replacementString:(NSString *)string {
    //    NSLog(@"end change %@ => %@",textField.text, string);
    
    return YES;
}
@end
