//
//  UserService.h
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
*  Service 用来做数据获取工作等，发起网络请求，并且返回数据给Presenter，简化Presenter逻辑，同时业务接口单独测试
*/

typedef void(^SuccessHandler)( NSDictionary *dict);
typedef void(^FailHandler)( NSDictionary * _Nullable dict);

@interface UserService : NSObject


- (void)getUserInfosSuccess:(SuccessHandler)success andFail:(FailHandler)fail;

@end

NS_ASSUME_NONNULL_END
