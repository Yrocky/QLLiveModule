//
//  AppDelegate.m
//  QILievModule
//
//  Created by rocky on 2020/8/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUCPKPicop9KQF6hLzsI8vgl6wREXF7JBdA9g7fDpo5yL7aR760IibvXicw/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUDRa2RPtoQY4XOZegg0GSiadfNnEXDdVcHQPuhNUJp8iazj8BkBkMgv9A/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLU2cwP0TygB14ibYibBUGJJBcxJyRWU2ugp9N4t1h8UIC56cib3EdvZPKFg/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUeldkVDj6MyBxI63DsYP8ibjnpFucWJbqEnCvtLcmXEYVTcYIWIKJcVA/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUYxwmKlK0YxelFCQY32gDolsrrFtJaHiaZYqgoM44EgsaAl7VPRHvFAQ/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUb1cSVuMpN5bzerupmCxXjONzRYC4421bzN9kia2Qia0yKyenNaCvV6tA/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 https://mmbiz.qpic.cn/mmbiz_jpg/j2yBcV472NPND0cqP3ADBj3pNNZBNTLUWBJFS6mok80FoD9ic0VfVEJUew3Q6IDGeNbtOhjicYrlZze44XFZ8oXw/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
 
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    ViewController * vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;

    return YES;
}

@end
