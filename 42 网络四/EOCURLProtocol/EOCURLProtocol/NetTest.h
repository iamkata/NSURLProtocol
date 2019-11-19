//
//  NetTest.h
//  NetTest
//
//  Created by sy on  /10/31.
//  Copyright ©  年 EOC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTest : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

+ (void)netLoadBlock;

@end
