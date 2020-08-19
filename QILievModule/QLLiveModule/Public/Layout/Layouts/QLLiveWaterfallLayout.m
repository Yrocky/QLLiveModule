//
//  QLLiveWaterfallLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveWaterfallLayout.h"

@interface QLLiveWaterfallLayout ()
@property (nonatomic ,strong) NSMutableArray * columnHeights;
@end

@implementation QLLiveWaterfallLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnHeights = [NSMutableArray new];
    }
    return self;
}

#pragma mark - override

- (void)clear{
    [super clear];
    [self.columnHeights removeAllObjects];
}

- (void)calculatorLayoutWithDatas:(NSArray *)datas{
    
    // 初始化每一列的最大值
    for (NSInteger index = 0; index < self.column; index ++) {
        [self.columnHeights addObject:@(0)];
    }

    CGFloat width = (self.insetContainerWidth - (self.column - 1) * self.itemSpacing) / self.column;
    CGFloat height = 0.0f;
    NSMutableArray<NSValue *> * result = [NSMutableArray new];

    for (NSInteger index = 0; index < datas.count; index ++) {
        if ([self.delegate respondsToSelector:@selector(layoutCustomItemSize:atIndex:)]) {
            height = [self.delegate layoutCustomItemSize:self atIndex:index].height;
        }
        NSUInteger columnIndex = [self _nextColumnIndexForItem:index];

        CGFloat x = (width + self.itemSpacing) * columnIndex + self.inset.left;
        CGFloat y = [self.columnHeights[columnIndex] floatValue];
        CGRect frame = CGRectMake(x, y, width, height);
        self.columnHeights[columnIndex] = @(CGRectGetMaxY(frame) + self.lineSpacing);
        // cache
        [self cacheItemFrame:frame at:index];
        [result addObject:[NSValue valueWithCGRect:frame]];
    }
    _maxY = [self _longestColumnHeight] - self.lineSpacing + self.inset.bottom;
}

#pragma mark - private

- (NSUInteger) _nextColumnIndexForItem:(NSInteger)item {

    NSUInteger index = 0;
    if (self.renderDirection == QLLiveWaterfallItemRenderLeftToRight) {
        index = (item % self.column);
    } else if (self.renderDirection == QLLiveWaterfallItemRenderRightToLeft) {
        index = (self.column - 1) - (item % self.column);
    } else {
        index = [self _shortestColumnIndex];
    }
    return index;
}

- (NSUInteger) _shortestColumnIndex{
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;

    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}

- (CGFloat) _longestColumnHeight{
    __block CGFloat longestHeight = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
        }
    }];
    return longestHeight;
}

@end
