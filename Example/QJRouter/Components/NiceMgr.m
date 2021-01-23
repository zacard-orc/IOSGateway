//
//  NiceMgr.m
//  Dallas
//
//  Created by king on 2021/1/18.
//  Copyright © 2021 ios. All rights reserved.
//

#import "NiceMgr.h"

@implementation NiceMgr
-(void)swim{
    NSLog(@"NiceMgr swim");
}
-(UILabel*)addLabel:(NSString*) msg{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 200, 40)];
    NSLog(@"add label");
    label.text = @"add label";
    return label;
}

-(UIImageView *)addImage{
//    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"Dallas")];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

//    NSLog(@"self class %@ %@",[self class], bundle);
    NSLog(@"self class  %@", bundle);

    UIImage *img = [UIImage imageNamed:@"Dallas.bundle/demo.png"
                    inBundle:bundle compatibleWithTraitCollection:nil
                    ];
    NSLog(@"img = %@", img);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,300, 100, 100)];
    
    [imgView setImage:img];
    return imgView;
}
@end
