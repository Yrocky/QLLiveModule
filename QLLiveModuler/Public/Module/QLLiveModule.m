//
//  QLLiveModule.m
//  BanBanLive
//
//  Created by rocky on 2020/7/9.
//  Copyright © 2020 伴伴网络. All rights reserved.
//

#import "QLLiveModule.h"
//#import <YTKNetwork/YTKNetwork.h>
#import "QLLiveModelEnvironment.h"
#import "QLLiveModuleDataSource_Private.h"

@interface QLLiveModule (){
    NSArray<__kindof QLLiveComponent *> * _defaultComponents;
}
@property (nonatomic ,assign) BOOL haveDefaultComponents;
@end

@implementation QLLiveModule

- (void)dealloc
{
    NSLog(@"%@ dealloc",self);
}

- (instancetype)init{
    return [self initWithName:@""];
}

- (instancetype)initWithName:(NSString *)name{
    return [self initWithName:name viewController:nil];
}

- (instancetype)initWithName:(NSString *)name
              viewController:(nullable UIViewController *)viewController{
    self = [super init];
    if (self) {
        _name = name;
        
        _index = 1;
        _pageSize = 20;
        _isRefresh = YES;
        
        _shouldLoadMore = YES;
        
        _dataSource = [QLLiveModuleDataSource new];
    }
    return self;
}

- (NSArray<__kindof QLLiveComponent *> *) defaultComponents{
    return nil;
}

- (void) refresh{
    // 如果有默认的comp，就先展示出来
    if (!_defaultComponents) {
        _defaultComponents = [self defaultComponents];
        self.haveDefaultComponents = _defaultComponents.count != 0;
        if (self.haveDefaultComponents) {
            [self.dataSource addComponents:_defaultComponents];
            [self.collectionView reloadData];
        }
    }
    
    _isRefresh = YES;
    [self resetIndex];
    [self fetchModuleDataFromService];
}

- (void) loadMore{
    if (self.shouldLoadMore) {
        _isRefresh = NO;
        [self fetchModuleDataFromService];
    }
}

- (void)setupViewController:(UIViewController *)viewController collectionView:(UICollectionView *)collectionView{
    QLLiveModelEnvironment * environment = [QLLiveModelEnvironment new];
    environment.viewController = viewController;
    environment.collectionView = collectionView;
    
    self.dataSource.environment = environment;
}

- (UIViewController *)viewController {
    return self.dataSource.environment.viewController;
}

- (UICollectionView *)collectionView {
    return self.dataSource.environment.collectionView;
}
- (BOOL)empty{
    return [self.dataSource empty];
}

#pragma mark - private

- (void)fetchModuleDataFromService{
    
//    YTKRequest * request = [self fetchModuleRequest];
////    request.successOnMainQueue = NO;
//    [request startWithCompletionBlockWithSuccess:^(YTKRequest * _Nonnull request) {
//        if (self->_isRefresh) {
//            // clear
//            if (self.haveDefaultComponents) {
//                [self.dataSource clearExceptComponents:self->_defaultComponents];
//            } else {
//                [self.dataSource clear];
//            }
//        }
//        [self parseModuleDataWithRequest:request];
//        [self increaseIndex];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self wrapperSuccessUpdateForDelegate];
//        });
//    } failure:^(YTKRequest * _Nonnull request) {
//        [self wrapperFailUpdateForDelegate:request.error];
//    }];
}

- (void) resetIndex{
    _index = 1;
}

- (void) increaseIndex{
    _index ++;
}

#pragma mark - private M

- (void) wrapperSuccessUpdateForDelegate{
    if ([self.delegate respondsToSelector:@selector(liveModuleDidSuccessUpdateComponent:)]) {
        [self.delegate liveModuleDidSuccessUpdateComponent:self];
    }
}

- (void) wrapperFailUpdateForDelegate:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(liveModule:didFailUpdateComponent:)]) {
        [self.delegate liveModule:self didFailUpdateComponent:error];
    }
}

@end

@implementation QLLiveModule (SubclassingOverride)

- (__kindof YTKRequest *)fetchModuleRequest{
    return nil;
}

- (void) parseModuleDataWithRequest:(__kindof YTKRequest *)request{

}

- (UIView *) blankPageView{
    return nil;
}

@end

@implementation QLLiveCompositeModule{
@protected
    NSMutableArray<__kindof QLLiveModule *> *_innerModules;
}

- (instancetype)initWithName:(NSString *)name viewController:(nullable UIViewController *)viewController{
    
    self = [super initWithName:name viewController:viewController];
    if (self) {
        _innerModules = [NSMutableArray array];
    }
    return self;
}

- (void)addModule:(__kindof QLLiveModule *)module{
    if (module && [module isKindOfClass:QLLiveModule.class]) {
        [_innerModules addObject:module];
    }
}

- (NSArray<__kindof QLLiveModule *> *)modules{
    return [NSArray arrayWithArray:_innerModules];
}

@end

@implementation QLLivePureListModule

- (QLLivePureListModuleType) pureListModuleType{
    return QLLivePureListModuleReplace;
}

- (Class) pureListComponentClass{
    return QLLiveComponent.class;
}

- (__kindof QLLiveComponent *) setupPureComponentWithDatas:(NSArray *)datas{
    
    Class componentClass = [self pureListComponentClass];
    
    if (self.pureListModuleType == QLLivePureListModuleReplace) {
        [self.dataSource clear];
        if (datas.count) {
            QLLiveComponent * component = [componentClass new];
            if (![component isKindOfClass:QLLiveComponent.class]) {
                return nil;
            }
            [component addDatas:datas];
            [self.dataSource addComponent:component];
            return component;
        }
    } else if (self.pureListModuleType == QLLivePureListModuleAppend) {
        QLLiveComponent * component = [self.dataSource componentAtIndex:0];
        if (!component && datas.count) {
            component = [componentClass new];
            if (![component isKindOfClass:QLLiveComponent.class]) {
                return nil;
            }
            [self.dataSource addComponent:component];
        }
        // todo 去重
        [component addDatas:datas];
        return component;
    }
    return nil;
}
@end
