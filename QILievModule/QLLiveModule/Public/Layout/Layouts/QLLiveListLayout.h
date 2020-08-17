//
//  QLLiveListLayout.h
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"
#import "QLLiveLayoutDescriber.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLLiveListLayout : QLLiveBaseLayout

@property (nonatomic ,strong) QLLiveLayoutDistribution * distribution;
@property (nonatomic ,strong) QLLiveLayoutItemRatio * itemRatio;

@end

NS_ASSUME_NONNULL_END
