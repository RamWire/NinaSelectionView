![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/Slice header2.png)
[![Language](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)
[![Pod Version](http://img.shields.io/cocoapods/v/NinaSelectionView.svg?style=flat)](http://cocoadocs.org/docsets/NinaSelectionView/)
[![Pod Platform](http://img.shields.io/cocoapods/p/NinaSelectionView.svg?style=flat)](http://cocoadocs.org/docsets/NinaSelectionView/)
[![Pod License](http://img.shields.io/cocoapods/l/NinaSelectionView.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)<br />
* 高灵活低耦合性地实现类似支付宝中余额宝累计收益界面筛选效果。

## 特点
- [x] 低耦合弹出NinaSelectionView，只需要一句代码即可实现，简单易用。
- [x] 高度接近支付宝筛选界面效果，您可以更灵活地去使用它。
- [x] 现已支持12种不同的弹出方式，从上下左右都可以pop出。
- [x] 几乎可以pop到界面的任何地方，具有高度的灵活性。
- [x] 当您设置的NinaSelectionView大于屏幕大小，它是可以进行滑动来适应各个条件下的情况。
- [x] 支持筛选按钮进行拖动和交换效果。
- [x] 弹出的动画效果可以选择正常或者弹簧效果，参数由您控制。

## 预览
### 弹出效果图(节选部分)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewAbove.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewBelow.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewLeft.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewRight.gif)
### 按钮拖动效果
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewDrag.gif)
### 滑动模式
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewHorizontal.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewVertical.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewScroll.gif)

## 安装

将NinaSelectionView文件夹拖入Xcode工程中
您也可以使用Cocoapods集成到您的工程中


#### 使用 [CocoaPods](http://cocoapods.org/)

在您的podfile中加入`pod 'NinaSelectionView'` 然后运行`pod install`。

```
pod 'NinaSelectionView'
```

## 使用
您需要将'**NinaSelectionView.h**'(**CocoaPods**)加入到您的工程中，然后执行下列代码:
```objc
NinaSelectionView *ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:[self titlesArray] PopDirection:NinaPopFromAboveToTop];
[self.view addSubview:ninaSelectionView];
```
接下来，当您想展示或者不展示NinaSelectionView时，您需要:
```objc
[self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
```
或者
```objc
[self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5];
```
即可！

### 其他设置和补充
* 在配置**NinaSelectionView**所需的数组时，您可以参照下方的代码进行配置(具体说明请看Example中的书写)。
```objc
NSArray *titleArray = @[
                        @"Curry",
                        @"Thompson",
                        @"Green",
                        @"Iguodala",
                        @"Durant"
                        ];
```
* 在响应按钮们的点击事件时，您需要遵守**NinaSelectionDelegate**代理方法:
```objc
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Choose %li button",(long)button.tag);
}
```
* 如果有默认选中按钮的需求，您可以对下方的参数进行设置，需要注意的是第一个按钮的defaultSelected为1:
```objc
_ninaSelectionView.defaultSelected = 1;
```
* 您可以对显示出来的阴影背景进行设置，可以选择不显示阴影背景(需要您注意的是，如果想对阴影的alpha值进行设定，您必须先要将shadowEffect设为**YES**)
```objc
_ninaSelectionView.shadowEffect = YES;
_ninaSelectionView.shadowAlpha = 0.4;
```
* If you wanna change buttons' parameters(column,width,height) or view frame,you can go to UIParameter.h to change them.如果您觉得默认的按钮参数(例如每排数量、高度、宽度)或整体NinaSelectionView的frame并不是您想要的，您可以去UIParameter.h进行设置，里面应该可以满足您的需求。

## 版本更新说明
####v0.1.0
第一个版本提交。

## 反馈
* 如果您在使用的过程中遇到任何问题或者建议，希望您issue我或者发邮件至zhaogengda@126.com，帮助我来完善它。

## Licence

This project uses MIT License.
