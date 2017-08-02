//
//  ViewController.m
//  NHFHorizontalPickerView
//
//  Created by niuhongfei on 2017/7/27.
//  Copyright © 2017年 JinHe. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [NSMutableArray new];
    for (int i=1; i<200; i++) {
        [array addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    CGFloat offset = 49.f;
    HorizontalPickerView *horizontalPickerView = [[HorizontalPickerView alloc] initWithFrame:CGRectMake(offset, offset, CGRectGetWidth(self.view.frame)-2*offset, offset) minimumLineSpacing:8];
    [horizontalPickerView setBackgroundColor:[UIColor grayColor]];
    [horizontalPickerView setResource:array];
    horizontalPickerView.horizontalPickerViewSelect = ^(NSString *object) {
        NSLog(@"object = %@", object);
    };
    [self.view addSubview:horizontalPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
