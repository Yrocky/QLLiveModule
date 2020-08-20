//
//  QLLiveDecorateSectionLayoutAttributes.h
//  QILievModule
//
//  Created by rocky on 2020/8/18.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol QLLiveComponentBackgroundDecorateAble;
@interface QLLiveDecorateSectionLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic ,strong) UIColor * backgroundColor;
@property (nonatomic ,assign) CGFloat cornerRadius;
@property (nonatomic ,assign) id<QLLiveComponentBackgroundDecorateAble> builder;
@end

@interface QLLiveDecorateSectionView : UICollectionReusableView

@end

NS_ASSUME_NONNULL_END
