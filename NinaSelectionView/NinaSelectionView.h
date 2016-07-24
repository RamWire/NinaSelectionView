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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NinaPopDirection) {
    /**<  Pop from above   **/
    NinaPopFromAboveToTop = 0,
    NinaPopFromAboveToMiddle = 1,
    NinaPopFromAboveToBottom = 2,
    /**<  Pop from below   **/
    NinaPopFromBelowToTop = 3,
    NinaPopFromBelowToMiddle = 4,
    NinaPopFromBelowToBottom = 5,
    /**<  Pop from left   **/
    NinaPopFromLeftToTop = 6,
    NinaPopFromLeftToMiddle = 7,
    NinaPopFromLeftToBottom = 8,
    /**<  Pop from right   **/
    NinaPopFromRightToTop = 9,
    NinaPopFromRightToMiddle = 10,
    NinaPopFromRightToBottom = 11,
};

@protocol NinaSelectionDelegate <NSObject>

@optional
/**
 *  NinaSelectionDelegate
 *
 *  @param button Select Button.
 */
- (void)selectNinaAction:(UIButton *)button;

@end

@interface NinaSelectionView : UIScrollView
/**
 *  NinaSelectionView init method.
 *
 *  @param titles titles showing on NinaSelectionView.
 *  @param direction NinaSelection pops direction.
 *
 */
- (instancetype)initWithTitles:(NSArray *)titles PopDirection:(NinaPopDirection)direction;
/**
 *  Show or dismiss NinaSelectionView when you needed.(No spring effect)
 *
 *  @param duration NinaSelectionView pop animation time.
 */
- (void)showOrDismissNinaViewWithDuration:(NSTimeInterval)duration;
/**
 *  Show or dismiss NinaSelectionView when you needed.(With spring effect)
 *
 *  @param duration     NinaSelectionView pop animation time.
 *  @param dampingRatio NinaSelectionView damping level
 *  @param velocity     init pop speed level
 */
- (void)showOrDismissNinaViewWithDuration:(NSTimeInterval)duration usingNinaSpringWithDamping:(CGFloat)dampingRatio initialNinaSpringVelocity:(CGFloat)velocity;

/**
 *  Default Selected button tag number.(Range from 1~...)
 */
@property (nonatomic, assign) NSInteger defaultSelected;
/**
 *  Show shadowEffect or not.Default shadowAlpha is 0.5.
 */
@property (nonatomic, assign) BOOL shadowEffect;
/**
 *  If turn on shadowEffect,you can set alpha for shadowView.
 */
@property (nonatomic, assign) CGFloat shadowAlpha;
/**
 *  Set NinaSelection Pop Y.
 */
@property (nonatomic, assign) CGFloat nina_popY;
/**
 *  NinaSelectionDelegate
 */
@property (nonatomic, weak)id<NinaSelectionDelegate>ninaSelectionDelegate;

@end
