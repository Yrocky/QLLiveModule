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

#import "QLLiveListLayout.h"

@interface DDDDDDViewController : UIViewController

@end
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.window.rootViewController = DDDDDDViewController.new;

    //
    return YES;
    ViewController * vc = [[ViewController alloc] initWithModule:({
        QLLiveCompositeModule * module = [[QLLiveCompositeModule alloc] initWithName:@"demo"];
        [module addModule:({
            [[DemoFlexLayoutModule alloc] initWithName:@"Flex"];
        })];
        [module addModule:({
            [[DemoListLayoutModule alloc] initWithName:@"List"];
        })];
        [module addModule:({
            [[DemoWaterfallLayoutModule alloc] initWithName:@"Waterfall"];
        })];
        [module addModule:({
            [[DemoBackgroundDecorateModule alloc] initWithName:@"Decorate"];
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
            [[DemoMusicModule alloc] initWithName:@"音乐app"];
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
@implementation DDDDDDViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIScrollView * contentView = [UIScrollView new];
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    NSArray * dataSource = @[
        @"aa111",@"aa222",@"aa3",@"aa4444",
        @"bbb111",@"bbb222",@"bb3",@"bb4444",
        @"ccc111",@"ccc222",@"ccc3",@"ccc4444",
    ];
    
    QLLiveListLayout * layout = [QLLiveListLayout new];
    layout.distribution = [QLLiveLayoutDistribution distributionValue:2];
    layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:20];
    layout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSpacing = 10.0f;
    layout.lineSpacing = 10.0f;
    layout.arrange = QLLiveLayoutArrangeHorizontal;
        layout.row = 3;
//    layout.horizontalArrangeContentHeight = 90;
    [layout calculatorHorizontalLayoutWithDatas:dataSource];
    
    CGFloat height = layout.horizontalArrangeContentHeight + layout.inset.top + layout.inset.bottom;
    CGFloat width = layout.contentWidth + layout.inset.left + layout.inset.right;
    contentView.contentSize = CGSizeMake(width,height);
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.center.equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
    
    NSInteger index = 0;
    for (id data in dataSource) {
        UILabel * view = [UILabel new];
        view.backgroundColor = [UIColor randomColor];
        [contentView addSubview:view];
        view.text = [NSString stringWithFormat:@"%d",index];
        view.textColor = [UIColor blackColor];
//        CGRect frame = [layout.frames[index] CGRectValue];
//        frame.origin.y += layout.inset.top;
//        view.frame = frame;
        index ++;
    }
}
@end
