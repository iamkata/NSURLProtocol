//
//  EOCURLProtocol.m
//  EOCURLProtocol
//
//  Created by sy on 2018/5/18.
//  Copyright © 2018年 EOC. All rights reserved.
//

#import "EOCURLProtocol.h"
#import <UIKit/UIKit.h>

@implementation EOCURLProtocol

/*
 内部使用runtime交换一些方法
 */

/*
 1 通过 URLSession发起网络
 2 然后走的是EOCURLProtocol中间层
 3 通过EOCURLProtocol中间层处理， 回到URLSession代理回掉层次
 
 */

/*
 分为四步:
 1 是否重新定向request
 2 修改request
 3 重新启动
 4 结束
 实现这四个步骤, 我们就能想给什么数据给什么数据
 */

/* 1是否重新定向 YES是重定向，NO 不修改 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    NSLog(@"=========%@", request.URL);
    
    //如果url是图片, 就重定向
    NSString *urlstr = request.URL.path;
    if ([urlstr hasSuffix:@".png"]) {
        return YES;
    }

    //如果使用了错误的baidu.com地址, 就重定向
    NSString *domain = request.URL.host;
    if ([domain isEqualToString:@"www.baidu.com"]) {
        return YES;
    }

    return NO;
}

// 2 修改request
//canonical 规范
+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request{
    
    NSMutableURLRequest *newRequest = request.mutableCopy;
    NSString *domain = request.URL.host;
    if ([domain isEqualToString:@"www.baidu.com"]) {
        //将错误的baidu.com 改成 svr.tuliu.com
        NSString *urlstr = request.URL.absoluteString;
        urlstr = [urlstr stringByReplacingOccurrencesOfString:@"www.baidu.com" withString:@"svr.tuliu.com"];
        newRequest.URL = [NSURL URLWithString:urlstr];
    }
    return newRequest;
    
}

//3 重新启动
- (void)startLoading{
//    [self loadLocalData];
    [self reloadNet];
}

//用本地数据
- (void)loadLocalData{
    
    //分三步修改
    //1.didReceiveResponse
    [self.client URLProtocol:self didReceiveResponse:[NSURLResponse new] cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    UIImage *localImage = [UIImage imageNamed:@"1.png"];
    NSData *localImageData = UIImagePNGRepresentation(localImage);
    //2.didLoadData
    [self.client URLProtocol:self didLoadData:localImageData];
    //3.DidFinishLoading
    //这三个方法和URLSession代理方法里面的三个方法相对应
    [self.client URLProtocolDidFinishLoading:self];
}

//重新加载 - 使用代理, 在相应的代理方法里面走上面的三步
- (void)reloadNet{
    
    NSMutableURLRequest *newRequest = [self.request mutableCopy];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:newRequest];
    
    [task resume];
}

// 4 结束

- (void)stopLoading{
    
    
}

#pragma mark - 代理方法

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
    //第一步
    [self.client URLProtocol:self didReceiveResponse:[NSURLResponse new] cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //最前面加123456
//    NSMutableData *eocdata = [@"123456" dataUsingEncoding:NSUTF8StringEncoding].mutableCopy;
//    [eocdata appendData:data];
//    [self.client URLProtocol:self didLoadData:eocdata];
    
    //第二步
    [self.client URLProtocol:self didLoadData:data];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //第三步
    [self.client URLProtocolDidFinishLoading:self];
}

@end
