//
//  DemoMineModule.m
//  QILievModule
//
//  Created by rocky on 2020/8/10.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "DemoMineModule.h"
#import "DemoMineComponent.h"

@implementation DemoMineModule

- (BOOL)shouldLoadMore{
    return NO;
}

- (NSArray<__kindof QLLiveComponent *> *) defaultComponents{
    
    QLLiveComponent * userCenterComp = [MineInfoComponent new];
    [userCenterComp addData:@"12"];
    
    QLLiveComponent * listComp = [MineListComponent new];
    [listComp addDatas:@[@"aaa",@"bbb",@"ccc",@"ddd"]];
    
    QLLiveComponent * bannerComp = [MineBannerComponent new];
    [bannerComp addData:@"000"];
    
    QLLiveComponent * funcComp = [MineFunctionComponent new];
    [funcComp addDatas:@[
        @"aaa1",@"bbb1",@"ccc1",@"ddd1",
        @"aaa2",@"bbb2",@"ccc2",@"ddd2",
        @"aaa3",@"bbb3",@"ccc3",@"ddd3",
    ]];
    return @[userCenterComp,listComp,bannerComp,funcComp];
}

@end
