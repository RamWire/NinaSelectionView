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

#import "NinaSelectionView.h"
#import "UIParameter.h"

@interface NinaSelectionView()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation NinaSelectionView {
    NSInteger selectionHeight;
    NinaPopDirection ninaDireciton;
    NSInteger columnNum;
    NSArray *ninaTitles;
    NSMutableArray *buttonArray;
    double tapDuration;
    CGFloat tapDamping;
    CGFloat tapVelocity;
    BOOL showState;
    BOOL verticalScrollMode;
    BOOL horizontalScrollMode;
    CGPoint ninaStartPoint;
    CGPoint ninaOriginPoint;
    BOOL ninaContain;
}

- (instancetype)initWithTitles:(NSArray *)titles PopDirection:(NinaPopDirection)direction {
    if (self = [super init]) {
        if (titles.count > 0) {
            self.hidden = YES;
            self.backgroundColor = [UIColor whiteColor];
            buttonArray = [NSMutableArray array];
            ninaDireciton = direction;
            ninaTitles = titles;
            selectionHeight = 0;
            columnNum = 0;
            if (titles.count % PerNum == 0) {
                columnNum = titles.count / PerNum;
            }else {
                columnNum = titles.count / PerNum + 1;
            }
            selectionHeight = Nina_Button_TopSpace * 2 + (Nina_Button_Height + Nina_Button_Space) * columnNum - Nina_Button_Space;
            if (selectionHeight > FUll_CONTENT_HEIGHT_WITHOUT_TAB) {
                verticalScrollMode = YES;
            }
            if (Nina_View_X < 0) {
                horizontalScrollMode = YES;
            }
            CGFloat defaultY = 0;
            CGFloat defaultX = horizontalScrollMode?0:Nina_View_X;
            switch (direction / 3) {
                case 0:
                    defaultY = -(selectionHeight);
                    break;
                case 1:
                    defaultY = selectionHeight + FUll_VIEW_HEIGHT;
                    break;
                case 2:
                    defaultX = -(Nina_View_Width);
                    if (direction == 7) {
                        defaultY = verticalScrollMode?0:(FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2;
                    }else if (direction == 8) {
                        defaultY = verticalScrollMode?0:FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight;
                    }
                    break;
                case 3:
                    defaultX = (FUll_VIEW_WIDTH);
                    if (direction == 10) {
                        defaultY = verticalScrollMode?0:(FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2;
                    }else if (direction == 11) {
                        defaultY = verticalScrollMode?0:FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight;
                    }
                    break;
                default:
                    break;
            }
            if (verticalScrollMode) {
                self.alwaysBounceVertical = YES;
                self.showsVerticalScrollIndicator = YES;
                if (horizontalScrollMode) {
                    self.bounces = NO;
                    self.contentSize = CGSizeMake(Nina_View_Width, selectionHeight);
                    self.alwaysBounceHorizontal = YES;
                    self.showsHorizontalScrollIndicator = YES;
                    self.frame = CGRectMake(defaultX, defaultY, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT_WITHOUT_TAB);
                }else {
                    self.contentSize = CGSizeMake(0, selectionHeight);
                    self.frame = CGRectMake(defaultX, defaultY, Nina_View_Width, FUll_CONTENT_HEIGHT_WITHOUT_TAB);
                }
            }else {
                if (horizontalScrollMode) {
                    self.contentSize = CGSizeMake(Nina_View_Width, 0);
                    self.alwaysBounceHorizontal = YES;
                    self.showsHorizontalScrollIndicator = YES;
                    self.frame = CGRectMake(defaultX, defaultY, FUll_VIEW_WIDTH, selectionHeight);
                }else {
                    self.scrollEnabled = NO;
                    self.frame = CGRectMake(defaultX, defaultY, Nina_View_Width, selectionHeight);
                }
            }
            [self createSelectionButton];
            [self addSubview:self.bottomLine];
        }else {
            NSLog(@"Titles-array's count should not be zero.");
        }
    }
    return self;
}

#pragma mark - SetMethod
- (void)setDefaultSelected:(NSInteger)defaultSelected {
    if (buttonArray.count > 0) {
        _defaultSelected = defaultSelected;
        UIButton *selectBtn = buttonArray[defaultSelected - 1];
        [self ninaSelectChangeColor:selectBtn];
    }
}

- (void)setShadowEffect:(BOOL)shadowEffect {
    _shadowEffect = shadowEffect;
    if (_shadowEffect) {
        [self.superview insertSubview:self.shadowView belowSubview:self];
        self.shadowView.alpha = 0.f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissNinaView)];
        [self.shadowView addGestureRecognizer:tap];
    }
}

- (void)setShadowAlpha:(CGFloat)shadowAlpha {
    if (_shadowEffect && shadowAlpha > 0.f) {
        _shadowAlpha = shadowAlpha;
        self.shadowView.alpha = _shadowAlpha;
    }else {
        NSLog(@"You must set ShadowEffect to YES then shadowAlpha should be worked.");
    }
}

- (void)setNina_popY:(CGFloat)nina_popY {
    if (nina_popY > 0 && nina_popY < FUll_CONTENT_HEIGHT_WITHOUT_TAB - SELFHEIGHT) {
        _nina_popY = nina_popY;
    }else {
        NSLog(@"Hey,your nina_popY is not fit for show NinaSelectionView.");
    }
}

#pragma mark - LazyLoad
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT_WITHOUT_TAB)];
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.5f;
    }
    return _shadowView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,selectionHeight - 2, Nina_View_Width, 2)];
        _bottomLine.backgroundColor = UIColorFromRGB(0xb2b2b2);
    }
    return _bottomLine;
}

#pragma mark - NinaSelectionMethod
- (void)showOrDismissNinaViewWithDuration:(NSTimeInterval)duration {
    NSArray *locateArray = [self showOrDismissDetailMethodWithDuration:duration];
    if (locateArray.count != 2) {
        return;
    }
    CGFloat ninaViewX = [locateArray[0] floatValue];
    CGFloat ninaViewY = [locateArray[1] floatValue];
    if (verticalScrollMode) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(ninaViewX, ninaViewY, (horizontalScrollMode?FUll_VIEW_WIDTH:Nina_View_Width), FUll_CONTENT_HEIGHT_WITHOUT_TAB);
        }completion:^(BOOL finished) {
            if (showState == NO) {
                self.hidden = YES;
            }
        }];
    }else {
        if ((ninaDireciton == 1 || ninaDireciton == 4 || ninaDireciton == 7 || ninaDireciton == 10) && showState) {
            ninaViewX = horizontalScrollMode ?0:Nina_View_X;
            ninaViewY = verticalScrollMode?0:(FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2;
        }
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(ninaViewX, (((_nina_popY > 0) && showState == YES)?_nina_popY:ninaViewY), (horizontalScrollMode?FUll_VIEW_WIDTH:Nina_View_Width), selectionHeight);
        } completion:^(BOOL finished) {
            if (showState == NO) {
                self.hidden = YES;
            }
        }];
    }
}

- (void)showOrDismissNinaViewWithDuration:(NSTimeInterval)duration usingNinaSpringWithDamping:(CGFloat)dampingRatio initialNinaSpringVelocity:(CGFloat)velocity {
    NSArray *locateArray = [self showOrDismissDetailMethodWithDuration:duration];
    if (locateArray.count != 2) {
        return;
    }
    CGFloat ninaViewX = [locateArray[0] floatValue];
    CGFloat ninaViewY = [locateArray[1] floatValue];
    CGFloat dampingOrNot = ((dampingRatio < 1) && (dampingRatio > 0))?dampingRatio:0.5;
    CGFloat damping = showState?dampingOrNot:1;
    CGFloat VelocityNum = ((velocity < 1) && (velocity > 0))?velocity:0.75;
    tapDamping = damping;
    tapVelocity = VelocityNum;
    if (verticalScrollMode) {
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:VelocityNum options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.frame = CGRectMake(ninaViewX, ninaViewY, (horizontalScrollMode?FUll_VIEW_WIDTH:Nina_View_Width), FUll_CONTENT_HEIGHT_WITHOUT_TAB);
        }completion:^(BOOL finished) {
            if (showState == NO) {
                self.hidden = YES;
            }
        }];
    }else {
        if ((ninaDireciton == 1 || ninaDireciton == 4 || ninaDireciton == 7 || ninaDireciton == 10) && showState) {
            ninaViewX = horizontalScrollMode ?0:Nina_View_X;
            ninaViewY = verticalScrollMode?0:(FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2;
        }
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:VelocityNum options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.frame = CGRectMake(ninaViewX, (((_nina_popY > 0) && showState == YES)?_nina_popY:ninaViewY), (horizontalScrollMode?FUll_VIEW_WIDTH:Nina_View_Width), selectionHeight);
        } completion:^(BOOL finished) {
            if (showState == NO) {
                self.hidden = YES;
            }
        }];
    }
}

#pragma mark - PrivateMethod
- (NSArray *)showOrDismissDetailMethodWithDuration:(NSTimeInterval)duration {
    tapDuration = duration;
    CGFloat ninaViewY = 0;
    CGFloat ninaViewX = horizontalScrollMode ?0:Nina_View_X;
    if (ninaDireciton == 2 || ninaDireciton == 5 || ninaDireciton == 8 || ninaDireciton == 11) {
        if (selectionHeight <= FUll_CONTENT_HEIGHT_WITHOUT_TAB) {
            ninaViewY = FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight;
        }
    }else if (ninaDireciton == 7 || ninaDireciton == 10) {
        ninaViewY = verticalScrollMode?0:(FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2;
    }else if (ninaDireciton == 8 || ninaDireciton == 11) {
        ninaViewY = verticalScrollMode?0:FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight;
    }
    if ((self.frame.origin.y == 0 && self.frame.origin.x == (horizontalScrollMode ?0:Nina_View_X)) || (self.frame.origin.y == _nina_popY && self.frame.origin.x == (horizontalScrollMode ?0:Nina_View_X)) || (self.frame.origin.x == (horizontalScrollMode ?0:Nina_View_X) && self.frame.origin.y == (FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight) / 2) || (self.frame.origin.y == FUll_CONTENT_HEIGHT_WITHOUT_TAB - selectionHeight && self.frame.origin.x == (horizontalScrollMode ?0:Nina_View_X))) {
        showState = NO;
        if (_shadowEffect) {
            [UIView animateWithDuration:duration animations:^{
                self.shadowView.alpha = 0.f;
            }];
        }
        switch (ninaDireciton / 3) {
            case 0:
                ninaViewY = verticalScrollMode?(-(FUll_CONTENT_HEIGHT_WITHOUT_TAB)):(-(selectionHeight));
                break;
            case 1:
                ninaViewY = verticalScrollMode?(FUll_CONTENT_HEIGHT_WITHOUT_TAB + FUll_VIEW_HEIGHT):(selectionHeight + FUll_VIEW_HEIGHT);
                break;
            case 2:
                ninaViewX = -(Nina_View_Width);
                break;
            case 3:
                ninaViewX = (FUll_VIEW_WIDTH);
                break;
            default:
                break;
        }
    }else {
        self.hidden = NO;
        showState = YES;
        [self.superview bringSubviewToFront:self];
        if (_shadowEffect) {
            [self.superview insertSubview:self.shadowView belowSubview:self];
            [UIView animateWithDuration:duration animations:^{
                if (_shadowAlpha > 0.f) {
                    self.shadowView.alpha = _shadowAlpha;
                }else {
                    self.shadowView.alpha = 0.5f;
                }
            }];
        }
    }
    return @[[NSString stringWithFormat:@"%f",ninaViewX],[NSString stringWithFormat:@"%f",ninaViewY]];
}

- (void)createSelectionButton {
    for (int i = 0; i < ninaTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 1;
        if(i < PerNum && i >= 0){
            button.frame = CGRectMake(Nina_Button_X +  i * (Nina_Button_Width + Nina_Button_Space) , Nina_Button_TopSpace, Nina_Button_Width, Nina_Button_Height);
        }else {
            button.frame = CGRectMake(Nina_Button_X +  (i % PerNum) * (Nina_Button_Width + Nina_Button_Space) , Nina_Button_TopSpace + (Nina_Button_Height + Nina_Button_Space) * (i / PerNum), Nina_Button_Width, Nina_Button_Height);
        }
        [button addTarget:self action:@selector(ninaButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[ninaTitles objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x656667) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 4;
        button.layer.borderColor = UIColorFromRGB(0xDBDCDD).CGColor;
        button.layer.borderWidth = 1;
        [self addSubview:button];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [button addGestureRecognizer:longGesture];
        [buttonArray addObject:button];
    }
}

#pragma mark - UILongPressGestureRecognizerAction
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender {
    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        ninaStartPoint = [sender locationInView:sender.view];
        ninaOriginPoint = btn.center;
        [UIView animateWithDuration:Hold_Duration animations:^{
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    }else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint newDragPoint = [sender locationInView:sender.view];
        CGFloat dragChangeX = newDragPoint.x - ninaStartPoint.x;
        CGFloat dragChangeY = newDragPoint.y - ninaStartPoint.y;
        btn.center = CGPointMake(btn.center.x + dragChangeX,btn.center.y + dragChangeY);
        NSInteger index = [self buttonIndexOfPoint:btn.center withDragButton:btn];
        if (index < 0) {
            ninaContain = NO;
        }else {
            [UIView animateWithDuration:Hold_Duration animations:^{
                CGPoint tempPoint = CGPointZero;
                UIButton *button = buttonArray[index];
                tempPoint = button.center;
                button.center = ninaOriginPoint;
                btn.center = tempPoint;
                ninaOriginPoint = btn.center;
                ninaContain = YES;
            }];
        }
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:Hold_Duration animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!ninaContain) {
                btn.center = ninaOriginPoint;
            }
        }];
    }
}

- (NSInteger)buttonIndexOfPoint:(CGPoint)point withDragButton:(UIButton *)btn {
    for (NSInteger i = 0; i < buttonArray.count; i++) {
        UIButton *button = buttonArray[i];
        if (button != btn) {
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

#pragma mark - NinaButtonAction
- (void)ninaButtonAciton:(UIButton *)button {
    [self ninaSelectChangeColor:button];
    if ([self.ninaSelectionDelegate respondsToSelector:@selector(selectNinaAction:)]) {
        [self.ninaSelectionDelegate selectNinaAction:button];
    }
}

#pragma mark - SelectColorChangeAction
- (void)ninaSelectChangeColor:(UIButton *)changeBtn {
    for (NSInteger i = 0; i < buttonArray.count; i++) {
        UIButton *whiteButton = buttonArray[i];
        whiteButton.titleLabel.textColor = UIColorFromRGB(0x656667);
        whiteButton.backgroundColor = [UIColor whiteColor];
        whiteButton.layer.borderColor = UIColorFromRGB(0xDBDCDD).CGColor;
    }
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeBtn.backgroundColor = [UIColor colorWithRed:95/255.0f green:178/255.0f blue:244/255.0f alpha:1.0f];
    changeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - TapAction
- (void)tapToDismissNinaView {
    if (tapDamping > 0 && tapVelocity > 0) {
        [self showOrDismissNinaViewWithDuration:tapDuration usingNinaSpringWithDamping:tapDamping initialNinaSpringVelocity:tapVelocity];
    }else {
        [self showOrDismissNinaViewWithDuration:tapDuration];
    }
}

@end
