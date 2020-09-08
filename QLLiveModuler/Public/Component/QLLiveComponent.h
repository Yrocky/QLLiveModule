//
//  QLLiveComponent.h
//  BanBanLive
//
//  Created by rocky on 2020/7/9.
//  Copyright © 2020 伴伴网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLLiveModuleDataSourceAble.h"
#import "QLLiveBaseLayout.h"
#import "QLLiveComponentDecorateContents.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QLLiveComponentArrange) {
    /// 垂直
    QLLiveComponentArrangeVertical,
    /// 水平
    QLLiveComponentArrangeHorizontal,
}NS_SWIFT_NAME(QLLiveComponent.Arrange);

typedef NS_ENUM(NSInteger, QLLiveComponentDecorate) {
    /// 没有背景装饰效果
    QLLiveComponentDecorateNone,
    /// 只有item
    QLLiveComponentDecorateOnlyItem,
    /// header+item
    QLLiveComponentDecorateContainHeader,
    /// item+footer
    QLLiveComponentDecorateContainFooter,
    /// header+item+footer
    QLLiveComponentDecorateAll,
};//NS_SWIFT_NAME(QLLiveComponent.Decorate);
//Warning: 这里不能够使用NS_SWIFT_NAME

@protocol QLLiveComponentDecorateAble <NSObject>

@property (nonatomic ,assign) QLLiveComponentDecorate decorate;

@property (nonatomic ,assign) CGFloat radius;
@property (nonatomic ,assign) UIEdgeInsets inset;

// color/image/gradient
@property (nonatomic ,strong) QLLiveComponentDecorateContents * contents;

@end

@interface QLLiveComponent : NSObject{
    NSMutableArray *_innerDatas;
    __kindof QLLiveBaseLayout * _layout;
}

@property (nonatomic, weak, readonly) id<QLLiveModuleDataSourceAble> dataSource;
/*
 是否需要独立请求数据，有的comp需要自己请求数据，
 有的comp是在一个统一的接口中返回数据，default NO
 */
@property (nonatomic ,assign) BOOL independentDatas;
/*
 是否需要使用占位视图，在empty的时候回返回一个数据用来展示占位,default NO
 */
@property (nonatomic ,assign) BOOL needPlacehold;
/*
 当没有数据的时候，不在UI中展示，default NO
 */
@property (nonatomic ,assign) BOOL hiddenWhenEmpty;
/*
 arrange == QLLiveComponentArrangeHorizontal
 */
@property (nonatomic ,assign ,readonly) BOOL isOrthogonallyScrolls;
/*
 布局
 */
@property (nonatomic ,strong ,readonly) __kindof QLLiveBaseLayout * layout;
/*
 headerView是否要黏性
 */
@property (nonatomic ,assign) BOOL headerPin;

// 在DataSource中的索引
@property (nonatomic ,assign ,readonly) NSInteger index;

- (void) setupLayout:(__kindof QLLiveBaseLayout *)layout NS_SWIFT_NAME(setup(_:));

- (void) addData:(id)data NS_SWIFT_NAME(add(data:));
- (void) addDatas:(NSArray *)datas NS_SWIFT_NAME(add(datas:));

- (id) dataAtIndex:(NSInteger)index NS_SWIFT_NAME(dataAt(_:));

- (NSInteger)numberOfItems;

@property (nonatomic ,copy ,readonly) NSArray * datas;

- (BOOL) empty;

- (void) clear;

// 刷新当前component
- (void) reloadData;
- (void) reloadDataAt:(NSArray<NSNumber *> *)indexs;
@end

@interface QLLiveComponent (SubclassOverride)

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index;
- (__kindof UICollectionViewCell *)placeholdCellForItemAtIndex:(NSInteger)index;

#pragma mark - event

- (void)didSelectItemAtIndex:(NSInteger)index;
- (void)didDeselectItemAtIndex:(NSInteger)index;
- (void)didHighlightItemAtIndex:(NSInteger)index;
- (void)didUnhighlightItemAtIndex:(NSInteger)index;

@end

@interface QLLiveComponent (Supplementary)

- (NSArray<NSString *> *)supportedElementKinds;
- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind;
- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind;
- (UIEdgeInsets) insetForSupplementaryViewOfKind:(NSString *)elementKind;

@end

/// 背景修饰
@interface QLLiveComponent (BackgroundDecorate)

- (void) addDecorateWithBuilder:(void(^)(id<QLLiveComponentDecorateAble>builder))builder  NS_SWIFT_NAME(addDecorate(with:));
@end

NS_ASSUME_NONNULL_END
