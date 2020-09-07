//
//  DemoSearchComponent.h
//  QILievModule
//
//  Created by rocky on 2020/8/19.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchComponent : QLLiveComponent

- (instancetype) initWithTitle:(NSString *)title;
@end

@interface SearchHistoryComponent : SearchComponent<QLLiveFlexLayoutDelegate>

@end

@interface SearchHotRankComponent : SearchComponent

@end

@interface SearchRecommendComponent : SearchComponent

@end
NS_ASSUME_NONNULL_END
