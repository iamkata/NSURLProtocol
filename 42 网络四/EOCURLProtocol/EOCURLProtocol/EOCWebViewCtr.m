//
//  EOCWebViewCtr.m
//  EOCURLProtocol
//
//  Created by EOC on  /6/13.
//  Copyright ©  年 EOC. All rights reserved.
//

#import "EOCWebViewCtr.h"
#import "EOCURLProtocol.h"

@interface EOCWebViewCtr ()

@end

@implementation EOCWebViewCtr

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [NSURLProtocol registerClass:[EOCURLProtocol class]];
    NSURL *url = [NSURL URLWithString:@"http://huaban.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
    
}

@end
