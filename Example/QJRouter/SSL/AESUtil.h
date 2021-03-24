//
//  AESUtil.h
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/3/4.
//  Copyright © 2021 jz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
NS_ASSUME_NONNULL_BEGIN
 
/**
 * AES工具类
 */
@interface AESUtil : NSObject
 
/**
 * AES加密
 */
+ (NSString *)aesEncrypt:(NSString *)sourceStr;
 
/**
 * AES解密
 */
+ (NSString *)aesDecrypt:(NSString *)secretStr;
 
@end

NS_ASSUME_NONNULL_END
