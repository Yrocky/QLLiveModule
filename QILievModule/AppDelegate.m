//
//  AppDelegate.m
//  QILievModule
//
//  Created by rocky on 2020/8/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DemoVideoModule.h"
#import "DemoSearchModule.h"
#import "DemoLivingModule.h"
#import "DemoShoppingModule.h"
#import "DemoMusicModule.h"
#import "DemoMineModule.h"
#import "DemoResumeModule.h"
#import "DemoHuabanModule.h"
#import "QLLiveWaterfallLayout.h"
#import "QLLiveListLayout.h"

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

//    self.window.rootViewController = DDDDDDViewController.new;
//    return YES;
    ViewController * vc = [[ViewController alloc] initWithModule:({
        QLLiveCompositeModule * module = [[QLLiveCompositeModule alloc] initWithName:@"demo"];
        [module addModule:({
            [[DemoMusicModule alloc] initWithName:@"音乐app"];
        })];
        [module addModule:({
            QLLiveCompositeModule * demoModule = [[QLLiveCompositeModule alloc] initWithName:@"DEMO"];
            [demoModule addModule:[[DemoFlexLayoutModule alloc] initWithName:@"Flex"]];
            [demoModule addModule:[[DemoBackgroundDecorateModule alloc] initWithName:@"Decorate"]];
            [demoModule addModule:[[DemoListLayoutModule alloc] initWithName:@"List"]];
            [demoModule addModule:[[DemoWaterfallLayoutModule alloc] initWithName:@"Waterfall"]];
            demoModule;
        })];
        [module addModule:({
            [[DemoVideoModule alloc] initWithName:@"视频app"];
        })];
        [module addModule:({
            [[DemoHuabanModule alloc] initWithName:@"花瓣app"];
        })];
        [module addModule:({
            [[DemoSearchModule alloc] initWithName:@"搜索界面"];
        })];
        [module addModule:({
            [[DemoLivingModule alloc] initWithName:@"直播app"];
        })];
        [module addModule:({
            [[DemoShoppingModule alloc] initWithName:@"购物app"];
        })];
        [module addModule:({
            [[DemoMineModule alloc] initWithName:@"个人中心"];
        })];
        [module addModule:({
            [[DemoResumeModule alloc] initWithName:@"Resume"];
        })];
        module;
    })];
    self.window.rootViewController = vc;

    return YES;
}

@end
