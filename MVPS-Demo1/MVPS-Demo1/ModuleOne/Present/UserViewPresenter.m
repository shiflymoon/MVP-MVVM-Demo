//
//  UserViewPresenter.m
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import "UserViewPresenter.h"
#import "UserViewTableViewCell.h"
#import "UserService.h"

@interface UserViewPresenter()
@property (nonatomic,strong) UserService *userService;

@property (nonatomic, weak) id<UserViewProtocol> attachView;
@end

@implementation UserViewPresenter

#pragma mark - public method
- (void)attachView:(id <UserViewProtocol>)view {
    self.attachView = view;
}
/**
 这个是对外的入口，通过这个入口，实现多个对内部的操作，外部只要调用这个接口就可以了
 */
- (void)fetchData {
    [self getUserDatas];
}

- (void)getUserDatas {
    [self.attachView showIndicator];
    __weak typeof(self) wkself = self;
    [self.userService getUserInfosSuccess:^(NSDictionary *dic) {
        [wkself.attachView hideIndicator];
        NSArray *userArr = [dic valueForKey:@"data"];
        NSArray *dataArrays = [wkself processOriginDataToUIFriendlyData:userArr];
        
        @synchronized (wkself) {
            [wkself.uiDataArray removeAllObjects];
            [wkself.uiDataArray addObjectsFromArray:dataArrays];
        }
        [wkself.attachView userViewDataSourceReload];
        
        if (dataArrays.count == 0) {
            [wkself.attachView showEmptyView];
        }
        
    } andFail:^(NSDictionary *dic) {
        
    }];
}

#pragma mark - Private Method
/**
 如果数据比较复杂，或者UI渲染的数据只是其中很少一部分，将原数据处理，输出成UI渲染的数据。（题外话：这里其实还可以使用协议，提供不同的数据格式输出。）
 数据格式转换，可以移动到Service层
 @param originData 原始数据
 @return 将原始数据转换为UI需要数据
 */
- (NSArray<UserModel *> *)processOriginDataToUIFriendlyData:(NSArray *)originData {
    NSMutableArray<UserModel *> *friendlyUIData = [NSMutableArray array];
    for (NSDictionary *dic in originData) {
        if ([[dic valueForKey:@"gender"] isEqualToString:@"male"]) {
            UserModel *model = [UserModel userWithDict:dic];
            [friendlyUIData addObject:model];
        }
    }
    return friendlyUIData;
}


#pragma mark - UITableViewDataSource 

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     UserViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UserViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    UserModel *model = self.uiDataArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.uiDataArray.count;
}

#pragma mark - getter
-(NSMutableArray <UserModel *> *) uiDataArray {
    if(!_uiDataArray) {
        _uiDataArray = [NSMutableArray array];
    }
    return _uiDataArray;
}

-(UserService *) userService {
    if( nil == _userService) {
        _userService = [UserService new];
    }
    return _userService;
}
@end
