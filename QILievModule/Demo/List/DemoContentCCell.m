//
//  DemoContentCCell.m
//  QILievModule
//
//  Created by rocky on 2020/8/10.
//  Copyright © 2020 Rocky. All rights reserved.
//

#import "DemoContentCCell.h"

@implementation DemoContentCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        self.contentView.layer.cornerRadius = 4.0f;
        self.contentView.layer.masksToBounds = YES;
        
        self.oneLabel = [UILabel new];
        self.oneLabel.textAlignment = NSTextAlignmentCenter;
        self.oneLabel.numberOfLines = 2;
        self.oneLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:self.oneLabel];
        
        [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.left.equalTo(self.contentView).mas_offset(5);
            make.right.equalTo(self.contentView).mas_offset(-5);
        }];
    }
    return self;
}
- (void) setupWithData:(id)data{
    self.oneLabel.text = QLSafeString(data);
}
@end

@implementation DemoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(16);
            make.height.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
- (void) setupHeaderTitle:(NSString *)title{
    self.titleLabel.text = QLSafeString(title);
}
@end
