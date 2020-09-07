//
//  DemoCompositeListViewController.h
//  QILievModule
//
//  Created by rocky on 2020/8/9.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QLLiveModuler/QLLiveModuler.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoCompositeListViewController : UIViewController<
JXCategoryListContentViewDelegate>{
    JXCategoryListContainerView * _mainPageView;
}

- (instancetype) initWithModule:(QLLiveCompositeModule *)module;

@end

NS_ASSUME_NONNULL_END
