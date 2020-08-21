//
//  QLLiveListLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveListLayout.h"
#import "QLLiveBaseLayout_Private.h"

typedef NS_ENUM(NSUInteger, QLLiveLayoutSemantic) {
    
    QLLiveLayoutSemanticNormal,
    
    QLLiveLayoutSemanticEmbed,
    QLLiveLayoutSemanticAbsolute,
    QLLiveLayoutSemanticFractional,
};

@interface QLLiveLayoutDistribution ()

@property (nonatomic, readwrite) CGFloat value;
@property (nonatomic) QLLiveLayoutSemantic semantic;

@property (nonatomic, readonly) BOOL isEmbed;
@property (nonatomic, readonly) BOOL isAbsolute;
@property (nonatomic, readonly) BOOL isFractional;
@end

@interface QLLiveLayoutItemRatio ()

@property (nonatomic, readwrite) CGFloat value;
@property (nonatomic) QLLiveLayoutSemantic semantic;

@end

@implementation QLLiveListLayout{
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.row = NSNotFound;
    }
    return self;
}

- (void) _calculatorItemSize{
    
    CGFloat width = 0;
    CGFloat height = 0;
    
    if (self.distribution.isAbsolute) {
        width = self.distribution.value;
    } else if (self.distribution.isFractional) {
        width = self.insetContainerWidth * MIN(1, self.distribution.value);
    } else {
        NSInteger count = MAX(1, self.distribution.value);
        width = (self.insetContainerWidth - (count - 1) * self.itemSpacing) / count;
    }
    // itemRatio -> height
    if (nil == self.itemRatio) {
        self.itemRatio = [QLLiveLayoutItemRatio itemRatioValue:1];
    }
    if (self.itemRatio.isAbsolute) {
        height = self.itemRatio.value;
    } else {
        height = width / MAX(0.01, self.itemRatio.value);
    }
    _itemWidth = width;
    _itemHeight = height;
}

#pragma mark - calculator Horizontal

- (void)calculatorHorizontalLayoutWithDatas:(NSArray *)datas{
    
    [self _calculatorItemSize];
    
    if (self.row != NSNotFound) {
        // 根据row计算出来 horizontalArrangeContentHeight
        self.horizontalArrangeContentHeight = ({
            self.row * _itemHeight +
            (self.row - 1) * self.lineSpacing;
        });
    } else if (self.horizontalArrangeContentHeight == 0.0f) {
        // 既没有设置 row 也没有设置 horizontalArrangeContentHeight
        NSLog(@"[layout]⚠️ 既没有设置 row 也没有设置 horizontalArrangeContentHeight");
        return;
    }
    
    // for safe
    _itemHeight = MIN(self.horizontalArrangeContentHeight, _itemHeight);
    
    CGFloat maxY = 0;
    CGFloat maxX = self.inset.left;
    BOOL lastOneNeedShift = NO;
    for (NSInteger index = 0; index < datas.count; index ++) {
        
        CGRect frame = (CGRect){
            maxX,maxY,
            (CGSizeMake(_itemWidth, _itemHeight))
        };
        lastOneNeedShift = CGRectGetMaxY(frame) > self.horizontalArrangeContentHeight;
        if (lastOneNeedShift) {
            // 需要换行
            maxY = 0;
            maxX += (_itemWidth + self.itemSpacing);
            frame.origin.x = maxX;
            frame.origin.y = maxY;
        }
        
        [self cacheItemFrame:frame at:index];
        // 更新y
        maxY += (_itemHeight + self.lineSpacing);
    }
    _contentWidth = CGRectGetMaxX([self itemFrameAtIndex:datas.count - 1]) - self.inset.left;
}

#pragma mark - calculator Vertical

- (void) calculatorVerticalLayoutWithDatas:(NSArray *)datas{
    
    [self _calculatorItemSize];

    __block CGFloat maxY = 0;
    __block CGFloat maxX = self.inset.left;
    
    for (NSInteger index = 0; index < datas.count; index ++) {
        CGFloat x = maxX;
        CGFloat y = maxY;
        CGRect frame = (CGRect){
            x,y,
            _itemWidth,_itemHeight
        };
        // cache
        [self cacheItemFrame:frame at:index];
        maxX += (_itemWidth + self.itemSpacing);
        if (maxX > self.insetContainerWidth) {
            maxX = self.inset.left;
            maxY += (_itemHeight + self.lineSpacing);
        }
        _contentHeight = CGRectGetMaxY(frame);
    }
    _contentHeight += self.inset.bottom;
}

@end

@implementation QLLiveLayoutDistribution

+ (instancetype)distributionValue:(NSInteger)value{
    return [[self alloc] initWithDistribution:(CGFloat)value
                                     semantic:QLLiveLayoutSemanticNormal];
}
+ (instancetype)absoluteDimension:(CGFloat)value{
    return [[self alloc] initWithDistribution:value
                                     semantic:QLLiveLayoutSemanticAbsolute];
}
+ (instancetype)fractionalDimension:(CGFloat)value{
    return [[self alloc] initWithDistribution:value
                                     semantic:QLLiveLayoutSemanticFractional];
}
- (instancetype)initWithDistribution:(CGFloat)distribution
                            semantic:(QLLiveLayoutSemantic)semantic {

    self = [super init];
    if (self) {
        self.value = distribution;
        self.semantic = semantic;
    }
    return self;
}

- (BOOL)isEmbed{
    return self.semantic == QLLiveLayoutSemanticEmbed;
}

- (BOOL)isAbsolute{
    return self.semantic == QLLiveLayoutSemanticAbsolute;
}

- (BOOL)isFractional{
    return self.semantic == QLLiveLayoutSemanticFractional;
}

@end

@implementation QLLiveLayoutItemRatio

+ (instancetype)itemRatioValue:(CGFloat)value{
    if (value <= 0) {
        return nil;
    }
    return [[self alloc] initWithItemRatio:value semantic:QLLiveLayoutSemanticNormal];
}

+ (instancetype)absoluteValue:(CGFloat)value{
    if (value <= 0) {
        return nil;
    }
    return [[self alloc] initWithItemRatio:value semantic:QLLiveLayoutSemanticAbsolute];
}

- (instancetype)initWithItemRatio:(CGFloat)itemRatio semantic:(QLLiveLayoutSemantic)semantic {

    self = [super init];
    if (self) {
        self.value = itemRatio;
        self.semantic = semantic;
    }
    return self;;
}

- (BOOL)isAbsolute{
    return self.semantic == QLLiveLayoutSemanticAbsolute;
}
@end
