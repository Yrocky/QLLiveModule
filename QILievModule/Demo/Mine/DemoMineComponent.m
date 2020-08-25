//
//  VideoMineComponent.m
//  QILievModule
//
//  Created by rocky on 2020/8/24.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "DemoMineComponent.h"
#import "DemoMineCCell.h"
#import "QLLiveListLayout.h"

@implementation MineInfoComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        QLLiveListLayout * layout = [QLLiveListLayout new];
//        layout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.distribution = [QLLiveLayoutDistribution distributionValue:1];
        layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:120];

        _layout = layout;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    DemoMineInfoCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoMineInfoCCell.class forComponent:self atIndex:index];
    
    return ccell;
}
@end

@implementation MineListComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        QLLiveListLayout * layout = [QLLiveListLayout new];
        layout.inset = UIEdgeInsetsMake(10, 20, 10, 20);
        layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
        layout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.8];
        [self addBackgroundDecorate:^(id<QLLiveComponentBackgroundDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentBackgroundDecorateOnlyItem;
            builder.radius = 4.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentBackgroundDecorateContents * contents =
                [QLLiveComponentBackgroundDecorateContents colorContents:[UIColor colorWithHexString:@"#ffffff"]];
                contents.shadowColor = [UIColor colorWithHexString:@"c0c4c3"];
                contents.shadowOffset = CGSizeMake(0, 0);
                contents.shadowOpacity = 0.5;
                contents.shadowRadius = 3;
                contents;
            });
        }];
        _layout = layout;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    DemoMineAccountCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoMineAccountCCell.class forComponent:self atIndex:index];
    
    return ccell;
}
@end

@implementation MineBannerComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        QLLiveListLayout * layout = [QLLiveListLayout new];
        layout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.distribution = [QLLiveLayoutDistribution distributionValue:1];
        layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:110];
        _layout = layout;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    DemoMineBannerCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoMineBannerCCell.class forComponent:self atIndex:index];
    return ccell;
}
@end

@implementation MineFunctionComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        QLLiveListLayout * layout = [QLLiveListLayout new];
        layout.inset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
        layout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.8];
        _layout = layout;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    DemoMineFuncCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoMineFuncCCell.class forComponent:self atIndex:index];
    return ccell;
}
@end
