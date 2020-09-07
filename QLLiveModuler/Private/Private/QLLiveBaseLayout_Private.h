//
//  QLLiveBaseLayout+Private.h
//  QILievModule
//
//  Created by rocky on 2020/8/18.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"
#import "QLLiveModelEnvironment_Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLLiveBaseLayout ()
@property (nonatomic ,strong ,readwrite) id<QLLiveModelEnvironment> environment;

// 获取每一个index的位置
- (CGRect) itemFrameAtIndex:(NSInteger)index;

// 根据数据计算cell的位置
- (void) calculatorLayoutWithDatas:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
