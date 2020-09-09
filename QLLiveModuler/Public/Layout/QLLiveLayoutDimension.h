//
//  QLLiveLayoutDimension.h
//  QILievModule
//
//  Created by rocky on 2020/9/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLLiveLayoutDimension : NSObject
/*
 等分数
 */
+ (instancetype)distributionDimension:(NSInteger)value NS_SWIFT_NAME(distribution(_:));
/*
 固定数值
 */
+ (instancetype)absoluteDimension:(CGFloat)value NS_SWIFT_NAME(absolute(_:));
/*
 比例
 */
+ (instancetype)fractionalDimension:(CGFloat)value NS_SWIFT_NAME(fractional(_:));

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly) CGFloat value;

- (BOOL)isAbsolute;
- (BOOL)isFractional;

@end

NS_ASSUME_NONNULL_END
