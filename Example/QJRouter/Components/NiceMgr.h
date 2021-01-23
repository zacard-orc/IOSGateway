//
//  NiceMgr.h
//  Dallas
//
//  Created by king on 2021/1/18.
//  Copyright © 2021 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static int v_nicemgr = 1;

@interface NiceMgr : NSObject
-(void)swim;
-(UILabel*)addLabel:(NSString*) msg;
-(UIImageView *)addImage;
@end

NS_ASSUME_NONNULL_END
