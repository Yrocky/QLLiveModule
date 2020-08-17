//
//  QLLiveFlexLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveFlexLayout.h"

@implementation QLLiveFlexLayout

- (void)calculatorLayoutWithDatas:(NSArray *)datas{

    CGFloat maxWidth = 0.0f;
    NSMutableArray<NSValue *> * result = [NSMutableArray new];

    NSMutableArray<NSMutableArray<NSValue *> *> * lines = [NSMutableArray new];
    NSMutableArray<NSValue *> * line = [NSMutableArray new];
    [lines addObject:line];
    NSInteger lineNumber = 1;

    for (NSInteger index = 0; index < datas.count; index ++) {
        CGFloat itemWidth = 0.0f;
        if ([self.delegate respondsToSelector:@selector(layoutCustomItemSize:atIndex:)]) {
            itemWidth = [self.delegate layoutCustomItemSize:self atIndex:index].width;
        }
        CGSize itemSize = (CGSize){
            MIN(self.insetContainerWidth, itemWidth),
            self.itemHeight
        };

        NSLog(@"[cal] itemSize:%@",NSStringFromCGSize(itemSize));
        maxWidth += (itemSize.width + self.itemSpacing);

        if ((maxWidth - self.itemSpacing) > self.insetContainerWidth) {
            CGFloat currentLineMaxWidth = maxWidth - self.itemSpacing * 2 - itemSize.width;
            [self _calculatorFlexLayoutLineMaxWidth:currentLineMaxWidth
                                               line:line
                                         lineNumber:lineNumber
                                             result:result];
            maxWidth = itemSize.width + self.itemSpacing;
            [lines removeObject:line];
            line = [NSMutableArray new];
            [lines addObject:line];
            lineNumber ++;
        }
        [line addObject:[NSValue valueWithCGSize:itemSize]];
    }
    if (line.count) {
        // 最后一行
        [self _calculatorFlexLayoutLineMaxWidth:maxWidth - self.itemSpacing
                                           line:line
                                     lineNumber:lineNumber
                                         result:result];
    }
    _maxY = self.minY + self.insets.top +
    lineNumber * self.itemHeight + (lineNumber - 1) * self.lineSpacing +
    self.insets.bottom;
}

- (void) _calculatorFlexLayoutLineMaxWidth:(CGFloat)lineMaxWidth line:(NSMutableArray<NSValue *> *)line lineNumber:(NSInteger)lineNumber result:(NSMutableArray<NSValue *> *)result{
    /*
     |<--spacing1-->口<-itemSpacing->口<--spacing2-->|
     lineMaxWidth: 口+口+itemSpacing
     totalSpacing: spacing1 + spacing2 + itemSpacing
     totalItemsWidth: = 口+口
    */
    CGFloat totalSpacing = self.insetContainerWidth - lineMaxWidth + (line.count - 1) * self.itemSpacing;
    CGFloat totalItemsWidth = lineMaxWidth - (line.count - 1) * self.itemSpacing;

    __block CGFloat preItemX = 0.0f;
    if (self.justifyContent == QLLiveFlexLayoutFlexEnd) {
        preItemX = self.insetContainerWidth - lineMaxWidth;
    } else if (self.justifyContent == QLLiveFlexLayoutCenter) {
        preItemX = (self.insetContainerWidth - lineMaxWidth) / 2.0;
    } else if (self.justifyContent == QLLiveFlexLayoutSpaceAround){
        preItemX = (self.insetContainerWidth - totalItemsWidth) / (line.count + 1);
    }
    preItemX += self.insets.left;
    // 为line中的元素进行布局
    [line enumerateObjectsUsingBlock:^(NSValue * item, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize innerItemSize = item.CGSizeValue;
        CGFloat x = 0;
        CGFloat y = 0;
        if (self.justifyContent == QLLiveFlexLayoutFlexStart ||
            self.justifyContent == QLLiveFlexLayoutFlexEnd ||
            self.justifyContent == QLLiveFlexLayoutCenter) {
            x = preItemX;
            preItemX += (innerItemSize.width + self.itemSpacing);
        } else if (self.justifyContent == QLLiveFlexLayoutSpaceBetween){
            x = preItemX;
            preItemX += (innerItemSize.width + totalSpacing / (line.count - 1));
        } else {
            x = preItemX;
            preItemX += (innerItemSize.width + totalSpacing / (line.count + 1));
        }
        y = (lineNumber - 1) * (innerItemSize.height + self.lineSpacing) + self.minY;
        CGRect frame = (CGRect){
            CGPointMake(x, y), innerItemSize
        };
        // cache
        [self cacheItemFrame:frame at:result.count];
        [result addObject:[NSValue valueWithCGRect:frame]];
    }];
}
@end