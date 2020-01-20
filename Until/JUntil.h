//
//  JUntil.h
//  JupViec
//
//  Created by KienVu on 12/18/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequest.h"
#import "CommonDefines.h"

#import <AFNetworking/AFNetworking.h>

#include <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUntil : NSObject

+(double)timeNumberFromString:(NSString*)string;
+(NSString*)timeStringFromNumber:(double)number;

+ (INTERNET_STATUS)internetConnectionStatus;
+ (void)monitorNetworkReachabilityChanges;

+(NSString*)stringFromDate:(NSDate*)date;
+(NSString*)stringFromDateAndTime:(NSDate*)date;
+(NSDate*)dateFromString:(NSString*)string;
+(NSInteger)hourFromDate:(NSDate*)date;
+(NSInteger)minuteFromDate:(NSDate*)date;

+(NSString*)stringDisplayWithID:(NSString*)strID withCategory:(NSString*)category fromDefinesDictionary:(NSDictionary*)defines;
+(UIColor*)colorDisplayForStatusID:(NSString*)colorID;

+(void)sendFCMDeviceTokenToServer:(NSString* _Nullable )userToken;

+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code;
+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code completionHandler:(void(^)(POPUP_ACTION action))completionHandler;

+(void)downloadFileFromURL:(NSString*)fileURL completionHandler:(void(^)(NSURL *file))completionHandler;
+(BOOL)imageExisted:(NSString*)imagename;
+(NSString*)pathOfFile:(NSString*)filename;

@end

NS_ASSUME_NONNULL_END
