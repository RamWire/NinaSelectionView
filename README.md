![image](https://github.com/RamWire/NinaPagerView/blob/master/Example/Gifs/Slice header.png)
[![Language](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)](https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg)
[![Pod Version](http://img.shields.io/cocoapods/v/NinaSelectionView.svg?style=flat)](http://cocoadocs.org/docsets/NinaSelectionView/)
[![Pod Platform](http://img.shields.io/cocoapods/p/NinaSelectionView.svg?style=flat)](http://cocoadocs.org/docsets/NinaSelectionView/)
[![Pod License](http://img.shields.io/cocoapods/l/NinaSelectionView.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)<br />
🇨🇳[中文文档说明](https://github.com/RamWire/NinaSelectionView/blob/master/README_CN.md)
* A dramatic way to select your buttons by NinaSelectionView.

## Features
- [x] Low coupling to pop NinaSelectionView,just with one-line code methods to use it. 
- [x] Like AliPay pop style,and you can use it more flexible.
- [x] Supports 12 pop styles,you can pop from above,below,left and right. 
- [x] Pop to anywhere as you wish.
- [x] Support scroll when NinaSelection's height or width is longer than screen's.
- [x] NinaSelectionView buttons can drag and exchange as you wish.
- [x] Support Spring animation and normal animation.

## Preview
### Pop Styles
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewAbove.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewBelow.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewLeft.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewRight.gif)
### Drag Feature
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewDrag.gif)
### LongScrollState
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewHorizontal.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewVertical.gif)
![image](https://github.com/RamWire/NinaSelectionView/blob/master/Example/Gifs/NinaSelectionViewScroll.gif)

## Installation

Drop in the Classes folder to your Xcode project.  
You can also use cocoapods.

#### Using [CocoaPods](http://cocoapods.org/)

Add `pod 'NinaSelectionView'` to your `Podfile` and run `pod install`.

```
pod 'NinaSelectionView'
```

## Usage
You need add '**NinaSelectionView.h**'(**CocoaPods**) to your project.Then load the codes:
```objc
NinaSelectionView *ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:[self titlesArray] PopDirection:NinaPopFromAboveToTop];
[self.view addSubview:ninaSelectionView];
```
Then when you wanna show or dismiss NinaSelectionView,you need use:
```objc
[self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
```
or
```objc
[self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5];
```
Yeah,that's all!

### Other Settings and Tips
* You can set necessary Array by following codes(please read the **Example** notes if you wanna to know more).
```objc
NSArray *titleArray = @[
                        @"Curry",
                        @"Thompson",
                        @"Green",
                        @"Iguodala",
                        @"Durant"
                        ];
```
* To complete button actions,you need write **NinaSelectionDelegate** in your codes:
```objc
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Choose %li button",(long)button.tag);
}
```
* You can also set defaultSelected button,start from 1.
```objc
_ninaSelectionView.defaultSelected = 1;
```
* Meanwhile,shadow background also can be set.(You must set shadowEffect to **YES** first,then you can set shadowalpha)
```objc
_ninaSelectionView.shadowEffect = YES;
_ninaSelectionView.shadowAlpha = 0.4;
```
* If you wanna change buttons' parameters(column,width,height) or view frame,you can go to UIParameter.h to change them.

## Change Log
####v0.1.0
First Release.

## FeedBack
* If you find bugs in this project or any suggestions,hope you can give me feedback by issues or Email me to zhaogengda@126.com.

## Licence

This project uses MIT License.
