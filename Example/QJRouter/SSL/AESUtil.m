//
//  AESUtil.m
//  QJRouter_Example
//
//  Created by yujie_900 on 2021/3/4.
//  Copyright © 2021 jz. All rights reserved.
//

#import "AESUtil.h"

//const NSString *AESKey = @"zabcdefghABCDEFG";
/*
 const NSString *AESKey = @"zabcdefghABCDEFG";
 entext base64 => zer2841bAwD/CkTIFwhK8Q==
 entext hex => cdeaf6f38d5b0300ff0a44c817084af1
 */
//const NSString *AESKey = @"46FCBE3CDF0D290C8210270DF71FD67EC892071F1E6D249A21483334871F205B5561997EBD168844404C71DA13B2615432B3530A15252065AEC41812D7224A55";
const NSString *AESKey =
//    @"46FCBE3CDF0D290C8210270DF71FD67EC----123123";
//@"46FCBE3CDF0D290C8210270DF71FD67E";  //32
@"46FCBE3CDF0D290C";  //16
//32

//    zabcdefghABCDEFG
/*
 const NSString *AESKey = @"46FCBE3CDF0D290C8210270DF71FD67EC892071F1E6D249A21483334871F205B5561997EBD168844404C71DA13B2615432B3530A15252065AEC41812D7224A55";
 entext base64 => BC2+AQJ6ZQx0al3GXba+EQ==
 entext hex => 042dbe01027a650c746a5dc65db6be11
 */
@interface AESUtil()
 
@end


@implementation AESUtil

+ (NSString *)aesEncrypt:(NSString *)sourceStr{
    if (!sourceStr) {
        return nil;
    }
    char keyPtr[kCCKeySizeAES128 + 1]; // 128
    bzero(keyPtr, sizeof(keyPtr));
//    NSString *bb = @"46FCBE3CDF0D290C8210270DF71FD67";
    [AESKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    printf("keyptr => %s\n",keyPtr);

    NSData *sourceData = [sourceStr dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128, // 16
                                          NULL,
                                          [sourceData bytes],
                                          dataLength,
                                          buffer,
                                          buffersize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //对加密后的二进制数据进行base64转码
        NSString *strBase64 = [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSLog(@"entext base64 => %@",strBase64);
        
        NSMutableString *output;
        if (encryptData && encryptData.length > 0) {
            Byte *datas = (Byte*)[encryptData bytes];
            output = [NSMutableString stringWithCapacity:encryptData.length * 2];
            for(int i = 0; i < encryptData.length; i++) {
                [output appendFormat:@"%02x", datas[i]];
            }
            NSLog(@"entext hex => %@",output);
        }
        return output;
    } else {
        free(buffer);
        return nil;
    }
}

+ (NSString *)aesDecrypt:(NSString *)secretStr{
    if (!secretStr) {
        return nil;
    }
    //先对加密的字符串进行base64解码
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:secretStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [AESKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [decodeData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [decodeData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

@end

