Pod::Spec.new do |s|
  s.name             = "NHFHorizontalPickerView"
  s.version          = "1.0.3"
  s.summary          = "左右滑动选择文本数据"
  s.homepage         = "https://github.com/nhfc99/NHFHorizontalPickerView"
  s.license          = 'MIT'
  s.author           = {"牛宏飞"=>"nhfc99@163.com"}  
  s.source           = {:git => "https://github.com/nhfc99/NHFHorizontalPickerView.git", :commit => "HorizontalPickerViewUICollectionViewCell",:tag => s.version.to_s}

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true
  s.source_files = 'NHFHorizontalPickerView/HorizontalPickerView/*.{h,m},NHFHorizontalPickerView/HorizontalPickerView/HorizontalPickerViewUICollectionViewCell/*.{h,m}'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
