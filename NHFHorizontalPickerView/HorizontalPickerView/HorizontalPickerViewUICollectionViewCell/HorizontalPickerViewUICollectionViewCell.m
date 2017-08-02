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
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_contentLabel];
    }
    return self;
}

@end
