//
//  QLLiveBaseLayout.m
//  QILievModule
//
//  Created by rocky on 2020/8/12.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "QLLiveBaseLayout.h"
#import "QLLiveBaseLayout_Private.h"
#import "QLLiveModelEnvironment_Protocol.h"

@implementation QLLiveBaseLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _inset = UIEdgeInsetsZero;
        _itemSpacing = 5.0f;
        _lineSpacing = 5.0f;
    }
    return self;
}

- (CGFloat)insetContainerWidth{
    return [self.environment effectiveContentSizeWithInsets:self.inset].width;
}

- (void) clear{
    [_cacheItemFrame removeAllObjects];
    _cacheItemFrame = nil;
}

- (NSString *) cacheKeyAt:(NSInteger)index{
    return [NSString stringWithFormat:@"cache_%ld_itemFrame_key",(long)index];
}

- (void) cacheItemFrame:(CGRect)itemFrame at:(NSInteger)index{
    if (!_cacheItemFrame) {
        _cacheItemFrame = [NSMutableDictionary new];
    }
    NSString * key = [self cacheKeyAt:index];
    _cacheItemFrame[key] = [NSValue valueWithCGRect:itemFrame];

}

- (CGRect) itemFrameAtIndex:(NSInteger)index{
    
    CGRect itemFrame = CGRectZero;
    
    NSString * key = [self cacheKeyAt:index];
    if ([_cacheItemFrame.allKeys containsObject:key]) {
        itemFrame = [_cacheItemFrame[key] CGRectValue];
    }
    return itemFrame;
}

- (void) calculatorLayoutWithDatas:(NSArray *)datas{
    // override
}
@end
