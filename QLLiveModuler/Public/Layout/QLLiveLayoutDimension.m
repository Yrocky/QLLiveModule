//
//  QLLiveLayoutDimension.m
//  QILievModule
//
//  Created by rocky on 2020/9/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveLayoutDimension.h"

typedef NS_ENUM(NSUInteger, QLLiveLayoutSemantic) {
    
    QLLiveLayoutSemanticNormal,
    
    QLLiveLayoutSemanticEmbed,
    QLLiveLayoutSemanticAbsolute,
    QLLiveLayoutSemanticFractional,
};

@interface QLLiveLayoutDimension ()

@property (nonatomic, readwrite) CGFloat value;
@property (nonatomic) QLLiveLayoutSemantic semantic;

@property (nonatomic, readonly) BOOL isEmbed;
@property (nonatomic, readonly) BOOL isAbsolute;
@property (nonatomic, readonly) BOOL isFractional;
@end

@implementation QLLiveLayoutDimension

+ (instancetype)distributionDimension:(NSInteger)value{
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
