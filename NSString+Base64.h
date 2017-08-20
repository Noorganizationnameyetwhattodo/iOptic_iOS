//
//  NSString+Base64.h
//  Decoding
//
//  Created by Santhosh on 18/08/17.
//  Copyright © 2017 Santhosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (instancetype)encodeBase64String:(NSString *)stringToEncode;
+ (instancetype)decodeBase64String:(NSString *)stringToDeccode;

@end
