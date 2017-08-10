//
//  HorizontalPickerViewUICollectionViewCell.m
//  NHFHorizontalPickerView
//
//  Created by niuhongfei on 2017/7/28.
//  Copyright © 2017年 JinHe. All rights reserved.
//

#import "HorizontalPickerViewUICollectionViewCell.h"

@implementation HorizontalPickerViewUICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setMasksToBounds:true];
        [self setBackgroundColor:[UIColor clearColor]];
        _contentLabel = [[RSMaskedLabel alloc] initWithFrame:CGRectMake(0, 0, 200.f, 200.f)];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [_contentLabel setMaskedTextEnabled:true];
        [_contentLabel setCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
        [self addSubview:_contentLabel];
    }
    return self;
}

@end
