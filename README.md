# NHFHorizontalPickerView
<h2>介绍</h2>
<p>左右滑动选择文本数据</p>
<h2>安装</h2>
<ul>
<li>pod 'NHFHorizontalPickerView'</li>
<li>手动下载然后将文件夹拖至工程中即可</li>
</ul>

<h2>使用方法</h2>
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

<h2>效果图</h2>
![运行效果](https://github.com/nhfc99/NHFHorizontalPickerView/raw/master/NHFHorizontalPickerView/HorizontalPickerView/H_example_ico.png)







