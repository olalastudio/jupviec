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
@property (nonatomic, assign) NSString* userAgeStr;
@property (nonatomic, assign) NSString* userBirthStr;
@property (nonatomic, assign) NSString* userSexStr;
@property (nonatomic, assign) NSString* userAddressStr;
@property (nonatomic, assign) NSString* userIdentifyCardStr;
@property (nonatomic, assign) NSString* userHomeTownStr;

-(id)initUserWithInfoData:(NSDictionary*)infoDict;

@end

NS_ASSUME_NONNULL_END
