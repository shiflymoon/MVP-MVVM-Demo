//
//  UserModel.h
//  MVPS-Demo1
//
//  Created by 史贵岭 on 2020/1/11.
//  Copyright © 2020 史贵岭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSString *addr;

@property (nonatomic, strong) NSString *gender;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
