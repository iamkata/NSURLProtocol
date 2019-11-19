//
//  CFNetworkVC.m
//  EOCURLProtocol
//
//  Created by sy on 2018/5/18.
//  Copyright © 2018年 EOC. All rights reserved.
//

/*
 ASIHttp就是用CF写的
 */
#import "CFNetworkVC.h"
#import <CFNetwork/CFNetwork.h>

void __CFReadStreamClientCallBack(CFReadStreamRef stream, CFStreamEventType type, void *clientCallBackInfo){
    
    CFNetworkVC *tmpSelf = (__bridge CFNetworkVC*)clientCallBackInfo;
    if (type == kCFStreamEventOpenCompleted) {
        NSLog(@"开始了");
        
    }else if(type == kCFStreamEventHasBytesAvailable){
        
        NSLog(@"数据");
        
        UInt8 buff[4096];
        CFIndex lenght = CFReadStreamRead(stream, buff, 4096);
        //NSLog(@"%s", buff);
        [tmpSelf handleNetData:[NSData dataWithBytes:buff length:lenght]];
        
    }else if(type == kCFStreamEventEndEncountered || type == kCFStreamEventErrorOccurred){
        
        NSLog(@"结束了");
        
    }
    
}

@interface CFNetworkVC ()

@end


@implementation CFNetworkVC


- (void)handleNetData:(NSData*)data{
    NSLog(@"%s", [data bytes]);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self startCFNet];
}


- (void)startCFNet{
    
    // 1 url
    CFStringRef urlStr = CFSTR("http://svr.tuliu.com/center/front/app/util/updateVersions?versions_id=1&system_type=1");
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, urlStr, NULL);
    
    
    // 2 request
    CFStringRef method = CFSTR("GET");
    CFHTTPMessageRef request = CFHTTPMessageCreateRequest(kCFAllocatorDefault, method, url, kCFHTTPVersion1_1);
    
   // CFHTTPMessageSetBody(request, <#CFDataRef  _Nonnull bodyData#>)
    // 3 发送
    
    CFReadStreamRef readStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, request);
    
    //
    CFOptionFlags streamStatus = kCFStreamEventOpenCompleted | kCFStreamEventHasBytesAvailable | kCFStreamEventErrorOccurred | kCFStreamEventEndEncountered;
    
    CFStreamClientContext context = {0, (__bridge void*)self, NULL, NULL, NULL};
    CFReadStreamSetClient(readStream, streamStatus, __CFReadStreamClientCallBack, &context);
    
    CFReadStreamScheduleWithRunLoop(readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFReadStreamOpen(readStream);
    
    // 4 接收数据  通过readStream来操作
}

@end
