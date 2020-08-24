//
//  QLLiveModuleFlowLayout.m
//  Weather_App
//
//  Created by rocky on 2020/8/8.
//  Copyright © 2020 Yrocky. All rights reserved.
//

#import "QLLiveModuleFlowLayout.h"
#import "QLLiveDecorateSectionLayoutAttributes.h"
#import "QLLiveComponent_Private.h"
#import "QLLiveBaseLayout_Private.h"

@interface QLLiveModuleFlowLayout ()

@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, strong) NSMutableArray *itemHeights;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *sectionHeights;

/// Array to store attributes for all items includes headers, cells, and footers
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> * allItemAttributes;
/// Array of arrays. Each array stores item attributes for each section
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *sectionItemAttributes;
@property (nonatomic ,strong) NSMutableDictionary * decorateViewAttributes;
/// Dictionary to store section headers' attribute
@property (nonatomic, strong) NSMutableDictionary *headersAttribute;
/// Dictionary to store section footers' attribute
@property (nonatomic, strong) NSMutableDictionary *footersAttribute;

/// Array to store union rectangles
@property (nonatomic, strong) NSMutableArray *unionRects;
@end

@implementation QLLiveModuleFlowLayout

/// How many items to be union into a single rectangle
static const NSInteger unionSize = 20;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerClass:[QLLiveDecorateSectionView class]
    forDecorationViewOfKind:@"QLLiveDecorateSectionView"];
    }
    return self;
}

#pragma mark - override

- (void)prepareLayout {
    [super prepareLayout];

    // clear datas
    [self.unionRects removeAllObjects];
    [self.columnHeights removeAllObjects];
    [self.sectionHeights removeAllObjects];
    [self.itemHeights removeAllObjects];
    [self.allItemAttributes removeAllObjects];
    [self.headersAttribute removeAllObjects];
    [self.sectionItemAttributes removeAllObjects];
    [self.footersAttribute removeAllObjects];
    [self.decorateViewAttributes removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        // for safe
        return;
    }
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    
    UICollectionViewLayoutAttributes *attributes;

    CGFloat top = 0;
    for (NSInteger section = 0; section < numberOfSections; ++section) {
     
        QLLiveComponent * component;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:componentAtSection:)]) {
            component = [self.delegate collectionView:self.collectionView layout:self componentAtSection:section];
        }
        
        QLLiveBaseLayout * layout = component.layout;
        UIEdgeInsets sectionInset = layout.inset;
        
        NSArray * supportedKinds = [component supportedElementKinds];
        CGFloat headerHeight = 0.0f;
        // header
        if ([supportedKinds containsObject:UICollectionElementKindSectionHeader] &&
            self.scrollDirection != UICollectionViewScrollDirectionHorizontal) {
            headerHeight =
            [component sizeForSupplementaryViewOfKind:UICollectionElementKindSectionHeader].height;
            if (headerHeight > 0) {
                UIEdgeInsets headerInset =
                [component insetForSupplementaryViewOfKind:UICollectionElementKindSectionHeader];
                attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
                attributes.frame = (CGRect){
                    headerInset.left,
                    headerInset.top + top,
                    collectionViewWidth - (headerInset.left + headerInset.right),
                    headerHeight
                };
                
                self.headersAttribute[@(section)] = attributes;
                [self.allItemAttributes addObject:attributes];
                
                // 更新top
                top = CGRectGetMaxY(attributes.frame) + headerInset.bottom;
            }
        }
        top += sectionInset.top;
        
        // items
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray * itemAttributes = [NSMutableArray new];
        if (layout.arrange == QLLiveLayoutArrangeHorizontal &&
            self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            CGRect frame = CGRectZero;
            frame.origin.y = top;
            frame.origin.x = layout.inset.left;
            frame.size.width = layout.insetContainerWidth;
            frame.size.height = layout.horizontalArrangeContentHeight;
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:({
                [NSIndexPath indexPathForItem:0 inSection:section];
            })];
            attributes.frame = frame;
            [itemAttributes addObject:attributes];
            [self.allItemAttributes addObject:attributes];
        } else {
            for (NSInteger item = 0; item < itemCount; item++) {
                CGRect frame = [layout itemFrameAtIndex:item];
                frame.origin.y += ({
                    (self.scrollDirection == UICollectionViewScrollDirectionHorizontal ?
                    0 : top);
                });
                attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:({
                    [NSIndexPath indexPathForItem:item inSection:section];
                })];
                attributes.frame = frame;
                [itemAttributes addObject:attributes];
                [self.allItemAttributes addObject:attributes];
            }
        }
        [self.sectionItemAttributes addObject:itemAttributes];
        //
        top += layout.contentHeight;
        
        // footer
        CGFloat footerHeight = 0.0f;
        if ([supportedKinds containsObject:UICollectionElementKindSectionFooter] &&
            self.scrollDirection != UICollectionViewScrollDirectionHorizontal) {
            footerHeight =
            [component sizeForSupplementaryViewOfKind:UICollectionElementKindSectionFooter].height;
            if (footerHeight > 0) {
                UIEdgeInsets footerInset =
                [component insetForSupplementaryViewOfKind:UICollectionElementKindSectionFooter];
                attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
                attributes.frame = (CGRect){
                    footerInset.left,
                    footerInset.top + top,
                    collectionViewWidth - (footerInset.left + footerInset.right),
                    footerHeight
                };
                
                self.footersAttribute[@(section)] = attributes;
                [self.allItemAttributes addObject:attributes];
                
                // 更新top
                top = CGRectGetMaxY(attributes.frame) + footerInset.bottom;
            }
        }
        
        QLLiveComponentBackgroundDecorateBuilder * builder = component.backgroundDecorateBuilder;
        if (builder &&
            builder.type != QLLiveComponentBackgroundDecorateNone) {
            CGFloat y = 0;
            if (self.sectionHeights.count) {
                y = self.sectionHeights[self.sectionHeights.count - 1].floatValue;
            }
            CGFloat height = top - y;
            if (builder.type == QLLiveComponentBackgroundDecorateOnlyItem) {
                y += headerHeight;
                height -= (footerHeight + headerHeight);
            } else if (builder.type == QLLiveComponentBackgroundDecorateContainHeader) {
                height -= footerHeight;
            } else if (builder.type == QLLiveComponentBackgroundDecorateContainFooter) {
                y += headerHeight;
                height -= headerHeight;
            }
            
            QLLiveDecorateSectionLayoutAttributes * attr =
            [QLLiveDecorateSectionLayoutAttributes layoutAttributesForDecorationViewOfKind:@"QLLiveDecorateSectionView" withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attr.frame = [self calculatfDecorationViewFrame:sectionInset
                                               sectionFrame:CGRectMake(0, y, collectionViewWidth, height)
                                              decorateInset:builder.inset];
            attr.zIndex = -1;
            attr.builder = builder;
            attr.backgroundColor = [UIColor colorWithHexString:@"#8091a5"];
            self.decorateViewAttributes[@(section)] = attr;
            [self.allItemAttributes addObject:attr];
        }
        
        [self.sectionHeights addObject:@(top)];

    }
    
    // Build union rects
    NSInteger idx = 0;
    NSInteger itemCounts = [self.allItemAttributes count];
    while (idx < itemCounts) {
        CGRect unionRect = ((UICollectionViewLayoutAttributes *)self.allItemAttributes[idx]).frame;
        NSInteger rectEndIndex = MIN(idx + unionSize, itemCounts);

        for (NSInteger i = idx + 1; i < rectEndIndex; i++) {
            unionRect = CGRectUnion(unionRect, ((UICollectionViewLayoutAttributes *)self.allItemAttributes[i]).frame);
        }

        idx = rectEndIndex;

        [self.unionRects addObject:[NSValue valueWithCGRect:unionRect]];
    }
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.bounds.size;
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        contentSize.height = self.sectionHeights.lastObject.floatValue;
    } else {
        // 水平布局的时候，就只会有一个section，这里先这么获取数据，不是很优雅
        QLLiveBaseLayout * layout = [self.delegate collectionView:self.collectionView
                                                           layout:self componentAtSection:0].layout;
        contentSize.width = layout.contentWidth;
    }
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
    if (path.section >= [self.sectionItemAttributes count]) {
        return nil;
    }
    if (path.item >= [self.sectionItemAttributes[path.section] count]) {
        return nil;
    }
    return (self.sectionItemAttributes[path.section])[path.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        attribute = self.headersAttribute[@(indexPath.section)];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        attribute = self.footersAttribute[@(indexPath.section)];
    }
    return attribute;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:@"QLLiveDecorateSectionView"]) {
        attribute = self.decorateViewAttributes[@(indexPath.section)];
    }
    return attribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger i;
    NSInteger begin = 0, end = self.unionRects.count;
    NSMutableDictionary *cellAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *supplHeaderAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *supplFooterAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *decorAttrDict = [NSMutableDictionary dictionary];
    
    for (i = 0; i < self.unionRects.count; i++) {
        if (CGRectIntersectsRect(rect, [self.unionRects[i] CGRectValue])) {
            begin = i * unionSize;
            break;
        }
    }
    for (i = self.unionRects.count - 1; i >= 0; i--) {
        if (CGRectIntersectsRect(rect, [self.unionRects[i] CGRectValue])) {
            end = MIN((i + 1) * unionSize, self.allItemAttributes.count);
            break;
        }
    }
    for (i = begin; i < end; i++) {
        UICollectionViewLayoutAttributes *attr = self.allItemAttributes[i];
        if (CGRectIntersectsRect(rect, attr.frame)) {
            switch (attr.representedElementCategory) {
                case UICollectionElementCategorySupplementaryView:
                    if ([attr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                        supplHeaderAttrDict[attr.indexPath] = attr;
                    } else if ([attr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                        supplFooterAttrDict[attr.indexPath] = attr;
                    }
                    break;
                case UICollectionElementCategoryDecorationView:
                    decorAttrDict[attr.indexPath] = attr;
                    break;
                case UICollectionElementCategoryCell:
                    cellAttrDict[attr.indexPath] = attr;
                    break;
            }
        }
    }
    
    NSArray *result = [cellAttrDict.allValues arrayByAddingObjectsFromArray:supplHeaderAttrDict.allValues];
    result = [result arrayByAddingObjectsFromArray:supplFooterAttrDict.allValues];
    result = [result arrayByAddingObjectsFromArray:decorAttrDict.allValues];
    return result;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    switch (self.containerSection.orthogonalScrollingBehavior) {
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorContinuousGroupLeadingBoundary:
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging:
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPagingCentered:
//            return [self orthogonalContentOffsetForProposedContentOffset:proposedContentOffset scrollingVelocity:velocity];
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorNone:
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous:
//        case IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorPaging:
//            return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//    }
//}
//
//- (CGPoint)orthogonalContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
//                                         scrollingVelocity:(CGPoint)velocity {
//    IBPCollectionCompositionalLayoutSolver *solver = solvers.lastObject;
//    CGPoint contentOffset = CGPointZero;
//
//    CGRect layoutFrame = solver.layoutFrame;
//    CGFloat interGroupSpacing = solver.layoutSection.interGroupSpacing;
//
//    CGFloat width = CGRectGetWidth(layoutFrame);
//    CGFloat height = CGRectGetHeight(layoutFrame);
//
//    CGSize containerSize = self.collectionView.bounds.size;
//    CGPoint translation = [self.collectionView.panGestureRecognizer translationInView:self.collectionView.superview];
//
//    UICollectionViewScrollDirection scrollDirection = self.scrollDirection;
//    IBPUICollectionLayoutSectionOrthogonalScrollingBehavior orthogonalScrollingBehavior = self.containerSection.orthogonalScrollingBehavior;
//
//    if (orthogonalScrollingBehavior == IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorContinuousGroupLeadingBoundary) {
//        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
//            contentOffset.y += height * floor(proposedContentOffset.y / height) + interGroupSpacing * floor(proposedContentOffset.y / height) + height * (translation.y < 0 ? 1 : 0);
//            return contentOffset;
//        }
//        if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//            contentOffset.x += width * floor(proposedContentOffset.x / width) + interGroupSpacing * floor(proposedContentOffset.x / width) + width * (translation.x < 0 ? 1 : 0);
//            return contentOffset;
//        }
//    }
//    if (orthogonalScrollingBehavior == IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging) {
//        if (fabs(velocity.x) > 0.2) {
//            translation.x = width / 2 * (translation.x < 0 ? -1 : 1);
//        }
//        contentOffset.x += width * round((proposedContentOffset.x + translation.x) / width);
//        contentOffset.y += height * round((proposedContentOffset.y + translation.y) / height);
//
//        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
//            contentOffset.y += height * round(-translation.y / (height / 2)) + interGroupSpacing * round(-translation.y / (height / 2));
//            return contentOffset;
//        }
//        if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//            contentOffset.x += width * round(-translation.x / (width / 2)) + interGroupSpacing * round(-translation.x / (width / 2));
//            return contentOffset;
//        }
//    }
//    if (orthogonalScrollingBehavior == IBPUICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPagingCentered) {
//        if (fabs(velocity.x) > 0.2) {
//            translation.x = width / 2 * (translation.x < 0 ? -1 : 1);
//        }
//        contentOffset.x += width * round((proposedContentOffset.x + translation.x) / width);
//        contentOffset.y += height * round((proposedContentOffset.y + translation.y) / height);
//
//        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
//            contentOffset.y += height * round(-translation.y / (height / 2)) + interGroupSpacing * round(-translation.y / (height / 2)) - (containerSize.height - height) / 2;
//            return contentOffset;
//        }
//        if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//            contentOffset.x += width * round(-translation.x / (width / 2)) + interGroupSpacing * round(-translation.x / (width / 2)) - (containerSize.width - width) / 2;
//            return contentOffset;
//        }
//    }
//
//    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//}
#pragma mark - Private Methods

- (CGRect) calculatfDecorationViewFrame:(UIEdgeInsets)sectionInset sectionFrame:(CGRect)sectionFrame decorateInset:(UIEdgeInsets)decorateInset{

    CGRect decorateViewFrame = sectionFrame;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        decorateViewFrame.origin.x = sectionFrame.origin.x - (sectionInset.left - decorateInset.left);
        decorateViewFrame.origin.y -= (sectionInset.top - decorateInset.top);
        decorateViewFrame.size.width += (sectionInset.left - decorateInset.left) +
        (sectionInset.right - decorateInset.right);
        decorateViewFrame.size.height = sectionFrame.size.height + sectionInset.top + sectionInset.bottom - decorateInset.top - decorateInset.bottom;
    } else {
        decorateViewFrame.origin.x = sectionInset.left + decorateInset.left;
        decorateViewFrame.origin.y += (decorateInset.top);
        decorateViewFrame.size.width = sectionFrame.size.width - decorateInset.left - decorateInset.right - sectionInset.left - sectionInset.right;
        decorateViewFrame.size.height += (- decorateInset.top - decorateInset.bottom);
    }
    return decorateViewFrame;
}

#pragma mark - Private Accessors

- (NSMutableArray *)unionRects {
    if (!_unionRects) {
        _unionRects = [NSMutableArray array];
    }
    return _unionRects;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)itemHeights {
    if (!_itemHeights) {
        _itemHeights = [NSMutableArray array];
    }
    return _itemHeights;
}

- (NSMutableArray *)sectionHeights {
    if (!_sectionHeights) {
        _sectionHeights = [NSMutableArray array];
    }
    return _sectionHeights;
}

- (NSMutableArray *)allItemAttributes {
    if (!_allItemAttributes) {
        _allItemAttributes = [NSMutableArray array];
    }
    return _allItemAttributes;
}

- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = [NSMutableArray array];
    }
    return _sectionItemAttributes;
}

- (NSMutableDictionary *)decorateViewAttributes{
    if (!_decorateViewAttributes) {
        _decorateViewAttributes = [NSMutableDictionary new];
    }
    return _decorateViewAttributes;
}

- (NSMutableDictionary *)headersAttribute {
    if (!_headersAttribute) {
        _headersAttribute = [NSMutableDictionary dictionary];
    }
    return _headersAttribute;
}

- (NSMutableDictionary *)footersAttribute {
    if (!_footersAttribute) {
        _footersAttribute = [NSMutableDictionary dictionary];
    }
    return _footersAttribute;
}

- (id <QLLiveModuleFlowLayout> )delegate {
    return (id <QLLiveModuleFlowLayout> )self.collectionView.delegate;
}
@end
