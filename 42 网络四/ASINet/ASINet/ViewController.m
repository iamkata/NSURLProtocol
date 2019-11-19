//
//  ViewController.m
//  ASINet
//
//  Created by sy on 2017/12/18.
//  Copyright © 2017年 sy. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self asiHttp];
}

- (void)asiHttp{
    
    NSURL *url = [NSURL URLWithString:@"http://svr.tuliu.com/center/front/app/util/updateVersions?versions_id=1&system_type=1"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    // 当以文本形式读取返回内容时用这个方法
    NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
    //NSData *responseData = [request responseData];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSError *error = [request error];
    NSLog(@"error::%@", error);
    
}


@end
