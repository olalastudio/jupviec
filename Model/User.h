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
@property (nonatomic, assign) NSString* userIDStr;
@property (nonatomic, assign) NSNumber* userPhoneNum;
@property (nonatomic, assign) NSString* userRoleStr;
@property (nonatomic, assign) NSString* userNameStr;
@property (nonatomic, weak) NSDictionary* dictUserInfo;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, assign) NSInteger userLevel;


-(id)initUserWithInfoData:(NSDictionary*)infoDict;

@end

NS_ASSUME_NONNULL_END
