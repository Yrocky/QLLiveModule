//
//  QLLiveGridLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveGridLayout.h"

@interface QLLiveGridLayout ()

@property (nonatomic ,copy) NSMutableArray<QLLiveGridLayoutRow *> * rows;
@end

@implementation QLLiveGridLayout

- (void) addRows:(NSArray<QLLiveGridLayoutRow *> *)rows{
    [self.rows addObjectsFromArray:rows];
}

- (void) addRow:(QLLiveGridLayoutRow *)row repeat:(NSInteger)reapeat{
    for (NSInteger index = 0; index < reapeat; index ++) {
        [self.rows addObject:row];
    }
}
- (void)setupAreas:(NSString *)areas{
    NSArray * 
}
#pragma mark - calculator Horizontal

- (void) calculatorHorizontalLayoutWithDatas:(NSArray *)datas{
}

#pragma mark - calculator Vertical

- (void) calculatorVerticalLayoutWithDatas:(NSArray *)datas{
}
@end

@implementation QLLiveGridLayoutRow

@end


@implementation QLLiveGridLayoutColumn


@end

@implementation QLLiveGridLayoutAreas


@end
