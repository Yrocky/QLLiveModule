//
//  QLLiveDecorateSectionLayoutAttributes.m
//  QILievModule
//
//  Created by rocky on 2020/8/18.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveDecorateSectionLayoutAttributes.h"
#import "QLLiveComponent_Private.h"

@implementation QLLiveDecorateSectionLayoutAttributes
@end

@implementation QLLiveDecorateSectionView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[QLLiveDecorateSectionLayoutAttributes class]]) {
        QLLiveDecorateSectionLayoutAttributes * att =
        (QLLiveDecorateSectionLayoutAttributes *)layoutAttributes;
        id<QLLiveComponentBackgroundDecorateAble> builder = att.builder;
        QLLiveComponentBackgroundDecorateContents * contents = builder.contents;

        self.layer.cornerRadius = builder.radius;
        self.layer.shadowColor = contents.shadowColor.CGColor;
        self.layer.shadowOffset = contents.shadowOffset;
        self.layer.shadowRadius = contents.shadowRadius;
        self.layer.shadowOpacity = contents.shadowOpacity;

        [self clear];
        if (contents.isColor) {
            ((CAGradientLayer *)self.layer).colors = @[
                (__bridge id)contents.color.CGColor,
                (__bridge id)contents.color.CGColor
            ];
            ((CAGradientLayer *)self.layer).locations = @[@(0), @(1.0f)];
            ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
            ((CAGradientLayer *)self.layer).endPoint = CGPointMake(1, 1);
        } else if (contents.isImage) {
            self.layer.contents = (__bridge id)[contents.image imageByRoundCornerRadius:builder.radius].CGImage;
            self.layer.contentsScale = contents.image.scale;
        } else if (contents.isGradient) {
            ((CAGradientLayer *)self.layer).colors = [self _transformColorsForLayer:contents.colors];
            ((CAGradientLayer *)self.layer).locations = contents.locations;
            ((CAGradientLayer *)self.layer).startPoint = contents.startPoint;
            ((CAGradientLayer *)self.layer).endPoint = contents.endPoint;
        }
    }
}

- (void) clear{
    self.layer.contents = nil;
    ((CAGradientLayer *)self.layer).colors = nil;
    ((CAGradientLayer *)self.layer).locations = nil;
    ((CAGradientLayer *)self.layer).startPoint = CGPointZero;
    ((CAGradientLayer *)self.layer).endPoint = CGPointZero;
}

+ (Class)layerClass{
    return [CAGradientLayer class];
}

- (NSArray *) _transformColorsForLayer:(NSArray <UIColor *>*)colors{
    // 将color转换成CGColor
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *tmp in colors) {
        id cgColor = (__bridge id)tmp.CGColor;
        [cgColors addObject:cgColor];
    }
    
    return cgColors.copy;
}

@end
