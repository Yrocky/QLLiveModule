//
//  QLLiveListLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveListLayout.h"

@implementation QLLiveListLayout

#pragma mark - override

- (void)calculatorLayoutWithDatas:(NSArray *)datas{
    
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
    __block CGFloat maxY = self.insets.top;
    __block CGFloat maxX = 0.0f;
    
    for (NSInteger index = 0; index < datas.count; index ++) {
        CGFloat x = maxX;
        CGFloat y = maxY;
        CGRect frame = (CGRect){x,y,width,height};
        // cache
        [self cacheItemFrame:frame at:index];
        [result addObject:[NSValue valueWithCGRect:frame]];
        maxX += (width + self.itemSpacing);
        if (maxX > self.insetContainerWidth) {
            maxX = 0;
            maxY += (height + self.lineSpacing);
        }
        _maxY = CGRectGetMaxY(frame);
    }
    _maxY += self.insets.bottom;
    
}

@end
