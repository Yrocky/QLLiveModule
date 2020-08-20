//
//  QLLiveComponentBackgroundDecorate.h
//  QILievModule
//
//  Created by rocky on 2020/8/19.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QLLiveComponentBackgroundDecorateGradientContentsAble <NSObject>

@property (nonatomic ,copy) NSArray <UIColor *>* colors;
@property (nonatomic ,copy) NSArray <NSNumber *>* locations;
@property (nonatomic) CGPoint startPoint;// 0,0
@property (nonatomic) CGPoint endPoint;// 1,0
@end

// 用swift中的枚举会比较好，oc就只能用对象了
@interface QLLiveComponentBackgroundDecorateContents : NSObject

+ (instancetype) colorContents:(UIColor *)color;
+ (instancetype) imageContents:(UIImage *)image;
+ (instancetype) gradientContents:(void(^)(id<QLLiveComponentBackgroundDecorateGradientContentsAble>contents))builder;

// shadow
@property (nonatomic ,strong) UIColor * shadowColor;
@property (nonatomic ,assign) float shadowOpacity;
@property (nonatomic ,assign) CGSize shadowOffset;
@property (nonatomic ,assign) CGFloat shadowRadius;

@property (nonatomic ,assign ,readonly) BOOL isColor;
@property (nonatomic ,assign ,readonly) BOOL isImage;
@property (nonatomic ,assign ,readonly) BOOL isGradient;

@end

NS_ASSUME_NONNULL_END
