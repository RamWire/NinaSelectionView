//
//  ViewController.m
//  NinaSelectionView
//
//  Created by RamWire on 16/7/20.
//  Copyright © 2016年 RamWire. All rights reserved.
//

#import "ViewController.h"
#import "UIParameter.h"
#import "NinaSelectionView.h"

@interface ViewController ()<NinaSelectionDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NinaSelectionView *ninaSelectionView;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation ViewController {
    NSString *changeStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Hello,Nina";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Tap" style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ninaSelectionView];
    [self.view addSubview:self.myTableView];
}

#pragma mark - LazyLoad
- (NinaSelectionView *)ninaSelectionView {
    if (!_ninaSelectionView) {
        _ninaSelectionView = [[NinaSelectionView alloc] initWithTitles:[self titlesArray] PopDirection:NinaPopFromLeftToMiddle];
        _ninaSelectionView.ninaSelectionDelegate = self;
        _ninaSelectionView.defaultSelected = 1;
        _ninaSelectionView.shadowEffect = YES;
    }
    return _ninaSelectionView;
}

#pragma mark - RightBarButtonItemAction
- (void)popAction {
    [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.5 usingNinaSpringWithDamping:0.8 initialNinaSpringVelocity:0.3];
}

#pragma mark - NinaSelectionDelegate
- (void)selectNinaAction:(UIButton *)button {
    NSLog(@"Select %li button",(long)button.tag);
    changeStr = button.titleLabel.text;
    [self.ninaSelectionView showOrDismissNinaViewWithDuration:0.3];
    [self.myTableView reloadData];
}

#pragma mark - TitlesArray
- (NSArray *)titlesArray {
    return @[
                     @"Curry",
                     @"Thompson",
                     @"Green",
                     @"Iguodala",
                     @"Durant",
                     @"Curry",
                     @"Thompson",
                     @"Green",
                     @"Iguodala",
                     @"Durant",
                     @"Curry",
                     @"Thompson",
                     @"Green",
                     @"Iguodala",
                     @"Durant",
                     @"Iguodala",
                     @"Durant",
                     @"Iguodala",
                     @"Durant",
                     @"Curry",
                     @"Thompson",
                     @"Green",
                     @"Iguodala",
                     @"Durant",
                     @"Iguodala",
                     @"Durant",
                     ];
}

#pragma mark - myTableView
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT_WITHOUT_TAB) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (changeStr.length == 0) {
        cell.textLabel.text = @"NinaSelectionView";
    }else {
        cell.textLabel.text = changeStr;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
