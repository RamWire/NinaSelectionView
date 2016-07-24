// The MIT License (MIT)
//
// Copyright (c) 2015-2016 RamWire ( https://github.com/RamWire )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#ifndef UIParameter_h
#define UIParameter_h

//RGB Color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//FullScreen 
#define FUll_VIEW_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define FUll_VIEW_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define FUll_CONTENT_HEIGHT_WITHOUT_TAB ([[UIScreen mainScreen] bounds].size.height-64)
#define SELFWIDTH self.frame.size.width
#define SELFHEIGHT self.frame.size.height
#define NinaNavigationBarHeight 64

//NinaSelectionView Parameters
#define PerNum  3 //Better between 2~5
#define Nina_View_Width FUll_VIEW_WIDTH
#define Nina_View_X (FUll_VIEW_WIDTH - Nina_View_Width) / 2
#define Nina_Button_X 15
#define Nina_Button_Height 30
#define Nina_Button_Width (Nina_View_Width - 2 * Nina_Button_X - (PerNum - 1) * Nina_Button_Space) / PerNum
#define Nina_Button_TopSpace 17.5
#define Nina_Button_Space 10
#define Hold_Duration 0.2

#endif /* UIParameter_h */
