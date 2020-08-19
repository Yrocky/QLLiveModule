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
@property (nonatomic ,strong) id contents;
@end

@interface QLLiveComponent ()

@property (nonatomic, weak, readwrite) id<QLLiveModuleDataSourceAble> dataSource;
@property (nonatomic ,weak) id<QLLiveModelEnvironment> environment;
@property (nonatomic ,assign ,readwrite) NSInteger index;

@property (nonatomic ,strong) QLLiveComponentBackgroundDecorateBuilder * backgroundDecorateBuilder;

- (void) calculatorLayout;
@end

NS_ASSUME_NONNULL_END
