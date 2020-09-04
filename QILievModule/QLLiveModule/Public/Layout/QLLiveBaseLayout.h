//
//  QLLiveBaseLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QLLiveLayoutArrange) {
    /// 垂直
    QLLiveLayoutArrangeVertical,
    /// 水平
    QLLiveLayoutArrangeHorizontal,
};

typedef NS_ENUM(NSInteger, QLLiveLayoutHorizontalScrollingBehavior) {
    QLLiveLayoutHorizontalScrollingBehaviorNone,
    QLLiveLayoutHorizontalScrollingBehaviorContinuous,
    QLLiveLayoutHorizontalScrollingBehaviorPaging,
    QLLiveLayoutHorizontalScrollingBehaviorCentered,
};

@protocol QLLiveModelEnvironment;
@interface QLLiveBaseLayout : NSObject{
    NSMutableDictionary * _cacheItemFrame;
    /// 减去insets的left、right之后的宽度
    CGFloat _insetContainerWidth;
    CGFloat _contentWidth;
    CGFloat _contentHeight;
}

@property (nonatomic ,strong ,readonly) id<QLLiveModelEnvironment> environment;

/// default zero
@property (nonatomic ,assign) UIEdgeInsets inset;
@property (nonatomic ,assign ,readonly) CGFloat insetContainerWidth;

@property (nonatomic ,assign) CGFloat lineSpacing;// default 5
@property (nonatomic ,assign) CGFloat itemSpacing;// default 5
/*
 经过计算之后的内容宽度，仅用于 arrange = QLLiveLayoutArrangeHorizontal
 */
@property (nonatomic ,assign ,readonly) CGFloat contentWidth;
/*
 经过计算之后的内容高度，仅用于 arrange = QLLiveLayoutArrangeVertical
 */
@property (nonatomic ,assign ,readonly) CGFloat contentHeight;
/*
 layout的布局方向，默认为 QLLiveLayoutArrangeVertical 垂直
 */
@property (nonatomic ,assign) QLLiveLayoutArrange arrange;
/*
 arrange = QLLiveLayoutArrangeHorizontal 的时候
 限制垂直方向的高度
 */
@property (nonatomic ,assign) CGFloat horizontalArrangeContentHeight;
/*
 arrange = QLLiveLayoutArrangeHorizontal 的时候
 内嵌ScrollView的滚动效果
 */
@property (nonatomic ,assign) QLLiveLayoutHorizontalScrollingBehavior horizontalScrollingBehavior;

/*
 缓存每一个索引下的frame，子类调用
 */
- (void) cacheItemFrame:(CGRect)itemFrame at:(NSInteger)index;
/*
 清除缓存的frame
 */
- (void) clear;
@end

@interface QLLiveBaseLayout (SubclassingOverride)
/*
 计算水平布局情况下的cell位置
 */
- (void) calculatorHorizontalLayoutWithDatas:(NSArray *)datas;
/*
 计算垂直布局情况下的cell位置
*/
- (void) calculatorVerticalLayoutWithDatas:(NSArray *)datas;
@end

NS_ASSUME_NONNULL_END
