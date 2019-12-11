//
//  CommonDefines.h
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#ifndef CommonDefines_h
#define CommonDefines_h

//Sever 107.113.174.139:8088
#endif /* CommonDefines_h */

#pragma mark API
#define ADDRESS_SERVER      @"http://52.221.107.104:8080"
#define API_GETOTP          @"get-otp"
#define API_REGISTER        @"register"
#define API_LOGIN           @"login"
#define API_FORGOT_PASS     @"forgot"
#define API_UPDATE_PASS     @"update-password"
#define API_REQUEST         @"request"

#define ID_WELCOME_VIEW     @"idwelcomeview"

#define MODE_REGISTER_NEW_ACC   1
#define MODE_FORGOT_PASSWORD    2

typedef enum : NSUInteger {
    TYPE_DUNGLE = 0,
    TYPE_DUNGDINHKY = 1,
    TYPE_TONGVESINH = 2,
    TYPE_JUPSOFA = 3,
} TASK_TYPE;

typedef enum : NSUInteger {
    SESSION_TASK,
    SESSION_PROMOTION,
} SESSION_TYPE;
