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
