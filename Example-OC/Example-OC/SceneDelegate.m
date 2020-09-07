//
//  SceneDelegate.m
//  Example-OC
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "SceneDelegate.h"

#import "ViewController.h"
#import "DemoVideoModule.h"
#import "DemoSearchModule.h"
#import "DemoLivingModule.h"
#import "DemoShoppingModule.h"
#import "DemoMusicModule.h"
#import "DemoMineModule.h"
#import "DemoResumeModule.h"
#import "DemoHuabanModule.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
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
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
