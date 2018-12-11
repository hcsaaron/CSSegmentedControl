# CSSegmentedControl

`CSSegmentedControl` is a custom segmentedControl with popular style which is commonly used on iOS.

![CSSegmentedControl](https://github.com/hcsaaron/CSSegmentedControl/blob/master/Demo/CSSegmentedControl_Demo1.0.gif?raw=true?raw=true)

## Try the API
### Create new CSSegmentedControl and set items
```swift
//        CSSegmentedControl(items: <#T##[CSSegmentItem]#>)  // 实例化方法
//        CSSegmentedControl(titles: <#T##[String]#>)        // item只有title时可用这个实例化方法
        
        // 设置items
        segmentedControl.items = items
        
        // 样式配置
        segmentedControl.leftInset = 0                      // 左边inset
        segmentedControl.rightInset = 0                     // 右边inset
        segmentedControl.itemWidth = CSSegmentedControl.automaticDimension  // item宽度
        segmentedControl.itemSpacing = 10                   // item间距
        segmentedControl.selectedItemScale = 1              // 选中item的scale
        segmentedControl.indicatorWidth = CSSegmentedControl.automaticDimension // 指示条宽度
        segmentedControl.indicatorHeight = 2                // 指示条高度
        segmentedControl.indicatorAnimationType = .none     // 指示条的动画类型，无动画、默认平滑过渡、蠕动过渡
        segmentedControl.selectedItemScrollPosition = .none // 选中选项后的滚动位置，无滚动、滚到中间、左边、右边
        segmentedControl.separatorStyle = .none             // 底部分割线，无分割线、默认分割线
        segmentedControl.featherStyle = .none               // 左右两边的羽化层，无羽化、默认羽化
        segmentedControl.backgroundImage = nil              // 背景图片设置
        segmentedControl.indicatorColor = .black            // 指示条颜色
        segmentedControl.textFont = UIFont.systemFont(ofSize: 15)       // 字体大小
        segmentedControl.textColor = .gray                  // 文字颜色
        segmentedControl.selectedTextColor = .black         // 选中的文字颜色
```
