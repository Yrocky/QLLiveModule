//
//  QLLiveComponentBackgroundDecorateContents.m
//  QILievModule
//
//  Created by rocky on 2020/8/19.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveComponentDecorateContents.h"
#import "QLLiveComponent_Private.h"

@implementation QLLiveComponentDecorateContents

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shadowColor = UIColor.clearColor;
        self.shadowOffset = CGSizeZero;
        self.shadowRadius = 0;
        self.shadowOpacity = 0;
    }
    return self;
}

+ (instancetype)colorContents:(UIColor *)color{
    QLLiveComponentDecorateContents * mine = [self new];
    mine.color = color;
    mine.isColor = YES;
    return mine;;
}

+ (instancetype)imageContents:(UIImage *)image{
    QLLiveComponentDecorateContents * mine = [self new];
    mine.image = image;
    mine.isImage = YES;
    return mine;
}

+ (instancetype) gradientContents:(void(^)(id<QLLiveComponentDecorateGradientContentsAble>contents))builder{
    QLLiveComponentDecorateContents * mine = [self new];
    mine.isGradient = YES;
    // TODO:消除警告
    if (builder) {
        builder(mine);
    }
    return mine;;
}

@end
