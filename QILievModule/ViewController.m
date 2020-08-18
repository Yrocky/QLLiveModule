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

@interface YYYBaseComponent : QLLiveComponent
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

@interface YYYOneCCell : UICollectionViewCell
@property (nonatomic ,strong) UILabel * oneLabel;
- (void) setupWithData:(id)data;
@end

@interface YYYPlaceholdCCell : UICollectionViewCell
@end

@interface YYYOneComponent : YYYBaseComponent
@property (nonatomic ,copy) void(^bSetupCell)(__kindof UICollectionViewCell * cell, id data);
@end

@interface YYYTwoComponent : YYYBaseComponent<QLLiveComponentLayoutDelegate>
@end

@interface YYYThreeComponent : YYYBaseComponent{
    NSString *_title;
}
- (instancetype) initWithTitle:(NSString *)title;
@end

@interface YYYFourComponent : YYYThreeComponent<QLLiveComponentLayoutDelegate>
@end

@interface YYYFiveComponent : YYYThreeComponent<QLLiveComponentLayoutDelegate>
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
            @"languages":@[@"#swift#",@"#java#",@"#js#",@"#vue#",@"#ruby#",@"#css#",@"#go#"],
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
    
    temp_flag ++;
    
    return;
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.arrange = QLLiveComponentArrangeHorizontal;
        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:40];
        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:6];
        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
            [cell setupWithData:data];
        }];
        [comp addDatas:[data[@"languages"] ease_randomObjects]];
        comp;
    })];
//
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
        comp.needPlacehold = YES;
        comp.layout.placeholdHeight = 100;
        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
        comp;
    })];
//
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
            [cell setupWithData:data];
            // 由于复用，所以这段代码下载setupWithData下面
            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#B2E7F9"];
        }];
        [comp addDatas:[data[@"weather"] ease_randomObjects]];
        comp;
    })];
//
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.layout.insets = UIEdgeInsetsMake(0, 5, 0, 5);
        comp.arrange = QLLiveComponentArrangeHorizontal;
        comp.layout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.3];
        [comp addDatas:[data[@"city"] ease_randomObjects]];
        comp;
    })];

    [self.dataSource addComponent:({
        // 这个component是用来做标签效果的，
        // 如果要定制居左需要在初始化UICollectionView的时候设置对应的layout
        // 将上面的 [[UICollectionViewFlowLayout alloc] init] 进行替换
        YYYTwoComponent * comp = [YYYTwoComponent new];
        [comp addDatas:[data[@"Cocoa"] ease_randomObjects]];
        comp;
    })];
//return;
    [self.dataSource addComponent:({
        YYYThreeComponent * comp = [[YYYThreeComponent alloc] initWithTitle:@"Word"];
        [comp addDatas:[data[@"word"] ease_randomObjects]];
        comp;
    })];
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.arrange = QLLiveComponentArrangeHorizontal;
        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
        comp.layout.distribution = [QLLiveLayoutDistribution absoluteDimension:90];
        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
            [cell setupWithData:data];
            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
        }];
        [comp addDatas:[data[@"video"] ease_randomObjects]];
        comp;
    })];
    [self.dataSource addComponent:({
        YYYThreeComponent * comp = [[YYYThreeComponent alloc] initWithTitle:@"Number"];
        comp.layout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:0.6];
        comp.layout.distribution = [QLLiveLayoutDistribution distributionValue:4];
        [comp addDatas:[data[@"number"] ease_randomObjects]];
        comp;
    })];
    [self.dataSource addComponent:({
        YYYFourComponent * comp = [[YYYFourComponent alloc] initWithTitle:@"Music"];
        [comp addDatas:[data[@"music"] ease_randomObjects]];
        comp;
    })];
    [self.dataSource addComponent:({
        YYYOneComponent * comp = [YYYOneComponent new];
        comp.arrange = QLLiveComponentArrangeHorizontal;
        comp.layout.insets = UIEdgeInsetsMake(0, 5, 5, 5);
        comp.layout.itemRatio = [QLLiveLayoutItemRatio absoluteValue:50];
        comp.layout.distribution = [QLLiveLayoutDistribution fractionalDimension:0.3];
        [comp setBSetupCell:^(YYYOneCCell *cell, id data) {
            [cell setupWithData:data];
            cell.oneLabel.textColor = [UIColor colorWithHexString:@"#CB2EFF"];
        }];
        [comp addDatas:[data[@"company"] ease_randomObjects]];
        comp;
    })];
    [self.dataSource addComponent:({
        YYYFiveComponent * comp = [[YYYFiveComponent alloc] initWithTitle:@"waterFlow"];
        [comp addDatas:[data[@"waterFlow"] ease_randomObjects]];
        comp;
    })];
}
@end

@implementation YYYBaseComponent
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hiddenWhenEmpty = YES;
    }
    return self;
}
- (void)didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"[component] did selected:%@ at:%ld",[self dataAtIndex:index],(long)index);
}
@end

@implementation YYYOneComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layout.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.layout.lineSpacing = 5;
        self.layout.interitemSpacing = 5;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    YYYOneCCell * ccell = [self.dataSource dequeueReusableCellOfClass:YYYOneCCell.class forComponent:self atIndex:index];
    if (self.bSetupCell) {
        self.bSetupCell(ccell, ({
            [NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]];
        }));
    } else {
        [ccell setupWithData:({
            [NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]];
        })];
    }
    return ccell;
}

- (UICollectionViewCell *)placeholdCellForItemAtIndex:(NSInteger)index{
    YYYPlaceholdCCell * ccell = [self.dataSource dequeueReusablePlaceholdCellOfClass:YYYPlaceholdCCell.class forComponent:self];
    return ccell;
}

@end

@implementation YYYOneCCell{
    UIImageView *_demoMaskImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
//        self.contentView.layer.cornerRadius = 4.0f;
//        self.contentView.layer.masksToBounds = YES;
        self.oneLabel = [UILabel new];
        self.oneLabel.textAlignment = NSTextAlignmentCenter;
        self.oneLabel.numberOfLines = 2;
        self.oneLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:self.oneLabel];
        
        _demoMaskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask_image_none_space_white"]];
        _demoMaskImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_demoMaskImageView];
        
        [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.left.equalTo(self.contentView).mas_offset(5);
            make.right.equalTo(self.contentView).mas_offset(-5);
        }];
        
        [_demoMaskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void) setupWithData:(NSString *)data{
    self.oneLabel.text = [NSString stringWithFormat:@"%@",data];
    self.oneLabel.textColor = [UIColor colorWithHexString:@"#FF6A66"];
}
@end

@implementation YYYPlaceholdCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                
        UIImageView *demoMaskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask_image_none_space_white"]];
        demoMaskImageView.contentMode = UIViewContentModeScaleToFill;
        demoMaskImageView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [self.contentView addSubview:demoMaskImageView];

        UILabel * oneLabel = [UILabel new];
        oneLabel.textAlignment = NSTextAlignmentCenter;
        oneLabel.text = @"今日门票已经售罄";
        oneLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        oneLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:oneLabel];
        
        [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.left.equalTo(demoMaskImageView).mas_offset(5);
            make.right.equalTo(demoMaskImageView).mas_offset(-5);
        }];
        
        [demoMaskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 5, 0, 5));
        }];
    }
    return self;
}
@end

@interface YYYTwoCCell : UICollectionViewCell
- (void) setupWithData:(id)data;
@end

@implementation YYYTwoComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layout.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.layout.lineSpacing = 5;
        self.layout.interitemSpacing = 5;
        self.layout.customItemSize = self;
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    YYYTwoCCell * ccell = [self.dataSource dequeueReusableCellOfClass:YYYTwoCCell.class forComponent:self atIndex:index];
    [ccell setupWithData:({
        [NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]];
    })];
    return ccell;
}

#pragma mark - QLLiveComponentLayoutDelegate

- (CGSize)componentLayoutCustomItemSize:(QLLiveComponentLayout *)layout atIndex:(NSInteger)index{
    
    NSString * record = [self dataAtIndex:index];
    CGSize size = [record YYY_sizeWithFont:[UIFont systemFontOfSize:12]
                                   maxSize:CGSizeMake(CGFLOAT_MAX, 30)];
    size.width = size.width + 30;///30 是字体的左右间距
    size.height = 30;
    return size;
}
@end

@implementation YYYTwoCCell{
    UILabel * twoLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        twoLabel = [UILabel new];
        twoLabel.textAlignment = NSTextAlignmentCenter;
        twoLabel.font = [UIFont systemFontOfSize:12];
        twoLabel.textColor = [UIColor colorWithHexString:@"#FF8D00"];
        [self.contentView addSubview:twoLabel];
        
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void) setupWithData:(NSString *)data{
    twoLabel.text = data;
}

@end

@interface YYYThreeHeaderView : UICollectionReusableView

- (void) setupHeaderTitle:(NSString *)title;
@end
@implementation YYYThreeComponent

- (instancetype) initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _title = title;
        self.layout.insets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.layout.lineSpacing = 5;
        self.layout.interitemSpacing = 5;
        self.layout.distribution = [QLLiveLayoutDistribution distributionValue:2];
        self.layout.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:2.0];
    }
    return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    YYYOneCCell * ccell = [self.dataSource dequeueReusableCellOfClass:YYYOneCCell.class forComponent:self atIndex:index];
    [ccell setupWithData:({
        [NSString stringWithFormat:@"%d %@",index,[self dataAtIndex:index]];
    })];
    return ccell;
}

- (NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    if (elementKind == UICollectionElementKindSectionHeader) {
        
        YYYThreeHeaderView *view = [self.dataSource dequeueReusableSupplementaryViewOfKind:elementKind forComponent:self clazz:YYYThreeHeaderView.class atIndex:index];
        [view setupHeaderTitle:[NSString stringWithFormat:@"%@(%lu)",_title,(unsigned long)[self.datas count]]];
        return view;
    }
    return nil;
}

- (CGSize) sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    if (elementKind == UICollectionElementKindSectionHeader) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 48);
    }
    return CGSizeZero;
}

@end

@implementation YYYThreeHeaderView{
    UILabel * titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        
        titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(16);
            make.height.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
- (void) setupHeaderTitle:(NSString *)title{
    titleLabel.text = title;
}
@end

@implementation YYYFourComponent

- (instancetype) initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        self.layout.customItemSize = self;
        self.layout.distribution = [QLLiveLayoutDistribution distributionValue:3];
    }
    return self;
}

#pragma mark - QLLiveComponentLayoutDelegate

- (CGSize)componentLayoutCustomItemSize:(QLLiveComponentLayout *)layout atIndex:(NSInteger)index{
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat halfContainerWidth = (layout.insetContainerWidth - layout.interitemSpacing) * 0.5;
    if (index == 0) {
        width = halfContainerWidth;
    } else {
        width = (halfContainerWidth - layout.interitemSpacing) * 0.5;
    }
    height = width;

    return CGSizeMake(width, height);
}
@end

@implementation YYYFiveComponent

- (instancetype) initWithTitle:(NSString *)title{
    self = [super initWithTitle:title];
    if (self) {
        self.layout.customItemSize = self;
        self.layout.distribution = [QLLiveLayoutDistribution distributionValue:2];
    }
    return self;
}

#pragma mark - QLLiveComponentLayoutDelegate

- (CGSize)componentLayoutCustomItemSize:(QLLiveComponentLayout *)layout atIndex:(NSInteger)index{
    
    CGFloat width = 0;
    CGFloat height = 0;
    // 这里的distribution不推荐使用absolute、fractional
    if (layout.distribution.isAbsolute) {
        width = layout.distribution.value;
    } else if (layout.distribution.isFractional) {
        width = layout.insetContainerWidth * layout.distribution.value;
    } else {
        width = (layout.insetContainerWidth - layout.interitemSpacing * (layout.distribution.value - 1)) / layout.distribution.value;
    }
    height = [[self dataAtIndex:index] integerValue];
    
    return CGSizeMake(width, height);
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
