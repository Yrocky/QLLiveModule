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
#import "QLLiveComponentBackgroundDecorateContents.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QLLiveComponentArrange) {
    /// 垂直
    QLLiveComponentArrangeVertical,
    /// 水平
    QLLiveComponentArrangeHorizontal,
};

typedef NS_ENUM(NSInteger, QLLiveComponentBackgroundDecorateType) {
    /// 没有背景装饰效果
    QLLiveComponentBackgroundDecorateNone,
    /// 只有item
    QLLiveComponentBackgroundDecorateOnlyItem,
    /// header+item
    QLLiveComponentBackgroundDecorateContainHeader,
    /// item+footer
    QLLiveComponentBackgroundDecorateContainFooter,
    /// header+item+footer
    QLLiveComponentBackgroundDecorateAll,
};

@protocol QLLiveComponentBackgroundDecorateAble <NSObject>

@property (nonatomic ,assign) QLLiveComponentBackgroundDecorateType type;

@property (nonatomic ,assign) CGFloat radius;
@property (nonatomic ,assign) UIEdgeInsets inset;

// color/image/gradient
@property (nonatomic ,strong) QLLiveComponentBackgroundDecorateContents * contents;

@end

@interface QLLiveComponent<__covariant Data> : NSObject{
    NSMutableArray<Data> *_innerDatas;
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

- (void) addData:(Data)data;
- (void) addDatas:(NSArray<Data> *)datas;

- (Data) dataAtIndex:(NSInteger)index;

- (NSInteger)numberOfItems;

@property (nonatomic ,copy ,readonly) NSArray<Data> * datas;

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

- (void) addBackgroundDecorate:(void(^)(id<QLLiveComponentBackgroundDecorateAble>builder))builder;
@end

NS_ASSUME_NONNULL_END
