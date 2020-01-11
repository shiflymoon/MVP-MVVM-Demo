//
//  UserViewProtocol.h
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
* UserViewProtocol 协议定义了一下方法，这些方法其实就是presenter对view层发送的命令
*/

@protocol UserViewProtocol <NSObject>

- (void)userViewDataSourceReload;

- (void)showIndicator;

- (void)hideIndicator;

- (void)showEmptyView;

@end

NS_ASSUME_NONNULL_END
