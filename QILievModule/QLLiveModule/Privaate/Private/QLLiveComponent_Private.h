//
//  QLLiveComponent+Private.h
//  Weather_App
//
//  Created by rocky on 2020/7/10.
//  Copyright © 2020 Yrocky. All rights reserved.
//

#import "QLLiveComponent.h"
#import "QLLiveModelEnvironment_Protocol.h"
#import "QLLiveModelEnvironment_Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLLiveComponentBackgroundDecorateBuilder : NSObject<
QLLiveComponentBackgroundDecorateAble>

@property (nonatomic ,assign) QLLiveComponentBackgroundDecorateType type;

@property (nonatomic ,assign) CGFloat radius;
@property (nonatomic ,assign) UIEdgeInsets inset;

// color/image/gradient
@property (nonatomic ,strong) QLLiveComponentBackgroundDecorateContents * contents;

@end

@interface QLLiveComponent ()

@property (nonatomic, weak, readwrite) id<QLLiveModuleDataSourceAble> dataSource;
@property (nonatomic ,weak) id<QLLiveModelEnvironment> environment;
@property (nonatomic ,assign ,readwrite) NSInteger index;

@property (nonatomic ,strong) QLLiveComponentBackgroundDecorateBuilder * backgroundDecorateBuilder;

- (void) calculatorLayout;
@end

@interface QLLiveComponentBackgroundDecorateContents ()

@property (nonatomic ,strong) UIColor * color;

@property (nonatomic ,strong) UIImage * image;

//@property (nonatomic ,copy ,readwrite) NSArray <UIColor *>* colors;
//@property (nonatomic ,copy ,readwrite) NSArray <NSNumber *>* locations;
//@property (nonatomic ,readwrite) CGPoint startPoint;// 0,0
//@property (nonatomic ,readwrite) CGPoint endPoint;// 1,0
@property (nonatomic ,copy) NSArray <UIColor *>* colors;
@property (nonatomic ,copy) NSArray <NSNumber *>* locations;
@property (nonatomic) CGPoint startPoint;// 0,0
@property (nonatomic) CGPoint endPoint;// 1,0

@property (nonatomic ,assign ,readwrite) BOOL isColor;
@property (nonatomic ,assign ,readwrite) BOOL isImage;
@property (nonatomic ,assign ,readwrite) BOOL isGradient;
@end
NS_ASSUME_NONNULL_END
