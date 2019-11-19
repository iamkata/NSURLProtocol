//
//  NetTest.m
//  NetTest
//
//  Created by sy on 2017/10/31.
//  Copyright © 2017年 EOC. All rights reserved.
//

#import "NetTest.h"
#define URLPath @"http://svr.tuliu.com/center/front/app/util/updateVersions"
#import <pthread.h>

@implementation NetTest


+ (void)netLoadBlock{
    
    //地址
    NSString *urlstr = [NSString stringWithFormat:@"%@?versions_id=1&system_type=1", URLPath];
    NSURL *url = [NSURL URLWithString:urlstr];
    
    //请求体
    static NSMutableURLRequest *request;
    request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        
        NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@", infoDict);
        
    }];
    [task resume];
}


@end
