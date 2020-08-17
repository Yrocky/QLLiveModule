//
//  QLLiveWaterfallLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, QLLiveWaterfallItemRenderDirection) {
    QLLiveWaterfallItemRenderShortestFirst = 0,
    QLLiveWaterfallItemRenderLeftToRight = 1,
    QLLiveWaterfallItemRenderRightToLeft = 2,
};

@protocol QLLiveWaterfallLayoutDelegate;
@interface QLLiveWaterfallLayout : QLLiveBaseLayout

@property (nonatomic ,assign) NSInteger column;
@property (nonatomic ,assign) QLLiveWaterfallItemRenderDirection renderDirection;

@property (nonatomic ,weak) id<QLLiveWaterfallLayoutDelegate> delegate;
@end

@protocol QLLiveWaterfallLayoutDelegate <NSObject>

- (CGSize) layoutCustomItemSize:(QLLiveWaterfallLayout *)layout atIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
