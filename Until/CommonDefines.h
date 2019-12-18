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
#define API_V1              @"api/v1"
#define API_GETOTP          @"get-otp"
#define API_REGISTER        @"register"
#define API_LOGIN           @"login"
#define API_FORGOT_PASS     @"forgot"
#define API_UPDATE_PASS     @"update-password"
#define API_REQUEST         @"request"
#define API_GET_ALL_REQUESTS    @"requests/myself"
#define API_GET_CONFIGURATION   @"configuration"
#define API_ACCOUNT             @"account"
#define API_RATE            @"rate"
#define API_GET_AVAILABLE_NOTI  @"notify-available"
#define API_NOTIFY          @"notify"

#define ID_WELCOME_VIEW     @"idwelcomeview"

#define MODE_REGISTER_NEW_ACC   1
#define MODE_FORGOT_PASSWORD    2

#define ATTRIBUTE_START_TIME    @"starttime"
#define ATTRIBUTE_END_TIME      @"endtime"

typedef enum : NSUInteger {
    TYPE_NONE = -1,
    TYPE_DUNGLE = 0,
    TYPE_DUNGDINHKY = 1,
    TYPE_TONGVESINH = 2,
    TYPE_JUPSOFA = 3,
} TASK_TYPE;

typedef enum : NSUInteger {
    SESSION_TASK = 0,
    SESSION_PROMOTION = 1,
} SESSION_TYPE;

typedef enum : NSUInteger {
    ATTRIBUTE_DIADIEM = 0,
    ATTRIBUTE_SONHACANHO = 1,
    ATTRIBUTE_NGAYLAMVIEC = 2,
    ATTRIBUTE_NGAYLAMTRONGTUAN = 3,
    ATTRIBUTE_NGAYKHAOSAT = 4,
    ATTRIBUTE_GIOKHAOSAT = 5,
    ATTRIBUTE_GIOLAMVIEC = 6,
    ATTRIBUTE_DICHVUKEMTHEO = 7,
    ATTRIBUTE_HINHTHUCTHANHTOAN = 8,
    ATTRIBUTE_BANGGIADICHVU = 9,
    ATTRIBUTE_GHICHU = 10,
} ORDER_ATTRIBUTE;

typedef enum : NSUInteger {
    SHIFT_WORK_MORNING = 0,
    SHIFT_WORK_AFTERNOON = 1,
    SHIFT_WORK_EVENING = 2,
} SHIFT_WORK;

typedef enum :NSUInteger
{
    OFFLINE = 0,
    ONLINE = 1,
    UNKNOWN = 2,
}INTERNET_STATUS;
