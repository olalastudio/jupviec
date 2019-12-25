//
//  JUntil.h
//  JupViec
//
//  Created by KienVu on 12/18/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

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

+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code;
+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code completionHandler:(void(^)(POPUP_ACTION action))completionHandler;

@end

NS_ASSUME_NONNULL_END
