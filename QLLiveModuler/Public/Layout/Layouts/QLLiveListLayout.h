//
//  QLLiveListLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class QLLiveLayoutDistribution;
@class QLLiveLayoutItemRatio;
/*
 在水平布局中，如果 通过 `distribution` 和 `itemRatio`计算出来的 cell高度大于 `horizontalArrangeContentHeight`，则会限制为`horizontalArrangeContentHeight`
 如果小于则会按照`从上之下、从左至右`的顺序进行排列，
 
 另外，还可以设置`row`来决定 `horizontalArrangeContentHeight`，
 此时设置 `horizontalArrangeContentHeight`将无效
 */
@interface QLLiveListLayout : QLLiveBaseLayout
/*
 用来决定cell的宽度
 可以设置根据 `insetContainerWidth 的比例`、
 `insetContainerWidth 等分数`以及`固定数值`三种
 */
@property (nonatomic ,strong) QLLiveLayoutDistribution * distribution;
/*
 用来决定cell的高度
 可以设置`宽高比`、`固定值`
*/
@property (nonatomic ,strong) QLLiveLayoutItemRatio * itemRatio;
/*
 当 arrange 为 ...Horizontal 的时候，可以通过这个来便捷计算出来cell的高度，
 如果设置了row，设置的horizontalArrangeContentHeight 将无效
 */
@property (nonatomic ,assign) NSInteger row;

@end

// Distribution
@interface QLLiveLayoutDistribution : NSObject
/*
 insetContainerWidth 的等分数
 */
+ (instancetype)distributionValue:(NSInteger)value NS_SWIFT_NAME(distribution(_:));
/*
 固定宽度数值
 */
+ (instancetype)absoluteDimension:(CGFloat)value NS_SWIFT_NAME(absolute(_:));
/*
 insetContainerWidth 的比例
 */
+ (instancetype)fractionalDimension:(CGFloat)value NS_SWIFT_NAME(fractional(_:));

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;

- (BOOL)isAbsolute;
- (BOOL)isFractional;
@end

// 宽高比
@interface QLLiveLayoutItemRatio : NSObject
/*
 设定cell的宽高比
 */
+ (instancetype)itemRatioValue:(CGFloat)value NS_SWIFT_NAME(itemRatio(_:));
/*
 设定一个固定的高度
 */
+ (instancetype)absoluteValue:(CGFloat)value NS_SWIFT_NAME(absolute(_:));

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;

- (BOOL)isAbsolute;

@end

NS_ASSUME_NONNULL_END
