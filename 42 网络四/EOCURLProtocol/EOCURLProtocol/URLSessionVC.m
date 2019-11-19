//
//  URLSessionVC.m
//  EOCURLProtocol
//
//  Created by sy on  /12/18.
//  Copyright ©  年 EOC. All rights reserved.
//

#import "URLSessionVC.h"
#import "EOCURLProtocol.h"


#define URLPath @"http://svr.tuliu.com/center/front/app/util/updateVersions"
//错误的测试地址
//#define URLPath @"http://www.baidu.com/center/front/app/util/updateVersions"

@interface URLSessionVC ()

@end

@implementation URLSessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netLoadBlockStyle];
//    [self netLoadDelegateStyle];
}

- (void)netLoadBlockStyle
{
    //使用block方式,注册一下
//    [NSURLProtocol registerClass:[EOCURLProtocol class]];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?versions_id=1&system_type=1", URLPath];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        
        NSLog(@"%s", [data bytes]);
       
        NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"ing-->%@", infoDict);
        
        
    }];
    
    [task resume];
    
}

//使用代理方式
- (void)netLoadDelegateStyle{
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?versions_id=1&system_type=1", URLPath];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:nil];
    
    NSURLSessionConfiguration *config =  [NSURLSessionConfiguration defaultSessionConfiguration];
    //使用代理方式,设置在config里面
    config.protocolClasses = [NSArray arrayWithObject:[EOCURLProtocol class]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request];
    
    [task resume];
}

#pragma mark - session delegate

//// NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{

    NSLog(@"didReceiveData:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{

    NSLog(@"Finish:%@", error);
}

@end
