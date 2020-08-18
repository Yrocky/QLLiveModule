//
//  ViewController.m
//  QILievModule
//
//  Created by rocky on 2020/8/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Sugar.h"
#import "UIColor+Common.h"
#import "NSString+Common.h"

static NSInteger temp_flag = 0;

@interface ViewController ()
@end

@implementation ViewController
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
                    @(170),@(80),@(190),@(100),
                    @(110),@(130),@(130),
                    @(90),@(150),@(60),
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
    
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：flex-start"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutFlexStart;
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：center"];
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutCenter;
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
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];

    [self.dataSource addComponent:({
        DemoFlexComponent * comp = [[DemoFlexComponent alloc] initWithTitle:@"QLLiveFlexLayout：orthogonal scroll"];
//        comp.arrange = QLLiveComponentArrangeHorizontal;
        [comp setupFlexLayout:({
            QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
            flexLayout.justifyContent = QLLiveFlexLayoutFlexStart;
            flexLayout;
        })];
        [comp addDatas:data[@"flex"]];
        comp;
    })];

    [self.dataSource addComponent:({
        DemoListComponent * comp = [[DemoListComponent alloc] initWithTitle:@"QLLiveListLayout：table-view like"];
        [comp setupListLayout:({
            QLLiveListLayout * listLayout = [QLLiveListLayout new];
            listLayout.lineSpacing = 0.5f;
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
            listLayout.insets = UIEdgeInsetsMake(0, 10, 0, 10);
            listLayout.distribution = [QLLiveLayoutDistribution distributionValue:3];
            listLayout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.8];
            listLayout;
        })];
        [comp addDatas:data[@"music"]];
        comp;
    })];

    [self.dataSource addComponent:({
        DemoListComponent * comp = [[DemoListComponent alloc] initWithTitle:@"QLLiveListLayout：orthogonal scroll"];
//        comp.arrange = QLLiveComponentArrangeHorizontal;
        [comp setupListLayout:({
            QLLiveListLayout * listLayout = [QLLiveListLayout new];
            listLayout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.55];
            listLayout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
            listLayout;
        })];
        [comp addDatas:data[@"music"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：shortest first"];
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
    [self.dataSource addComponent:({
        DemoWaterfallComponent * comp = [[DemoWaterfallComponent alloc] initWithTitle:@"QLLiveWaterfallLayout：orthogonal scroll"];
//        comp.arrange = QLLiveComponentArrangeHorizontal;
        [comp setupWaterfallLayout:({
            QLLiveWaterfallLayout * waterfallLayout = [QLLiveWaterfallLayout new];
            waterfallLayout.column = 3;
            waterfallLayout.renderDirection = QLLiveWaterfallItemRenderRightToLeft;
            waterfallLayout;
        })];
        [comp addDatas:data[@"waterFlow"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：only item"];
        comp.decorateType = QLLiveComponentBackgroundDecorateOnlyItem;
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：contain header"];
        comp.decorateType = QLLiveComponentBackgroundDecorateContainHeader;
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：all"];
        comp.decorateType = QLLiveComponentBackgroundDecorateAll;
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    
    [self.dataSource addComponent:({
        DemoBackgroundDecorateComponent * comp = [[DemoBackgroundDecorateComponent alloc] initWithTitle:@"BackgroundDecorate：contain footer"];
        comp.decorateType = QLLiveComponentBackgroundDecorateContainFooter;
        [comp addDatas:data[@"languages"]];
        comp;
    })];
    temp_flag ++;
}
@end

@implementation DemoBaseComponent{
    NSString *_title;
}

- (instancetype) initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.decorateType = QLLiveComponentBackgroundDecorateNone;
        _title = title;
    }
    return self;
}

- (NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind{
    if (elementKind == UICollectionElementKindSectionHeader) {
        
        DemoHeaderView *view = [self.dataSource dequeueReusableSupplementaryViewOfKind:elementKind forComponent:self clazz:DemoHeaderView.class];
        view.titleLabel.textColor = [UIColor redColor];
        [view setupHeaderTitle:[NSString stringWithFormat:@"%@",_title]];
        return view;
    }
    return nil;
}

- (CGSize) sizeForSupplementaryViewOfKind:(NSString *)elementKind{
    if (elementKind == UICollectionElementKindSectionHeader) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 45);
    }
    return CGSizeZero;
}
@end

@implementation DemoPlaceholdComponent

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        QLLiveFlexLayout * flexLayout = [QLLiveFlexLayout new];
        flexLayout.itemHeight = 30.0f;
        flexLayout.justifyContent = QLLiveFlexLayoutFlexStart;
        flexLayout.delegate = self;
        _n3wLayout = flexLayout;
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
    flexLayout.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    flexLayout.itemHeight = 30;
    flexLayout.delegate = self;
    _n3wLayout = flexLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{

    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:12];
    [ccell setupWithData:@""];
    return ccell;
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
    _n3wLayout = listLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{

    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 0.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:16];
    [ccell setupWithData:[self dataAtIndex:index]];
    return ccell;
}
@end

@implementation DemoWaterfallComponent

- (void) setupWaterfallLayout:(QLLiveWaterfallLayout *)waterfallLayout{
    waterfallLayout.delegate = self;
    _n3wLayout = waterfallLayout;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{

    DemoContentCCell * ccell = [self.dataSource dequeueReusableCellOfClass:DemoContentCCell.class forComponent:self atIndex:index];
    ccell.contentView.layer.cornerRadius = 4.0f;
    ccell.oneLabel.font = [UIFont systemFontOfSize:16];
    [ccell setupWithData:[NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]]];
    return ccell;
}

#pragma mark - QLLiveWaterfallLayoutDelegate

- (CGSize)layoutCustomItemSize:(QLLiveWaterfallLayout *)layout atIndex:(NSInteger)index{
    CGFloat itemHeight = [[self dataAtIndex:index] floatValue];
    return CGSizeMake(100, itemHeight);
}

@end

@implementation DemoBackgroundDecorateComponent

- (instancetype)initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        self.backgroundDecorateColor = [UIColor colorWithHexString:@"f3f3f3"];
        self.backgroundDecorateRadius = 4.0f;
        QLLiveListLayout * listLayout = [QLLiveListLayout new];
        listLayout.insets = UIEdgeInsetsMake(0, 10, 0, 10);
        listLayout.distribution = [QLLiveLayoutDistribution distributionValue:3];
        listLayout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:183.0/267.0];
        _n3wLayout = listLayout;
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

- (NSArray<NSString *> *)supportedElementKinds{
    return @[
        UICollectionElementKindSectionHeader,
        UICollectionElementKindSectionFooter
    ];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [super viewForSupplementaryElementOfKind:elementKind];
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
    return CGSizeMake(200, 50);
}

- (UIEdgeInsets) insetForSupplementaryViewOfKind:(NSString *)elementKind{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
@end
