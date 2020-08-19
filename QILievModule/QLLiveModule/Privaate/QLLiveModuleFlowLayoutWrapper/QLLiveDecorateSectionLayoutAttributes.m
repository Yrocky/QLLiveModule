//
//  QLLiveDecorateSectionLayoutAttributes.m
//  QILievModule
//
//  Created by rocky on 2020/8/18.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveDecorateSectionLayoutAttributes.h"

@implementation QLLiveDecorateSectionLayoutAttributes
@end

@implementation QLLiveDecorateSectionView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[QLLiveDecorateSectionLayoutAttributes class]]) {
        QLLiveDecorateSectionLayoutAttributes * att =
        (QLLiveDecorateSectionLayoutAttributes *)layoutAttributes;
        self.backgroundColor = att.backgroundColor;
        if (att.cornerRadius) {
            self.layer.cornerRadius = att.cornerRadius;
            self.layer.masksToBounds = YES;
        }
//        self.layer.contents = CFBridgingRelease([UIColor redColor].CGColor);
    }
}

@end
