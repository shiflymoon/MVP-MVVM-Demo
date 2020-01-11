//
//  UserViewPresenter.h
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,UserViewState) {
    UserViewStateShowIndicator = 1,
    UserViewStateHideshowIndicator,
    UserViewStateShowEmpty,
    UserViewStateReloadTableView
};

@interface UserViewModel : NSObject 

@property (nonatomic,strong) NSMutableArray<UserModel *> * uiDataArray;


#pragma mark - public method
//将Presenter对View回调的所有接口定位为一系列枚举值，只要View监听到Presenter的viewState改变，可以直接响应了
@property (nonatomic,assign) UserViewState viewState;

/**
 这个是对外的入口，通过这个入口，实现多个对内部的操作，外部只要调用这个接口就可以了
 */
- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
