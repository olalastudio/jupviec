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

#define ID_FCM_DEVICE_TOKEN     @"FCM_TOKEN"

#define NETWORK_REACHABILITY_STATUS_CHANGED_NOTIFICATION    @"NETWORK_REACHABILITY_STATUS_CHANGED_NOTIFICATION"

#pragma mark API
#define ADDRESS_SERVER          @"http://52.221.107.104:8080"
#define API_V1                  @"api/v1"
#define API_GETOTP              @"get-otp"
#define API_REGISTER            @"register"
#define API_LOGIN               @"login"
#define API_FORGOT_PASS         @"forgot"
#define API_UPDATE_PASS         @"update-password"
#define API_REQUEST             @"request"
#define API_GET_ALL_REQUESTS    @"requests/myself"
#define API_GET_CONFIGURATION   @"configuration"
#define API_ACCOUNT             @"account"
#define API_RATE                @"rate"
#define API_GET_AVAILABLE_NOTI  @"notify-available"
#define API_NOTIFY              @"notify"
#define API_FEEDBACK            @"feedback"
#define API_CANCEL_REQUEST      @"cancer"
#define API_SEND_DEVICE_TOKEN   @"device"

#define ID_WELCOME_VIEW         @"idwelcomeview"

#define MODE_REGISTER_NEW_ACC   1
#define MODE_FORGOT_PASSWORD    2

#define ATTRIBUTE_START_TIME    @"starttime"
#define ATTRIBUTE_END_TIME      @"endtime"

#define CODE_DUNGLE             @"DUNGLE"
#define CODE_DATLE              @"DATLE"
#define CODE_DINHKY             @"DINHKY"
#define CODE_TONGVESINH         @"TONGVESINH"
#define CODE_SOFA               @"SOFA"

#define CODE_RUABAT             @"RUABAT"
#define CODE_NAUCOM             @"NAUCOM"
#define CODE_DICHO              @"DICHO"
#define CODE_GIATQAO            @"GIATQAO"

#define CODE_TIENMAT            @"TIENMAT"
#define CODE_CHUYENKHOAN        @"CHUYENKHOAN"

#define CODE_YEUCAUDICHVU       @"YEUCAUDICHVU"
#define CODE_YEUCAUTAMDUNG      @"YEUCAUTAMDUNG"
#define CODE_YEUCAUHUY          @"YEUCAUHUY"

#define CODE_ERR_ACCOUNT_EXIST      @"ERR_ACCOUNT_EXIST"
#define CODE_ERR_ACCOUNT_NOT_EXIST  @"ERR_ACCOUNT_NOT_EXIST"
#define CODE_ERR_PARAM_INVALID      @"ERR_PARAM_INVALID"
#define CODE_ERR_REQ_NOT_EXIST      @"ERR_REQ_NOT_EXIST"
#define CODE_ERR_NOTIFY_NOT_EXIST   @"ERR_NOTIFY_NOT_EXIST"
#define CODE_SUC_REMOVED            @"SUC_REMOVED"

#define CODE_CHUADOC            @"CHUADOC"
#define CODE_DADOC              @"DADOC"
#define CODE_DAXULY             @"DAXULY"

#define ID_REQUEST_TYPE         @"request_type"
#define ID_REQUESTER            @"requester"
#define ID_LOCATION             @"location"
#define ID_WORKING_DATE         @"working_date"
#define ID_WORKING_HOUR         @"working_hour"
#define ID_WORKING_TIME         @"working_time"
#define ID_WORK_DAYINWEEK       @"day_in_week"
#define ID_SERVICE_EXTEND       @"service_extend"
#define ID_PAYMENT_METHOD       @"payment_method"
#define ID_USER_NOTE            @"user_note"
#define ID_PRICE                @"price"

#define ID_SERVICE              @"id"

#define ID_BASE_HOUR            @"base_hour"
#define ID_BASE_PRICE           @"base_price"
#define ID_MIN_PRICE            @"min_price"
#define ID_CLIENT_STATUS        @"client_status"

#define CODE_DANGYEUCAU         @"DANGYEUCAU"
#define CODE_DADONDEP           @"DADONDEP"

#define ID_REQUEST_STATUS       @"request_status"
#define ID_PAYMENT_STATUS       @"payment_status"
#define ID_UPDATE_DATE          @"updated_at"
#define ID_TOTAL_PRICE          @"total_price"
#define ID_RATE_SCORE           @"rate_score"
#define ID_FEEDBACK             @"feedback"
#define ID_DEFINE_MESSAGE       @"define_message"
#define ID_FEEDBACK_STATUS      @"feedback_status"

#define ID_USER_TOKEN           @"ID_USER_TOKEN"
#define ID_USER_PHONENUMBER     @"ID_USER_PHONENUMBER"

typedef enum : NSUInteger {
    ACTION_OK,
    ACTION_CANCEL,
} POPUP_ACTION;

typedef enum : NSUInteger {
    RESPONSE_CODE_OTHER = 0,
    RESPONSE_CODE_PLACE_ORDER_SUCCESS = 1, //place order success
    RESPONSE_CODE_NORMARL = 200, //Normal operation
    RESPONSE_CODE_NODATA = 204, //is valid auth, but no data
    RESPONSE_CODE_INVALID = 400, //invalid body data, query param, missing header
    RESPONSE_CODE_INVALID_PASSWORD = 403, //invalid password, token expire or access is not available api
    RESPONSE_CODE_API_NOT_FOUND = 404, //API path not exist
    RESPONSE_CODE_SERVER_ERROR = 500, //some data can pass on validator but server error
    RESPONSE_CODE_NOINTERNET   = 501, //no internet
    RESPONSE_CODE_TIMEOUT      = 502, // timeout
    RESPONSE_CODE_NOT_LOGEDIN  = 503, //not logedin
} RESPONSE_CODE;

#define RESPONSE_TIMEOUT_VALUE  10 // 10s

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

typedef enum : NSUInteger {
    NOTICE_CHOISE_NOTICE,
    NOTICE_CHOISE_COUPON,
} NOTICE_CHOISE;

typedef enum :NSUInteger
{
    OFFLINE = 0,
    ONLINE = 1,
    UNKNOWN = 2,
}INTERNET_STATUS;

typedef enum : NSUInteger {
    DAY_NONE = 0,
    DAY_THU2,
    DAY_THU3,
    DAY_THU4,
    DAY_THU5,
    DAY_THU6,
    DAY_THU7,
    DAY_CN,
} DAYINWEEK;
