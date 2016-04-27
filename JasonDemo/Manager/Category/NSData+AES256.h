//
//  NSData+AES256.h
//  AES
//
//  Created by Henry Yu on 2009/06/03.
//  Copyright 2010 Sevensoft Technology Co., Ltd.(http://www.sevenuc.com)
//  All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

// Key(密钥)和Byte(向量)的枚举
typedef enum
{
    KindUser,
    KindClient,
    KindServer,
    KindQRCode
} Kinds;

// AES加密解密管理
@interface NSData (AES256)

+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain withKey:(Kinds)kind;           /*加密方法，参数需要加密的内容和加密对象类型*/

+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts withKey:(Kinds)kind;    /*解密方法，参数数密文内容和解密对象类型*/

@end
