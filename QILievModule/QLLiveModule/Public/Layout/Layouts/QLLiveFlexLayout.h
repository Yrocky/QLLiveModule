//
//  QLLiveFlexLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QLLiveFlexLayoutGravity) {
    QLLiveFlexLayoutFlexStart =     0,
    QLLiveFlexLayoutFlexEnd =       1,
    QLLiveFlexLayoutCenter =        2,
    QLLiveFlexLayoutSpaceBetween =  3,
    QLLiveFlexLayoutSpaceAround =   4,
};

@protocol QLLiveFlexLayoutDelegate;
@interface QLLiveFlexLayout : QLLiveBaseLayout

@property (nonatomic ,assign) CGFloat itemHeight;
@property (nonatomic ,assign) QLLiveFlexLayoutGravity justifyContent;

@property (nonatomic ,weak) id<QLLiveFlexLayoutDelegate> delegate;
@end

@protocol QLLiveFlexLayoutDelegate <NSObject>

- (CGSize) layoutCustomItemSize:(QLLiveFlexLayout *)layout atIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
