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
    /*
     |口口口........|
     */
    QLLiveFlexLayoutFlexStart =     0,
    /*
     |........口口口|
     */
    QLLiveFlexLayoutFlexEnd =       1,
    /*
     |....口口口....|
     */
    QLLiveFlexLayoutCenter =        2,
    /*
     |口....口....口|
     */
    QLLiveFlexLayoutSpaceBetween =  3,
    /*
     |..口..口..口..|
     */
    QLLiveFlexLayoutSpaceAround =   4,
} NS_SWIFT_NAME(QLLiveFlexLayout.Gravity);

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
 返回的size.height可以是任意值，内部会使用 itemHeight
*/
- (CGSize) layoutCustomItemSize:(QLLiveFlexLayout *)layout atIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
