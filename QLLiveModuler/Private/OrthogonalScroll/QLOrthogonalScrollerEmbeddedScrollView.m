//
//  QLOrthogonalScrollerEmbeddedScrollView.m
//  BanBanLive
//
//  Created by rocky on 2020/7/7.
//  Copyright © 2020 伴伴网络. All rights reserved.
//

#import "QLOrthogonalScrollerEmbeddedScrollView.h"
#import "QLLiveModuleDataSource_Private.h"
#import "QLLiveModuleFlowLayout.h"

@implementation QLOrthogonalScrollerEmbeddedCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        _orthogonalScrollView = [[QLOrthogonalScrollerEmbeddedScrollView alloc] initWithFrame:CGRectZero collectionViewLayout:({
            QLLiveModuleFlowLayout * layout = QLLiveModuleFlowLayout.new;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout;
        })];
        self.orthogonalScrollView.backgroundColor = UIColor.clearColor;
        self.orthogonalScrollView.directionalLockEnabled = YES;
        self.orthogonalScrollView.showsHorizontalScrollIndicator = NO;
        self.orthogonalScrollView.showsVerticalScrollIndicator = NO;
        self.orthogonalScrollView.clipsToBounds = YES;
        [self.contentView addSubview:self.orthogonalScrollView];

        if (@available(iOS 11.0, *)) {
            self.orthogonalScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.orthogonalScrollView.frame = self.contentView.bounds;
}

- (void)prepareForReuse{
    [super prepareForReuse];
//    [self.orthogonalScrollView setContentOffset:CGPointZero animated:NO];
}
/*

 fixme:
 The behavior of the UICollectionViewFlowLayout is not defined because:
 the item height must be less than the height of the UICollectionView minus the section insets top and bottom values, minus the content insets top and bottom values.
 The relevant UICollectionViewFlowLayout instance is <UICollectionViewFlowLayout: 0x7fd12c52fce0>, and it is attached to <QLOrthogonalScrollerEmbeddedScrollView: 0x7fd12d02aa00; baseClass = UICollectionView; frame = (0 0; 404 40); gestureRecognizers = <NSArray: 0x6000028c1950>; layer = <CALayer: 0x60000260c480>; contentOffset: {68, 0}; contentSize: {472.16666666666663, 40}; adjustedContentInset: {0, 0, 0, 0}; layout: <UICollectionViewFlowLayout: 0x7fd12c52fce0>; dataSource: <QLOrthogonalScrollerSectionController: 0x600002859290>>.
 Make a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch this in the debugger.
 */
+ (NSString *) reuseIdentifier{
    return @"QLOrthogonalScrollerEmbeddedCCell";
}

@end

@implementation QLOrthogonalScrollerEmbeddedScrollView

@end

@interface QLOrthogonalScrollerSectionController ()<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
QLLiveModuleFlowLayout>

@property (nonatomic, strong) NSMutableSet<NSString *> *registeredCellIdentifiers;

@property (nonatomic ,weak) id<UICollectionViewDelegateFlowLayout> collectionViewDelegate;
@end

@implementation QLOrthogonalScrollerSectionController
- (void)dealloc
{
    NSLog(@"%@ dealloc",self);
}
- (instancetype)initWithSectionIndex:(NSInteger)sectionIndex
                      collectionView:(UICollectionView *)collectionView
                          scrollView:(QLOrthogonalScrollerEmbeddedScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.sectionIndex = sectionIndex;
        self.collectionView = collectionView;
        self.scrollView = scrollView;

        // fixme
        self.collectionViewDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        
        self.registeredCellIdentifiers = [NSMutableSet new];
        
        scrollView.dataSource = self;
        scrollView.delegate = self;
    }
    return self;
}

- (__kindof UICollectionViewCell *) dequeueReusableCell:(Class)cellClass withReuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath{
    
    if (![self.registeredCellIdentifiers containsObject:reuseIdentifier]) {
        [self.registeredCellIdentifiers addObject:reuseIdentifier];
        [self.scrollView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
    }
    return [self.scrollView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                      forIndexPath:({
        [NSIndexPath indexPathForItem:indexPath.item inSection:0];
    })];
}

- (NSIndexPath *) wrapIndexPath:(NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForItem:indexPath.item inSection:self.sectionIndex];
}

- (BOOL) canForwardMethodToCollectionViewDelegate:(SEL)sel{
    return [self.collectionViewDelegate respondsToSelector:sel];
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionView.dataSource collectionView:collectionView
                                   numberOfItemsInSection:self.sectionIndex];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionView.dataSource collectionView:collectionView cellForItemAtIndexPath:({
        [self wrapIndexPath:indexPath];
    })];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - QLLiveModuleFlowLayout

- (QLLiveComponent *)collectionView:(UICollectionView *)collectionView layout:(QLLiveModuleFlowLayout *)collectionViewLayout componentAtSection:(NSInteger)section{
    if ([self.collectionView.dataSource isKindOfClass:[QLLiveModuleDataSource class]]) {
        QLLiveModuleDataSource * dataSource = (QLLiveModuleDataSource *)self.collectionView.dataSource;
        if ([dataSource respondsToSelector:_cmd]) {
            return [dataSource collectionView:collectionView
                                       layout:collectionViewLayout
                           componentAtSection:self.sectionIndex];
        }
    }
    return nil;
}

#pragma mark - Delegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return [self.collectionViewDelegate collectionView:collectionView
//                                                layout:collectionViewLayout
//                                sizeForItemAtIndexPath:({
//        [self wrapIndexPath:indexPath];
//    })];
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return [self.collectionViewDelegate collectionView:collectionView
//                                                layout:collectionViewLayout
//                   minimumLineSpacingForSectionAtIndex:self.sectionIndex];
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return [self.collectionViewDelegate collectionView:collectionView
//                                                layout:collectionViewLayout
//              minimumInteritemSpacingForSectionAtIndex:self.sectionIndex];
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate collectionView:collectionView
                           didSelectItemAtIndexPath:[self wrapIndexPath:indexPath]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate collectionView:collectionView
                         didDeselectItemAtIndexPath:[self wrapIndexPath:indexPath]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate collectionView:collectionView
                        didHighlightItemAtIndexPath:[self wrapIndexPath:indexPath]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate collectionView:collectionView
                      didUnhighlightItemAtIndexPath:[self wrapIndexPath:indexPath]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if ([self canForwardMethodToCollectionViewDelegate:_cmd]) {
        [self.collectionViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)removeFromSuperview {
    [self.scrollView removeFromSuperview];
}

@end
