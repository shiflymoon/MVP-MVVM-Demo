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

@interface UserViewPresenter : NSObject 

@property (nonatomic,strong) NSMutableArray<UserModel *> * uiDataArray;


#pragma mark - public method
//采用block来处理Present对View相关接口的调用，因为fetchData需要回调View多个接口，所以对每个需要回调
//的View接口单独定义了一个block，如果fetchData只会触发一个View的回调，那么可以把这个block直接写
//到fetchData上，如-(void) fetchData:(dispatch_block_t) fDataBlock
@property (nonatomic,copy) dispatch_block_t showIndicatorBlock;
@property (nonatomic,copy) dispatch_block_t hideshowIndicatorBlock;
@property (nonatomic,copy) dispatch_block_t showEmptyBlock;
@property (nonatomic,copy) dispatch_block_t  reloadTableViewBlock;

/**
 这个是对外的入口，通过这个入口，实现多个对内部的操作，外部只要调用这个接口就可以了
 */
- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
