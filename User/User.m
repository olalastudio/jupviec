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
@synthesize userAgeStr;
@synthesize userSexStr;
@synthesize userNameStr;
@synthesize userRoleStr;
@synthesize userBirthStr;
@synthesize userPhoneNum;
@synthesize userAddressStr;
@synthesize userHomeTownStr;
@synthesize userIdentifyCardStr;

-(id)initUserWithInfoData:(NSDictionary *)infoDict
{
    self = [super init];
    if (self && infoDict != nil)
    {
        userIDStr = [infoDict objectForKey:@"id"];
        userPhoneNum = [infoDict objectForKey:@"phone"];
        userRoleStr = [infoDict objectForKey:@"role"];
        userNameStr = [infoDict objectForKey:@"name"];
        userAgeStr = [infoDict objectForKey:@"age"];
        userBirthStr = [infoDict objectForKey:@"birth"];
        userSexStr = [infoDict objectForKey:@"sex"];
        userAddressStr = [infoDict objectForKey:@"address"];
        userIdentifyCardStr = [infoDict objectForKey:@"identity_card"];
        userHomeTownStr = [infoDict objectForKey:@"home_town"];
    }
    
    return self;
}

@end
