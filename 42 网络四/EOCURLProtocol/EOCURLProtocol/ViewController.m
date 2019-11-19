//
//  ViewController.m
//  EOCURLProtocol
//
//  Created by EOC on  /6/11.
//  Copyright ©  年 EOC. All rights reserved.
//

#define URLPath @"http://www.baidu.com/center/front/app/util/updateVersions"

#import "ViewController.h"
#import "EOCWebViewCtr.h"
#import "URLSessionVC.h"
#import "EOCURLProtocol.h"
#import "NetTest.h"
#import "CFNetworkVC.h"


@interface ViewController ()<NSURLSessionDataDelegate, NSURLSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonPress:(id)sender{
//    [self.navigationController pushViewController:[URLSessionVC new] animated:YES];
    
    [self.navigationController pushViewController:[CFNetworkVC new] animated:YES];
    
//    [self.navigationController pushViewController:[EOCWebViewCtr new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //截获封装好的库的网络
    [NSURLProtocol registerClass:[EOCURLProtocol class]];
    [NetTest netLoadBlock];
}


@end
