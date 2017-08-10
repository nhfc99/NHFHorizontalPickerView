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
![运行效果](https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=美女&step_word=&hs=2&pn=90&spn=0&di=51531002820&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=2830086051%2C4083773277&os=2294650384%2C3174340124&simid=4109043415%2C762083051&adpicid=0&lpn=0&ln=3936&fr=&fmq=1502333774926_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=girl&bdtype=0&oriquery=&objurl=http%3A%2F%2Fimg02.tooopen.com%2Fimages%2F20150706%2Ftooopen_sy_133095179948.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bp555rjg_z%26e3Bv54AzdH3FetjoAzdH3Flccdl0_z%26e3Bip4s&gsm=1e&rpstart=0&rpnum=0)







