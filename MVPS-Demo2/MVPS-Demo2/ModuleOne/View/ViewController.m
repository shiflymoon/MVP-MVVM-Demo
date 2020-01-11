//
//  ViewController.m
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import "ViewController.h"
#import "UserViewPresenter.h"
#import "UserViewTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) UserViewPresenter *presenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indicatorView];
    
    [self.presenter fetchData];
}

#pragma mark - Private & UserViewProtocol
- (void)userViewDataSourceReload {
    [self.tableView reloadData];
}

- (void)showIndicator {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideIndicator {
    [self.indicatorView stopAnimating];
}

- (void)showEmptyView {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"show empty view" preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertView animated:YES completion:^{
        
    }];
}


#pragma mark - UITableViewDataSource 

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     UserViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UserViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    UserModel *model = self.presenter.uiDataArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.uiDataArray.count;
}

#pragma mark - getter 
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;//这里指定给VC，也可以给Presenter，VC做部分逻辑
        _tableView.delegate = self; //这里指定给VC，也可以给Presenter，VC做部分逻辑
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (UserViewPresenter *)presenter {
    if (_presenter == nil) {
        _presenter = [[UserViewPresenter alloc] init];
        
        __weak typeof(self) wkself = self;
        
        _presenter.hideshowIndicatorBlock = ^{
            [wkself hideIndicator];
        };
        
        _presenter.showEmptyBlock = ^{
            [wkself showEmptyView];
        };
        
        _presenter.reloadTableViewBlock = ^{
            [wkself userViewDataSourceReload];
        };
        
        _presenter.showIndicatorBlock = ^{
            [wkself showIndicator]; 
        };
        
    }
    return _presenter;
}

@end
