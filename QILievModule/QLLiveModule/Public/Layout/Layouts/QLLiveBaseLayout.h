//
//  QLLiveBaseLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QLLiveLayoutDescriber.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QLLiveModelEnvironment;
@interface QLLiveBaseLayout : NSObject{
    NSMutableDictionary * _cacheItemFrame;
    /// 减去insets的left、right之后的宽度
    CGFloat _insetContainerWidth;
    CGFloat _maxY;
}

@property (nonatomic ,strong ,readonly) id<QLLiveModelEnvironment> environment;

/// default zero
@property (nonatomic ,assign) UIEdgeInsets inset;
@property (nonatomic ,assign ,readonly) CGFloat insetContainerWidth;

@property (nonatomic ,assign) CGFloat lineSpacing;// default 5
@property (nonatomic ,assign) CGFloat itemSpacing;// default 5

@property (nonatomic ,assign) CGFloat minY;// default 0.0f
@property (nonatomic ,assign ,readonly) CGFloat maxY;// default 0.0f

- (void) clear;

// 缓存每一个索引下的frame，子类调用
- (void) cacheItemFrame:(CGRect)itemFrame at:(NSInteger)index;

// 获取每一个index的位置
- (CGRect) itemFrameAtIndex:(NSInteger)index;

// subclass override
- (void) calculatorLayoutWithDatas:(NSArray *)datas;
@end

NS_ASSUME_NONNULL_END
