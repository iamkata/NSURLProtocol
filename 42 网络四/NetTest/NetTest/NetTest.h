//
//  NetTest.h
//  NetTest
//
//  Created by sy on 2017/10/31.
//  Copyright © 2017年 EOC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTest : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

+ (void)netLoadBlock;


@end
