//
//  QLLiveLayoutDescriber.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveLayoutDescriber.h"

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

@interface QLLiveLayoutItemRatio ()

@property (nonatomic, readwrite) CGFloat value;
@property (nonatomic) QLLiveLayoutSemantic semantic;

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
