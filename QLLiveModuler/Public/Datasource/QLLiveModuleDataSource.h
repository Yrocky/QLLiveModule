//
//  QLHomeDataSource.h
//  BanBanLive
//
//  Created by rocky on 2020/6/28.
//  Copyright © 2020 伴伴网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QLLiveComponent.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QLLiveModuleDataSourceAble;

@interface QLLiveModuleDataSource : NSObject<
UICollectionViewDataSource,
UICollectionViewDelegate,
QLLiveModuleDataSourceAble>{
    
    NSMutableArray<__kindof QLLiveComponent *> *_innerComponents;
}

@property (nonatomic, nullable, weak) id <UICollectionViewDelegate> collectionViewDelegate;
@property (nonatomic, nullable, weak) id <UIScrollViewDelegate> scrollViewDelegate;

@end

@interface QLLiveModuleDataSource (ComponentsHandle)

- (void) clear;///<清空已有的全部comp数据
- (void) clearExceptComponents:(NSArray<__kindof QLLiveComponent *> *)components;

- (void) addComponent:(__kindof QLLiveComponent *)component NS_SWIFT_NAME(add(_:));
- (void) addComponents:(NSArray<__kindof QLLiveComponent *> *)components NS_SWIFT_NAME(add(_:));

- (void) insertComponent:(__kindof QLLiveComponent *)component atIndex:(NSInteger)index;
- (void) replaceComponent:(__kindof QLLiveComponent *)component atIndex:(NSInteger)index;

- (void) removeComponent:(__kindof QLLiveComponent *)component NS_SWIFT_NAME(remove(_:));
- (void) removeComponentAtIndex:(NSInteger)index  NS_SWIFT_NAME(removeComponentAt(_:));

- (__kindof QLLiveComponent *) componentAtIndex:(NSInteger)index;
- (NSInteger) indexOfComponent:(__kindof QLLiveComponent *)comp;

- (NSArray<__kindof QLLiveComponent *> *) components;

- (NSInteger) count;

- (BOOL)empty;
@end

NS_ASSUME_NONNULL_END
