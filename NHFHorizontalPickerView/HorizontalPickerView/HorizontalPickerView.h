//
//  HorizontalPickerView.h
//  NHFHorizontalPickerView
//
//  Created by niuhongfei on 2017/7/27.
//  Copyright © 2017年 JinHe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HorizontalPickerViewSelect)(NSString *object);

@interface HorizontalPickerView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) HorizontalPickerViewSelect horizontalPickerViewSelect;

- (void)setResource:(NSArray *)list;

- (instancetype)initWithFrame:(CGRect)frame
           minimumLineSpacing:(CGFloat)minimumLineSpacing;

- (void)setScrollToCell:(NSInteger)item;

@end
