//
//  QLLiveComponentBackgroundDecorate.m
//  QILievModule
//
//  Created by rocky on 2020/8/19.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveComponentBackgroundDecorate.h"
#import "QLLiveComponent_Private.h"

@implementation QLLiveComponentBackgroundDecorateContents

+ (instancetype)colorContents:(UIColor *)color{
    QLLiveComponentBackgroundDecorateContents * mine = [self new];
    mine.color = color;
    mine.isColor = YES;
    return mine;;
}
+ (instancetype)imageContents:(UIImage *)image{
    QLLiveComponentBackgroundDecorateContents * mine = [self new];
    mine.image = image;
    mine.isImage = YES;
    return mine;
}

+ (instancetype) gradientContents:(void(^)(id<QLLiveComponentBackgroundDecorateGradientContentsAble>contents))builder{
    QLLiveComponentBackgroundDecorateContents * mine = [self new];
    mine.isGradient = YES;
    if (builder) {
        builder(mine);
    }
    return mine;;
}

@end
