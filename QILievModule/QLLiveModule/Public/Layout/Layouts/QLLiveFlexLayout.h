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

/*
 如果是水平布局，horizontalArrangeHeight 的值将等于 itemHeight
 设置 horizontalArrangeContentHeight 无效
 */
@property (nonatomic ,assign) CGFloat itemHeight;

/*
 当 arrange 为 ...Horizontal 的时候
 justifyContent 固定为 QLLiveFlexLayoutFlexStart，设置无效
*/
@property (nonatomic ,assign) QLLiveFlexLayoutGravity justifyContent;

@property (nonatomic ,weak) id<QLLiveFlexLayoutDelegate> delegate;
@end

@protocol QLLiveFlexLayoutDelegate <NSObject>
/*
 返回的size.height可以是任意值，
 在内部只取size.width，height固定为设置的 itemHeight
*/
- (CGSize) layoutCustomItemSize:(QLLiveFlexLayout *)layout atIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
