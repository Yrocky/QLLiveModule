//
//  ViewController.m
//  Example-OC
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "ViewController.h"
#import <QLLiveModuler/QLLiveModuler.h>
#import "DemoContentCCell.h"

#import "NSArray+Sugar.h"
#import "UIColor+Common.h"
#import "NSString+Common.h"

@interface ViewController ()
@end

@implementation ViewController
@end

@implementation DemoModule

static NSDictionary * demoData;

- (instancetype)initWithName:(NSString *)name{
    self = [super initWithName:name];
    if (self) {
        demoData = @{
            @"flex":@[
                    @"google",@"facebook",@"youtube",
                    @"amazon",@"apple",@"Microsoft",
                    @"Alphabet",@"IBM"
            ],
            @"languages":@[
                    @"#swift#",
                    @"#java#",
                    @"#js#"
            ],
            @"weather":@[@"晴天",@"阴天",@"雨天",@"大风",@"雷电",@"冰雹",@"大雪",@"小雪"],
            @"city":@[
                    @"上海",
                    @"北京",
                    @"广州",
                    @"杭州",
                    @"深圳",
                    @"南京",
                    @"郑州",
                    @"武汉",
                    @"西安"
            ],
            @"Cocoa":@[@"NSObject",@"UIView",@"UIImageView",@"UILabel",@"CALayer",@"NSRunloop"],
            @"word":@[@"a",@"b",@"c",@"d",@"e"],
            @"video":@[@"爱奇艺",@"腾讯视频",@"优酷",@"西瓜视频",@"哔哩哔哩"],
            @"number":@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"],
            @"company":@[@"google",@"facebook",@"youtube",@"amazon",@"apple",@"Microsoft",@"Alphabet",@"IBM"],
            @"music":@[
                    @"0 Love of My Life",
                    @"1 Thank You",
                    @"2 Yesterday Once More",
                    @"3 You Are Not Alone",
                    @"4 Billie Jean",
                    @"5 Smooth Criminal",
                    @"6 Earth Song",
                    @"7 I will always love you",
                    @"8 black or white"
            ],
            @"waterFlow":@[
                    @(170),@(180),@(190),@(100),
                    @(110),@(135),@(130),
                    @(90),@(155),@(65),
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
    
    [self setupComponents:demoData];
    
    [self.collectionView reloadData];
}

// 真正业务中是实现如下方法
- (__kindof YTKRequest *)fetchModuleRequest{
    // 1.返回当前module的网络请求
    return nil;
}

- (void)parseModuleDataWithRequest:(__kindof YTKRequest *)request{
    // 2.根据request中的数据来进行component的组装
    [self setupComponents:demoData];
}

- (void) setupComponents:(NSDictionary *)data{
    
    //    [self.dataSource addComponent:({
    //        DemoPlaceholdComponent * comp = [[DemoPlaceholdComponent alloc] initWithTitle:@"placehold"];
    //        comp.needPlacehold = YES;
    //        if (temp_flag % 2) {
    //            [comp addDatas:data[@"city"]];
    //        }
    //        comp;
    //    })];
}
@end

@interface DemoBaseComponent : QLLiveComponent
- (instancetype) initWithTitle:(NSString *)title;
@end

@interface DemoPlaceholdComponent : DemoBaseComponent<QLLiveFlexLayoutDelegate>
@end

@interface DemoFlexComponent : DemoBaseComponent<QLLiveFlexLayoutDelegate>
- (void) setupFlexLayout:(QLLiveFlexLayout *)flexLayout;
@end

@interface DemoListComponent : DemoBaseComponent
- (void) setupListLayout:(QLLiveListLayout *)listLayout;
@end

@interface DemoWaterfallComponent : DemoBaseComponent<QLLiveWaterfallLayoutDelegate>
- (void) setupWaterfallLayout:(QLLiveWaterfallLayout *)waterfallLayout;
@end

@interface DemoBackgroundDecorateComponent : DemoBaseComponent
@end


@implementation DemoFlexLayoutModule

- (void)setupComponents:(NSDictionary *)data{
    
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：orthogonal scroll"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.arrange = QLLiveLayoutArrangeHorizontal;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：flex-start"];
        comp.headerPin = YES;
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutFlexStart;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：center"];
//        comp.headerPin = YES;
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutCenter;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：flex-end"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutFlexEnd;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：space-around"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutSpaceAround;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：space-between"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutSpaceBetween;
            flexLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
}
@end

@implementation DemoListLayoutModule

- (void)setupComponents:(NSDictionary *)data{
    
    [self.dataSource addComponent:({
        DemoListComponent * comp = [[DemoListComponent alloc] initWithTitle:@"QLLiveListLayout：orthogonal scroll"];
        [comp setupListLayout:({
            QLLiveListLayout * listLayout = [QLLiveListLayout new];
            listLayout.arrange = QLLiveLayoutArrangeHorizontal;
            listLayout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
            listLayout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.55];
            listLayout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
            listLayout.row = 3;
            listLayout;
        })];
        [comp addDatas:data[@"music"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoListComponent * comp = [[DemoListComponent alloc] initWithTitle:@"QLLiveListLayout：table-view like"];
        [comp setupListLayout:({
            QLLiveListLayout * listLayout = [QLLiveListLayout new];
            listLayout.lineSpacing = 0.5f;
            listLayout.inset = UIEdgeInsetsMake(0, 0, 0, 0);
            listLayout.distribution = [QLLiveLayoutDistribution distributionValue:1];
            listLayout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:44.0f];
            listLayout;
        })];
        [comp addDatas:data[@"music"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoListComponent * comp = [[DemoListComponent alloc] initWithTitle:@"QLLiveListLayout：collection-view like"];
        [comp setupListLayout:({
            QLLiveListLayout * listLayout = [QLLiveListLayout new];
            listLayout.inset = UIEdgeInsetsMake(0, 10, 0, 10);
            listLayout.distribution = [QLLiveLayoutDistribution distributionValue:3];
            listLayout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.8];
            listLayout;
        })];
        [comp addDatas:data[@"music"]];
        comp;
    })];
}

@end

@implementation DemoWaterfallLayoutModule

- (void)setupComponents:(NSDictionary *)data{
    
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：orthogonal scroll"];
        [comp setupWaterfallLayout:({
            QLLiveWaterfallLayout * waterfallLayout = [QLLiveWaterfallLayout new];
            waterfallLayout.row = 3;
            waterfallLayout.horizontalArrangeContentHeight = 300;
            waterfallLayout.arrange = QLLiveLayoutArrangeHorizontal;
            waterfallLayout.renderDirection = QLLiveWaterfallItemRenderBottomToTop;
            waterfallLayout;
        })];
        [comp addDatas:data[@"waterFlow"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：shortest first"];
        comp.headerPin = YES;
        [comp setupWaterfallLayout:({
            QLLiveWaterfallLayout * waterfallLayout = [QLLiveWaterfallLayout new];
            waterfallLayout.column = 3;
            waterfallLayout.renderDirection = QLLiveWaterfallItemRenderShortestFirst;
            waterfallLayout;
        })];
        [comp addDatas:data[@"waterFlow"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：left to right"];
        [comp setupWaterfallLayout:({
            QLLiveWaterfallLayout * waterfallLayout = [QLLiveWaterfallLayout new];
            waterfallLayout.column = 3;
            waterfallLayout.renderDirection = QLLiveWaterfallItemRenderLeftToRight;
            waterfallLayout;
        })];
        [comp addDatas:data[@"waterFlow"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：right to left"];
        [comp setupWaterfallLayout:({
            QLLiveWaterfallLayout * waterfallLayout = [QLLiveWaterfallLayout new];
            waterfallLayout.column = 3;
            waterfallLayout.renderDirection = QLLiveWaterfallItemRenderRightToLeft;
            waterfallLayout;
        })];
        [comp addDatas:data[@"waterFlow"]];
        comp;
    })];
}
@end

@implementation DemoBackgroundDecorateModule

- (void)setupComponents:(NSDictionary *)data{
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：image"];
        comp.layout.inset = UIEdgeInsetsMake(100, 20, 10, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 10.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents imageContents:[UIImage imageNamed:@"forbid"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：image"];
        comp.layout.inset = UIEdgeInsetsMake(10, 20, 130, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 10.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents imageContents:[UIImage imageNamed:@"the_Great_Wall"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：gradient"];
        comp.layout.inset = UIEdgeInsetsMake(10, 20, 10, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 4.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents gradientContents:^(id<QLLiveComponentDecorateGradientContentsAble>  _Nonnull contents) {
                    contents.startPoint = CGPointMake(0.5, 0);
                    contents.endPoint = CGPointMake(0.5, 1);
                    contents.colors = @[
                        [UIColor colorWithHexString:@"#FF9E5C"],
                        [UIColor colorWithHexString:@"#FF659F"]
                    ];
                    contents.locations = @[@(0), @(1.0f)];
                }];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：only item"];
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 4.0f;
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：contain header"];
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateContainHeader;
            builder.radius = 4.0f;
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：all"];
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateAll;
            builder.radius = 4.0f;
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：contain footer"];
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateContainFooter;
            builder.radius = 4.0f;
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：only item & insets"];
        comp.layout.inset = UIEdgeInsetsMake(10, 20, 10, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 4.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：all & insets"];
        comp.layout.inset = UIEdgeInsetsMake(10, 20, 10, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateAll;
            builder.radius = 4.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            builder.contents = ({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor colorWithHexString:@"#8091a5"]];
                contents;
            });
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：shadow"];
        comp.layout.inset = UIEdgeInsetsMake(10, 20, 10, 20);
        [comp addBackgroundDecorate:^(id<QLLiveComponentDecorateAble>  _Nonnull builder) {
            builder.type = QLLiveComponentDecorateOnlyItem;
            builder.radius = 4.0f;
            builder.inset = UIEdgeInsetsMake(0, -10, 0, -10);
            [builder setContents:({
                QLLiveComponentDecorateContents * contents =
                [QLLiveComponentDecorateContents colorContents:[UIColor whiteColor]];
                contents.shadowColor = [UIColor redColor];
                contents.shadowOffset = CGSizeMake(0, 0);
                contents.shadowOpacity = 0.5;
                contents.shadowRadius = 3;
                contents;
            })];
        }];
        [comp addDatas:data[@"languages"]];
        comp;
    })];
}
@end


@implementation DemoBaseComponent{
    NSString *_title;
}

- (instancetype) initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (NSArray<NSString *> *)supportedElementKinds{
    return @[
        UICollectionElementKindSectionHeader,
        UICollectionElementKindSectionFooter
    ];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind{
    if (elementKind == UICollectionElementKindSectionHeader) {
        
        DemoHeaderView *view = [self.dataSource dequeueReusableSupplementaryViewOfKind:elementKind forComponent:self clazz:DemoHeaderView.class];
        view.titleLabel.textColor = [UIColor redColor];
        [view setupHeaderTitle:[NSString stringWithFormat:@"%@",_title]];
        return view;
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        DemoFooterView * footerView =
        [self.dataSource dequeueReusableSupplementaryViewOfKind:elementKind forComponent:self clazz:DemoFooterView.class];
        return footerView;
    }
    return nil;
}
- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        return CGSizeMake(200, 30);
    }
    return CGSizeMake(200, 45);
}

//- (UIEdgeInsets) insetForSupplementaryViewOfKind:(NSString *)elementKind{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}

@end

@implementation DemoPlaceholdComponent

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
        flexLayout.itemHeight = 30.0f;
        flexLayout.justifyContent = QLLiveFlexLayoutFlexStart;
        flexLayout.delegate = self;
        _layout = flexLayout;
    }
    return self;;
}
- (__kindof UICollectionViewCell *)placeholdCellForItemAtIndex:(NSInteger)index{
    
    DemoPlaceholdCCell * ccell = [self.dataSource dequeueReusablePlaceholdCellOfClass:DemoPlaceholdCCell.class forComponent:self];
    return ccell;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:15];
    [ccell setupWithData:[self dataAtIndex:index]];
    return ccell;
}
#pragma mark - QLLiveFlexLayoutDelegate

- (CGSize)layoutCustomItemSize:(QLLiveFlexLayout *)layout atIndex:(NSInteger)index{
    NSString * category = [self dataAtIndex:index];
    CGSize size = [category YYY_sizeWithFont:[UIFont systemFontOfSize:15]
                                     maxSize:CGSizeMake(CGFLOAT_MAX, layout.itemHeight)];
    size.width = size.width + 30;///30 是字体的左右间距
    size.height = layout.itemHeight;
    return size;
}
@end

@implementation DemoFlexComponent

- (void) setupFlexLayout:(QLLiveFlexLayout *)flexLayout{
//    flexLayout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    flexLayout.itemHeight = 30;
    flexLayout.delegate = self;
    _layout = flexLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:12];
    [ccell setupWithData:@""];
    return ccell;
}

- (NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}
#pragma mark - QLLiveFlexLayoutDelegate

- (CGSize)layoutCustomItemSize:(QLLiveFlexLayout *)layout atIndex:(NSInteger)index{
    NSString * category = [self dataAtIndex:index];
    CGSize size = [category YYY_sizeWithFont:[UIFont systemFontOfSize:12]
                                     maxSize:CGSizeMake(CGFLOAT_MAX, layout.itemHeight)];
    size.width = size.width + 30;///30 是字体的左右间距
    size.height = layout.itemHeight;
    return size;
}
@end

@implementation DemoListComponent

- (void) setupListLayout:(QLLiveListLayout *)listLayout{
    listLayout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    _layout = listLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 0.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:16];
    [ccell setupWithData:[self dataAtIndex:index]];
    return ccell;
}
- (NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}
@end

@implementation DemoWaterfallComponent

- (void) setupWaterfallLayout:(QLLiveWaterfallLayout *)waterfallLayout{
    waterfallLayout.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    waterfallLayout.delegate = self;
    _layout = waterfallLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:16];
    [ccell setupWithData:[NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]]];
    return ccell;
}
- (NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}
#pragma mark - QLLiveWaterfallLayoutDelegate

- (CGSize)layoutCustomItemSize:(QLLiveWaterfallLayout *)layout atIndex:(NSInteger)index{
    CGFloat itemHeight = [[self dataAtIndex:index] floatValue];
    if (layout.arrange == QLLiveLayoutArrangeHorizontal) {
        return CGSizeMake(itemHeight, layout.itemHeight);
    }
    return CGSizeMake(layout.itemWidth, itemHeight);
}

@end

@implementation DemoBackgroundDecorateComponent

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        QLLiveListLayout * listLayout = [QLLiveListLayout new];
        listLayout.inset = UIEdgeInsetsMake(0, 10, 0, 10);
        listLayout.distribution = [QLLiveLayoutDistribution distributionValue:3];
        listLayout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:183.0/267.0];
        _layout = listLayout;
    }
    return self;;
}
- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:16];
    [ccell setupWithData:@""];
    ccell.contentView.backgroundColor = [UIColor colorWithHexString:@"#7CBDFF"];
    return ccell;
}

//- (NSArray<NSString *> *)supportedElementKinds{
//    return @[
//        UICollectionElementKindSectionHeader,
//        UICollectionElementKindSectionFooter
//    ];
//}
//
//- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind{
//    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//        return [super viewForSupplementaryElementOfKind:elementKind];
//    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
//        DemoFooterView * footerView =
//        [self.dataSource dequeueReusableSupplementaryViewOfKind:elementKind forComponent:self clazz:DemoFooterView.class];
//        return footerView;
//    }
//    return nil;
//}
//
//- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind{
//    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
//        return CGSizeMake(200, 30);
//    }
//    return CGSizeMake(200, 50);
//}
//
//- (UIEdgeInsets) insetForSupplementaryViewOfKind:(NSString *)elementKind{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}
@end
