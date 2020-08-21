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

@interface DDDDDDViewController : UIViewController<QLLiveWaterfallLayoutDelegate>

@end
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
@implementation DDDDDDViewController{
    NSArray *_dataSource;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIScrollView * contentView = [UIScrollView new];
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
//    QLLiveWaterfallLayout * layout = [QLLiveWaterfallLayout new];
//    layout.arrange = QLLiveLayoutArrangeHorizontal;
//    layout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.itemSpacing = 10;
//    layout.lineSpacing = 10;
//    layout.renderDirection = QLLiveWaterfallItemRenderShortestFirst;
//    layout.row = 2;
//    layout.horizontalArrangeContentHeight = 300;
//    layout.delegate = self;
//    _dataSource = @[
//        @"100",@"80",@"50",
//        @"110",@"60",@"40",
//        @"120",@"130",@"140"
//    ];
//    [layout calculatorHorizontalLayoutWithDatas:_dataSource];
//
//    for (NSInteger index = 0; index < _dataSource.count; index ++) {
//        CGRect frame = [layout.frames[index] CGRectValue];
//        UILabel * view = [UILabel new];
//        view.backgroundColor = [UIColor randomColor];
//        [contentView addSubview:view];
//        view.text = [NSString stringWithFormat:@"%d %.0f",index,frame.size.width];
//        view.textColor = [UIColor blackColor];
//        frame.origin.x += layout.inset.left;
//        frame.origin.y += layout.inset.top;
//        view.frame = frame;
//    }
//
//    CGFloat height = layout.horizontalArrangeContentHeight + layout.inset.top + layout.inset.bottom;
//    CGFloat width = layout.contentWidth + layout.inset.left + layout.inset.right;
//    contentView.contentSize = CGSizeMake(width,height);
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view);
//        make.center.equalTo(self.view);
//        make.height.mas_equalTo(height);
//    }];

}

#pragma mark - QLLiveWaterfallLayoutDelegate

- (CGSize)layoutCustomItemSize:(QLLiveWaterfallLayout *)layout atIndex:(NSInteger)index{
    CGFloat width = [_dataSource[index] floatValue];
    return CGSizeMake(width, layout.itemHeight);
}
@end
