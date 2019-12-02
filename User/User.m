//
//  User.m
//  JupViec
//
//  Created by Khanhlt on 11/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userIDStr;
@synthesize userNameStr;
@synthesize userRoleStr;
@synthesize userPhoneNum;

-(id)initUserWithInfoData:(NSDictionary *)infoDict
{
    self = [super init];
    if (self && infoDict != nil)
    {
        userIDStr = [infoDict objectForKey:@"id"];
        userPhoneNum = [infoDict objectForKey:@"phone"];
        userRoleStr = [infoDict objectForKey:@"role"];
        userNameStr = [infoDict objectForKey:@"username"];
        _dictUserInfo = [infoDict objectForKey:@"general_information"];
        
    }
    
    return self;
}

@end
