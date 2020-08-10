//
//  QLLiveLayoutCalculator.m
//  Weather_App
//
//  Created by rocky on 2020/8/9.
//  Copyright © 2020 Yrocky. All rights reserved.
//

#import "QLLiveLayoutCalculator.h"
#import <UIKit/UIKit.h>

@interface QLLiveLayoutCalculator ()
@property (nonatomic ,strong) NSMutableArray * rowWidths;
@property (nonatomic ,assign) UIEdgeInsets edgeInsets;
@property (nonatomic ,assign) CGFloat rowMargin;
@property (nonatomic ,assign) CGFloat columnMargin;
@property (nonatomic ,assign) CGFloat maxRowWidth;

@property (nonatomic ,strong) NSMutableArray * rowHeights;
@property (nonatomic ,assign) CGFloat maxRowHeight;
@end
@implementation QLLiveLayoutCalculator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.maxRowWidth = self.maxRowHeight =
        self.rowMargin = self.columnMargin = 0.0f;

        self.rowWidths = [NSMutableArray new];
        for (NSInteger i = 0; i < 2; i++) {
            [self.rowWidths addObject:@(self.edgeInsets.left)];
        }

        self.rowHeights = [NSMutableArray new];
        for (NSInteger i = 0; i < 4; i++) {
            [self.rowHeights addObject:@(self.edgeInsets.top)];
        }
    }
    return self;
}
//- (NSArray<NSValue *> *) calculatorWith:(NSArray<NSValue *> *)items{
//
//    CGFloat collectionW = 414;
//    NSMutableArray * tmp = [NSMutableArray new];
//    for (NSInteger index = 0; index < items.count; index ++) {
//
//        CGSize size = items[index].CGSizeValue;
//        NSLog(@"%d %@",index,NSStringFromCGSize(size));
//        CGFloat h = size.height;
//        CGFloat w = size.width;
//
//        CGFloat x = 0;
//        CGFloat y = 0;
//
//        //找出宽度最短的那一行
//        NSInteger destColumn = 0;
//        CGFloat minRowHeight = [self.rowHeights[destColumn] doubleValue];
//        for (NSInteger i = 1; i < self.rowHeights.count; i++) {
//            //取出第i行
//            CGFloat rowHeight = [self.rowHeights[i] doubleValue];
//            if (minRowHeight > rowHeight) {
//                minRowHeight = rowHeight;
//                destColumn = i;
//            }
//        }
//
//        x = destColumn == 0 ? self.edgeInsets.left : self.edgeInsets.left + w + self.columnMargin;
//
//        y = [self.rowHeights[destColumn] doubleValue] == self.edgeInsets.top ?
//        self.edgeInsets.top:
//        [self.rowHeights[destColumn] doubleValue] + self.rowMargin;
//        //更新最短那行的宽度
//        if (w >= collectionW - self.edgeInsets.left - self.edgeInsets.right) {
//            y = [self.rowHeights[destColumn] doubleValue] == self.edgeInsets.top ?
//            self.edgeInsets.top :
//            self.maxRowHeight + self.rowMargin;
//            for (NSInteger i = 0; i < 4; i++) {
//                self.rowHeights[i] = @(y + h);
//            }
//        }else{
//            self.rowHeights[destColumn] = @(y + h);
//        }
//
//        //记录最大
//        if (self.maxRowHeight < y + h) {
//            self.maxRowHeight = y + h;
//        }
//
//        [tmp addObject:[NSValue valueWithCGRect:(CGRect){
//            x,y,w,h
//        }]];
//    }
//    return tmp;
//}

- (NSArray<NSValue *> *) calculatorWith:(NSArray<NSValue *> *)items{

    CGFloat collectionH = 3 * 414/4 ;
    NSMutableArray * tmp = [NSMutableArray new];
    for (NSInteger index = 0; index < items.count; index ++) {

        CGSize size = items[index].CGSizeValue;

        CGFloat h = size.height;
        CGFloat w = size.width;

        CGFloat x = 0;
        CGFloat y = 0;

        //找出宽度最短的那一行
        NSInteger destRow = 0;
        CGFloat minRowWidth = [self.rowWidths[destRow] doubleValue];
        for (NSInteger i = 1; i < self.rowWidths.count; i++) {
            //取出第i行
            CGFloat rowWidth = [self.rowWidths[i] doubleValue];
            if (minRowWidth > rowWidth) {
                minRowWidth = rowWidth;
                destRow = i;
            }
        }

        // h需要的是前一行的最大y
        y = destRow == 0 ? self.edgeInsets.top : self.edgeInsets.top + h + self.rowMargin;

        x = [self.rowWidths[destRow] doubleValue] == self.edgeInsets.left ? self.edgeInsets.left : [self.rowWidths[destRow] doubleValue] + self.columnMargin;
        //更新最短那行的宽度
        if (h >= collectionH - self.edgeInsets.bottom - self.edgeInsets.top) {
            x = [self.rowWidths[destRow] doubleValue] == self.edgeInsets.left ?
            self.edgeInsets.left :
            self.maxRowWidth + self.columnMargin;
            for (NSInteger i = 0; i < 2; i++) {
                self.rowWidths[i] = @(x + w);
            }
        }else{
            self.rowWidths[destRow] = @(x + w);
        }
        //记录最大宽度
        if (self.maxRowWidth < x + w) {
            self.maxRowWidth = x + w ;
        }

        [tmp addObject:[NSValue valueWithCGRect:(CGRect){
            x,y,w,h
        }]];
    }
    return tmp;
}
@end
