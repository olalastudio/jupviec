//
//  User.h
//  JupViec
//
//  Created by Khanhlt on 11/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString  *userToken;
@property (nonatomic, strong) NSString  *userIDStr;
@property (nonatomic, strong) NSString  *userPhoneNum;
@property (nonatomic, strong) NSString  *userRoleStr;
@property (nonatomic, strong) NSString  *userNameStr;
@property (nonatomic, strong) NSDictionary  *dictUserInfo;
@property (nonatomic, assign) NSInteger     userStatus;
@property (nonatomic, assign) NSInteger     userLevel;


-(id)initUserWithInfoData:(NSDictionary*)infoDict;

@end

NS_ASSUME_NONNULL_END
