//
//  QLLiveListLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveListLayout.h"

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

@implementation QLLiveListLayout

#pragma mark - calculator Horizontal

- (void)calculatorHorizontalLayoutWithDatas:(NSArray *)datas{
    
}

#pragma mark - calculator Vertical

- (void) calculatorVerticalLayoutWithDatas:(NSArray *)datas{
    
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
    
    NSMutableArray<NSValue *> * result = [NSMutableArray new];
    __block CGFloat maxY = 0;
    __block CGFloat maxX = self.inset.left;
    
    for (NSInteger index = 0; index < datas.count; index ++) {
        CGFloat x = maxX;
        CGFloat y = maxY;
        CGRect frame = (CGRect){x,y,width,height};
        // cache
        [self cacheItemFrame:frame at:index];
        [result addObject:[NSValue valueWithCGRect:frame]];
        maxX += (width + self.itemSpacing);
        if (maxX > self.insetContainerWidth) {
            maxX = self.inset.left;
            maxY += (height + self.lineSpacing);
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
