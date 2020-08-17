//
//  QLLiveLayoutDescriber.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Distribution
@interface QLLiveLayoutDistribution : NSObject

+ (instancetype)distributionValue:(NSInteger)value;
// 固定数值
+ (instancetype)absoluteDimension:(CGFloat)value;
// CollectionView宽度的比例
+ (instancetype)fractionalDimension:(CGFloat)value;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;

- (BOOL)isAbsolute;
- (BOOL)isFractional;
@end

// 宽高比
@interface QLLiveLayoutItemRatio : NSObject

+ (instancetype)itemRatioValue:(CGFloat)value;
// 设定一个固定的高度
+ (instancetype)absoluteValue:(CGFloat)value;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;

- (BOOL)isAbsolute;

@end

NS_ASSUME_NONNULL_END
