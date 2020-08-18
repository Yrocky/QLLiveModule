//
//  DemoVideoModule.m
//  QILievModule
//
//  Created by rocky on 2020/8/10.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "DemoVideoModule.h"
#import "DemoVideoComponent.h"

static NSDictionary * videoData;

@implementation DemoVideoModule

- (instancetype)initWithName:(NSString *)name{
    self = [super initWithName:name];
    if (self) {
        videoData = @{
            @"banner":@[
                    @"https://puui.qpic.cn/video_caps/0/r3135gxdhof.q4.jpg/0",
                    @"https://puui.qpic.cn/qqvideo_ori/0/n3137n50b4l_360_204/0",
                    @"https://puui.qpic.cn/tv/0/1216476595_285160/0",
                    @"https://puui.qpic.cn/tv/0/1215971255_285160/0",
                    @"https://puui.qpic.cn/qqvideo/0/t31376jilpk/332"
            ],
            @"category":@[
                    @"精选",
                    @"电视剧",
                    @"电影",
                    @"综艺",
                    @"动漫",
                    @"少儿",
                    @"纪录片",
                    @"音乐"
            ],
            @"hot":@[@"https://puui.qpic.cn/vcover_vt_pic/0/0pj8vuntnocu7971572426589/350",
                     @"https://puui.qpic.cn/vcover_vt_pic/0/mzc00200msasbht1594277675206/350",
                     @"https://puui.qpic.cn/vcover_vt_pic/0/mzc00200sdazhw61595925306553/350",
                     @"https://puui.qpic.cn/vcover_vt_pic/0/c6jz9bdhtz6a8k41539140824/350",
                     @"https://puui.qpic.cn/vcover_vt_pic/0/mzc00200iq4oevy1587546092886/350",
                     @"https://puui.qpic.cn/vcover_vt_pic/0/mzc00200vef064r1597137067757/350"],
            @"film":@[
                    @"https://puui.qpic.cn/vcover_vt_pic/0/380idj4s3fxn1mz1543994759/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/e0bk8kf7wllv7r81595899463119/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/xg95sxi4q7zc4uot1460107848.jpg/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/v2098lbuihuqs111587100715029/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/f7pqur8uhmzltps1559809738/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/r5trbf8xs5uwok11590989398026/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/803p673mlosoeog1559758979/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/c2seabnsfozypl81523522065/220",
                    @"https://puui.qpic.cn/vcover_vt_pic/0/is7os79rewv1iuk1560166900/220"
            ],
            @"rank":@[
                    @"盗梦空间",
                    @"楚门的世界",
                    @"星际穿越",
                    @"黑客帝国",
                    @"蝴蝶效应",
                    @"2001太空漫游",
                    @"回到未来",
                    @"超能陆战队",
                    @"守望者",
            ],
            @"video":@[
                    @(170),@(80),@(190),@(100),
                    @(110),@(200),@(130),
                    @(40),@(150),@(60),
            ],
            @"number":@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"],
            @"company":@[@"google",@"facebook",@"youtube",@"amazon",@"apple",@"Microsoft",@"Alphabet",@"IBM"],
            @"music":@[@"0 Love of My Life",@"1 Thank You",@"2 Yesterday Once More",@"3 You Are Not Alone",@"4 Billie Jean",@"5 Smooth Criminal",@"6 Earth Song",@"7 I will always love you",@"8 black or white"],
            @"waterFlow":@[
                    @(170),@(80),@(190),@(100),
                    @(110),@(200),@(130),
                    @(40),@(150),@(60),
            ],
        };
    }
    return self;
}

- (BOOL)shouldLoadMore{
    return NO;
}

// 这里使用refresh来模拟网络加载
- (void)refresh{
    [super refresh];
    [self.dataSource clear];
    
    [self setupComponents:videoData];
    
    [self.collectionView reloadData];
}

// 真正业务中是实现如下方法
- (__kindof YTKRequest *)fetchModuleRequest{
    // 1.返回当前module的网络请求
    return nil;
}

- (void)parseModuleDataWithRequest:(__kindof YTKRequest *)request{
    // 2.根据request中的数据来进行component的组装
    [self setupComponents:videoData];
}

- (void) setupComponents:(NSDictionary *)data{
    
    [self.dataSource addComponent:({
        VideoCategoryComponent * comp = [VideoCategoryComponent new];
        [comp addDatas:data[@"category"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        VideoFilmComponent * comp = [VideoFilmComponent new];
        [comp addDatas:data[@"film"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        VideoRankComponent * comp = [VideoRankComponent new];
        [comp addDatas:data[@"rank"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        VideoComponent * comp = [VideoComponent new];
        [comp addDatas:data[@"video"]];
        comp;
    })];
    
    return;
    
    [self.dataSource addComponent:({
        VideoBannerComponent * comp = [VideoBannerComponent new];
        [comp addDatas:data[@"banner"]];
        comp;
    })];
    
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.arrange = QLLiveComponentArrangeHorizontal;
    //        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:40];
    //        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:6];
    //        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
    //            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
    //            [cell setupWithData:data];
    //        }];
    //        [comp addDatas:[data[@"languages"] ease_randomObjects]];
    //        comp;
    //    })];
    ////
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
    //        comp.needPlacehold = YES;
    //        comp.layout.placeholdHeight = 100;
    //        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
    //        comp;
    //    })];
    ////
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
    //        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
    //        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
    //            [cell setupWithData:data];
    //            // 由于复用，所以这段代码下载setupWithData下面
    //            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#B2E7F9"];
    //        }];
    //        [comp addDatas:[data[@"weather"] ease_randomObjects]];
    //        comp;
    //    })];
    ////
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.layout.insets = UIEdgeInsetsMake(0, 5, 0, 5);
    //        comp.arrange = QLLiveComponentArrangeHorizontal;
    //        comp.layout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.3];
    //        [comp addDatas:[data[@"city"] ease_randomObjects]];
    //        comp;
    //    })];
    //
    //    [self.dataSource addComponent:({
    //        // 这个component是用来做标签效果的，
    //        // 如果要定制居左需要在初始化UICollectionView的时候设置对应的layout
    //        // 将上面的 [[UICollectionViewFlowLayout alloc] init] 进行替换
    //        YYYTwoComponent * comp = [YYYTwoComponent new];
    //        [comp addDatas:[data[@"Cocoa"] ease_randomObjects]];
    //        comp;
    //    })];
    ////return;
    //    [self.dataSource addComponent:({
    //        YYYThreeComponent * comp = [[YYYThreeComponent alloc] initWithTitle:@"Word"];
    //        [comp addDatas:[data[@"word"] ease_randomObjects]];
    //        comp;
    //    })];
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.arrange = QLLiveComponentArrangeHorizontal;
    //        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
    //        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
    //        comp.layout.distribution = [QLLiveLayoutDistribution absoluteDimension:90];
    //        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
    //            [cell setupWithData:data];
    //            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
    //        }];
    //        [comp addDatas:[data[@"video"] ease_randomObjects]];
    //        comp;
    //    })];
    //    [self.dataSource addComponent:({
    //        YYYThreeComponent * comp = [[YYYThreeComponent alloc] initWithTitle:@"Number"];
    //        comp.layout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.6];
    //        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
    //        [comp addDatas:[data[@"number"] ease_randomObjects]];
    //        comp;
    //    })];
    //    [self.dataSource addComponent:({
    //        YYYFourComponent * comp = [[YYYFourComponent alloc] initWithTitle:@"Music"];
    //        [comp addDatas:[data[@"music"] ease_randomObjects]];
    //        comp;
    //    })];
    //    [self.dataSource addComponent:({
    //        YYYOneComponent * comp = [YYYOneComponent new];
    //        comp.arrange = QLLiveComponentArrangeHorizontal;
    //        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
    //        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
    //        comp.layout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.3];
    //        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
    //            [cell setupWithData:data];
    //            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
    //        }];
    //        [comp addDatas:[data[@"company"] ease_randomObjects]];
    //        comp;
    //    })];
    //    [self.dataSource addComponent:({
    //        YYYFiveComponent * comp = [[YYYFiveComponent alloc] initWithTitle:@"waterFlow"];
    //        [comp addDatas:[data[@"waterFlow"] ease_randomObjects]];
    //        comp;
    //    })];
}
@end
