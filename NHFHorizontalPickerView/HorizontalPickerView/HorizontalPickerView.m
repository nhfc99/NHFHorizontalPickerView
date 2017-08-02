//
//  HorizontalPickerView.m
//  NHFHorizontalPickerView
//
//  Created by niuhongfei on 2017/7/27.
//  Copyright © 2017年 JinHe. All rights reserved.
//

#import "HorizontalPickerView.h"
#import "HorizontalPickerViewUICollectionViewCell.h"

static NSString * identifier = @"HorizontalPickerViewCellID";

static BOOL isCan = true;

@interface HorizontalPickerView () {
    CGFloat everyWidth;
    UIFont *font;
}

@property (nonatomic, retain) NSArray *resource;
@property (nonatomic, retain) NSMutableArray *zeroArray;
@property (nonatomic, assign) CGFloat minimumLineSpacing;

@end

@implementation HorizontalPickerView

- (void)setResource:(NSArray *)list {
    @synchronized (self) {
        if (list.count > 0) {
            CGFloat maxWidth = 0.f;
            for (NSString *str in list) {
                everyWidth = [HorizontalPickerView labelConstrainedToSize:str font:font].width;
                if (everyWidth > maxWidth) {
                    maxWidth = everyWidth;
                }
            }
            everyWidth = maxWidth+4;
            
            //视图上能看到几个cell
            NSInteger viewShowNumber = (CGRectGetWidth(self.frame)/2)/everyWidth;
            if (lrint(CGRectGetWidth(self.frame)) % lrint(everyWidth) != 0) {
                viewShowNumber ++;
            }
            
            if (viewShowNumber % 2 != 0) {
                viewShowNumber ++;
            }
            
            _zeroArray = [NSMutableArray new];
            for (int i=0; i<viewShowNumber; i++) {
                [_zeroArray addObject:@" "];
            }
            
            NSMutableArray *data = [[NSMutableArray alloc] initWithArray:_zeroArray];
            [data addObjectsFromArray:list];
            [data addObjectsFromArray:_zeroArray];
            
            //设置数据源
            _resource = [[NSArray alloc] initWithArray:data];
            
            //更新数据
            [_collectionView reloadData];
            
            //默认滚动到第一个位置上
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setScrollToCell:1];
            });
        }
    }
}

- (void)setScrollToCell:(NSInteger)item {
    if (isCan) {
        isCan = false;
        NSInteger count = _zeroArray.count + item;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count-1 inSection:0];
        HorizontalPickerViewUICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [_collectionView setContentOffset:CGPointMake(CGRectGetMidX(cell.frame)-CGRectGetWidth(self.frame)/2, 0) animated:true];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isCan = true;
        });
    }
}

- (instancetype)initWithFrame:(CGRect)frame
           minimumLineSpacing:(CGFloat)minimumLineSpacing {
    self = [super initWithFrame:frame];
    if (self) {
        font = [UIFont boldSystemFontOfSize:15];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(CGRectGetHeight(frame), CGRectGetHeight(frame));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = minimumLineSpacing;
        _minimumLineSpacing = minimumLineSpacing;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[HorizontalPickerViewUICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return self;
}

#pragma mark - UICollectionView
//有多少的分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = [[NSArray alloc] initWithArray:_resource];
    return array.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(everyWidth, CGRectGetHeight(self.frame));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HorizontalPickerViewUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSArray *array = [[NSArray alloc] initWithArray:_resource];
    if (array.count > indexPath.row) {
        CGPoint center = collectionView.center;
        CGPoint cellCenter = [collectionView convertPoint:cell.center toView:self];
        CGFloat offset = center.x - cellCenter.x;
        CGFloat value = - offset*1/2.f;
        CGFloat radiants = value / 360.0 * 2 * M_PI;
        [cell.contentLabel setText:array[indexPath.row]];
        [cell.contentLabel setTextColor:[UIColor colorWithWhite:0 alpha:1-fabs(radiants)/3.14f*4]];
        [cell.contentLabel setFont:font];
        
        CALayer *layer = cell.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -90;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, radiants, 0, 1, 0);
        layer.transform = rotationAndPerspectiveTransform;
    }
    return cell;
}

//选择某个Item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalPickerViewUICollectionViewCell *middleCell = (HorizontalPickerViewUICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self stringTrim:middleCell.contentLabel.text].length > 0) {
        [self changeToCell:middleCell scrollView:collectionView animated:true];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndScrollingAnimation:) object:scrollView];
    
    [_collectionView reloadData];
    
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:scrollView afterDelay:0.5];
}

//结束滚动的时候促发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    @synchronized (self) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndScrollingAnimation:) object:scrollView];
        
        CGPoint offsetPt = scrollView.contentOffset;
        CGFloat middleX = offsetPt.x + CGRectGetWidth(self.frame)/2;//当前中间位置
        
        NSArray *visibleCells = _collectionView.visibleCells;
        NSArray *cells = [self removeCellEmpty:visibleCells];
        if (cells.count == 0) {
            if (visibleCells.count > 0) {
                //如果为空的时候先检查是前段还是后段
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_resource.count-_zeroArray.count/2) inSection:0];
                HorizontalPickerViewUICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
                if (CGRectGetMinX(cell.frame) > middleX) {//说明在最前段
                    [self setScrollToCell:1];
                } else {
                    [self setScrollToCell:_resource.count-2*_zeroArray.count];
                }
            }
            return;
        }
        /***
         *  1.先检查是否停留在最前端和最后端，这个时候可以移动到第一个或者最后一个
         *  2.移动到最近的一个
         */
        //头部
        HorizontalPickerViewUICollectionViewCell *headerCell = cells.firstObject;
        CGPoint headerPoint = [_collectionView convertPoint:CGPointMake(CGRectGetMinX(headerCell.frame), 0) toView:self];
        //尾部
        HorizontalPickerViewUICollectionViewCell *endCell = cells.lastObject;
        CGPoint endPoint = [_collectionView convertPoint:CGPointMake(CGRectGetMinX(endCell.frame), 0) toView:self];
        
        CGFloat toOffset = 0;
        if (headerPoint.x >= CGRectGetWidth(self.frame)/2) {//前段
            if (headerCell.center.x >= middleX) {
                toOffset = headerCell.center.x - middleX;
            } else {
                toOffset = headerCell.center.x - middleX;
            }
            [self setContentOffset:CGPointMake(scrollView.contentOffset.x + toOffset, 0)
                          animated:false scrollView:scrollView
                              Cell:headerCell];
        } else if (endPoint.x <= CGRectGetWidth(self.frame)/2) {//后段
            CGFloat toOffset = 0;
            toOffset = endCell.center.x - middleX;
            [self setContentOffset:CGPointMake(scrollView.contentOffset.x + toOffset, 0)
                          animated:false scrollView:scrollView
                              Cell:endCell];
        } else {//中间段
            HorizontalPickerViewUICollectionViewCell *middleCell = [self getMiddleCellBy:cells middleX:middleX];
            [self changeToCell:middleCell scrollView:scrollView animated:false];
        }
    }
}

- (void)setContentOffset:(CGPoint)contentOffset
                animated:(BOOL)animated
              scrollView:(UIScrollView *)scrollView
                    Cell:(HorizontalPickerViewUICollectionViewCell *)cell {
    [scrollView setContentOffset:contentOffset animated:animated];
    
    if (_horizontalPickerViewSelect != nil) {
        _horizontalPickerViewSelect(cell.contentLabel.text);
    }
}

- (void)changeToCell:(HorizontalPickerViewUICollectionViewCell *)middleCell
          scrollView:(UIScrollView *)scrollView
            animated:(BOOL)animated {
    if (isCan) {
        isCan = false;
        if (middleCell != nil) {
            [self setContentOffset:CGPointMake(middleCell.center.x-CGRectGetWidth(self.frame)/2, 0)
                          animated:animated
                        scrollView:scrollView
                              Cell:middleCell];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                isCan = true;
            });
        } else {
            isCan = true;
        }
    }
}

- (NSArray *)removeCellEmpty:(NSArray *)cells {
    NSMutableArray *array = [NSMutableArray new];
    for (HorizontalPickerViewUICollectionViewCell *cell in cells) {
        NSString *contentString = [self stringTrim:cell.contentLabel.text];
        if (contentString.length > 0) {
            [array addObject:cell];
        }
    }
    [array sortUsingComparator:^NSComparisonResult(HorizontalPickerViewUICollectionViewCell *o1, HorizontalPickerViewUICollectionViewCell *o2) {
        CGFloat aNumber = o1.frame.origin.x;
        CGFloat bNumber = o2.frame.origin.x;
        
        if (aNumber < bNumber) {
            return NSOrderedAscending;
        }
        if (aNumber > bNumber) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return array;
}

- (NSString*)stringTrim:(NSString *)string
{
    if(string == nil)
    {
        return nil;
    }
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (HorizontalPickerViewUICollectionViewCell *)getMiddleCellBy:(NSArray *)cells
                                                      middleX:(CGFloat)middleX {
    HorizontalPickerViewUICollectionViewCell *cell = nil;
    CGFloat lastX = 0.f;
    for (HorizontalPickerViewUICollectionViewCell *theCell in cells) {
        CGFloat x = [_collectionView convertPoint:theCell.center toView:self].x;
        CGFloat both = fabs(x-CGRectGetWidth(self.frame)/2);
        if (lastX == 0 || both<lastX) {
            lastX = both;
            cell = theCell;
        }
    }
    
    return cell;
}

+ (CGSize)labelConstrainedToSize:(NSString*)content font:(UIFont*)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//必须是这组值,这个frame是初设的
    [label setNumberOfLines:0];  //必须是这组值
    CGSize contentSize;
    if([[[UIDevice currentDevice]  systemVersion] floatValue]<= 7.0)
    {
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        CGSize size = CGSizeMake(320,2000);
        CGSize labelsize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        label.frame = CGRectMake(0.0, 0.0, labelsize.width, labelsize.height );
        contentSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        CGSize size = CGSizeMake(320,2000);
        NSDictionary * attributes = @{NSFontAttributeName : font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        contentSize = [content boundingRectWithSize:size
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil].size;
    }
    return contentSize;
}


@end













