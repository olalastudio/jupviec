//
//  JUntil.m
//  JupViec
//
//  Created by KienVu on 12/18/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JUntil.h"

@implementation JUntil

+(double)timeNumberFromString:(NSString*)string
{
    if ([string isEqualToString:@"00:00"]){return 0;}
    else if ([string isEqualToString:@"00:30"]){return 0.5;}
    else if ([string isEqualToString:@"01:00"]){return 1.0;}
    else if ([string isEqualToString:@"01:30"]){return 1.5;}
    else if ([string isEqualToString:@"02:00"]){return 2.0;}
    else if ([string isEqualToString:@"02:30"]){return 2.5;}
    else if ([string isEqualToString:@"03:00"]){ return 3.0;}
    else if ([string isEqualToString:@"03:30"]){ return 3.5;}
    else if ([string isEqualToString:@"04:00"]){ return 4.0;}
    else if ([string isEqualToString:@"04:30"]){ return 4.5;}
    else if ([string isEqualToString:@"05:00"]){ return 5.0;}
    else if ([string isEqualToString:@"05:30"]){ return 5.5;}
    else if ([string isEqualToString:@"06:00"]){ return 6.0;}
    else if ([string isEqualToString:@"06:30"]){ return 6.0;}
    else if ([string isEqualToString:@"07:00"]){ return 7.0;}
    else if ([string isEqualToString:@"07:30"]){ return 7.5;}
    else if ([string isEqualToString:@"08:00"]){ return 8.0;}
    else if ([string isEqualToString:@"08:30"]){ return 8.5;}
    else if ([string isEqualToString:@"09:00"]){ return 9.0;}
    else if ([string isEqualToString:@"09:30"]){ return 9.5;}
    else if ([string isEqualToString:@"10:00"]){ return 10.0;}
    else if ([string isEqualToString:@"10:30"]){ return 10.5;}
    else if ([string isEqualToString:@"11:00"]){ return 11.0;}
    else if ([string isEqualToString:@"11:30"]){ return 11.5;}
    else if ([string isEqualToString:@"12:00"]){ return 12.0;}
    else if ([string isEqualToString:@"12:30"]){ return 12.5;}
    else if ([string isEqualToString:@"13:00"]){ return 13.0;}
    else if ([string isEqualToString:@"13:30"]){ return 13.5;}
    else if ([string isEqualToString:@"14:00"]){ return 14.0;}
    else if ([string isEqualToString:@"14:30"]){ return 14.5;}
    else if ([string isEqualToString:@"15:00"]){ return 15.0;}
    else if ([string isEqualToString:@"15:30"]){ return 15.5;}
    else if ([string isEqualToString:@"16:00"]){ return 16.0;}
    else if ([string isEqualToString:@"16:30"]){ return 16.5;}
    else if ([string isEqualToString:@"17:00"]){ return 17.0;}
    else if ([string isEqualToString:@"17:30"]){ return 17.5;}
    else if ([string isEqualToString:@"18:00"]){ return 18.0;}
    else if ([string isEqualToString:@"18:30"]){ return 18.5;}
    else if ([string isEqualToString:@"19:00"]){ return 19.0;}
    else if ([string isEqualToString:@"19:30"]){ return 19.5;}
    else if ([string isEqualToString:@"20:00"]){ return 20.0;}
    else if ([string isEqualToString:@"20:30"]){ return 20.5;}
    else if ([string isEqualToString:@"21:00"]){ return 21.0;}
    else if ([string isEqualToString:@"21:30"]){ return 21.5;}
    else if ([string isEqualToString:@"22:00"]){ return 22.0;}
    else if ([string isEqualToString:@"22:30"]){ return 22.5;}
    else if ([string isEqualToString:@"23:00"]){ return 23.0;}
    else if ([string isEqualToString:@"23:30"]){ return 23.5;}
    
    return 0;
}

+(NSString*)timeStringFromNumber:(double)number
{
    if (number == 0){return @"00:00";}
    else if (number == 0.5){return @"00:30";}
    else if (number == 1){return @"01:00";}
    else if (number == 1.5){return @"01:30";}
    else if (number == 2){return @"02:00";}
    else if (number == 2.5){return @"02:30";}
    else if (number == 3){ return @"03:00";}
    else if (number == 3.5){ return @"03:30";}
    else if (number == 4){ return @"04:00";}
    else if (number == 4.5){ return @"04:30";}
    else if (number == 5){ return @"05:00";}
    else if (number == 5.5){ return @"05:30";}
    else if (number == 6){ return @"06:00";}
    else if (number == 6.5){ return @"06:30";}
    else if (number == 7){ return @"07:00";}
    else if (number == 7.5){ return @"07:30";}
    else if (number == 8){ return @"08:00";}
    else if (number == 8.5){ return @"08:30";}
    else if (number == 9){ return @"09:00";}
    else if (number == 9.5){ return @"09:30";}
    else if (number == 10){ return @"10:00";}
    else if (number == 10.5){ return @"10:30";}
    else if (number == 11){ return @"11:00";}
    else if (number == 11.5){ return @"11:30";}
    else if (number == 12){ return @"12:00";}
    else if (number == 12.5){ return @"12:30";}
    else if (number == 13){ return @"13:00";}
    else if (number == 13.5){ return @"13:30";}
    else if (number == 14){ return @"14:00";}
    else if (number == 14.5){ return @"14:30";}
    else if (number == 15){ return @"15:00";}
    else if (number == 15.5){ return @"15:30";}
    else if (number == 16){ return @"16:00";}
    else if (number == 16.5){ return @"16:30";}
    else if (number == 17){ return @"17:00";}
    else if (number == 17.5){ return @"17:30";}
    else if (number == 18){ return @"18:00";}
    else if (number == 18.5){ return @"18:30";}
    else if (number == 19){ return @"19:00";}
    else if (number == 19.5){ return @"19:30";}
    else if (number == 20){ return @"20:00";}
    else if (number == 20.5){ return @"20:30";}
    else if (number == 21){ return @"21:00";}
    else if (number == 21.5){ return @"21:30";}
    else if (number == 22){ return @"22:00";}
    else if (number == 22.5){ return @"22:30";}
    else if (number == 23){ return @"23:00";}
    else if (number == 23.5){ return @"23:30";}
    
    return @"00:00";
}

+(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    return [formater stringFromDate:date];
}

+(NSDate*)dateFromString:(NSString*)string
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    return [formater dateFromString:string];
}
#pragma mark - Popup
+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (code) {
            case RESPONSE_CODE_INVALID:
            case RESPONSE_CODE_INVALID_PASSWORD:
            case RESPONSE_CODE_API_NOT_FOUND:
            case RESPONSE_CODE_SERVER_ERROR:
            case RESPONSE_CODE_OTHER:
            {
                NSString *title = @"Thông báo";
                NSString *message = @"Đã xảy ra lỗi không xác định, vui lòng thử lại yêu cầu.";
                
                UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                [alertcontrol addAction:okbutton];
                
                [sender presentViewController:alertcontrol animated:YES completion:nil];
            }
                break;
            case RESPONSE_CODE_NOINTERNET:
            {
                NSString *title = @"Thông báo";
                NSString *message = @"Không có kết nối mạng, vui lòng kiểm tra lại.";
                
                UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                [alertcontrol addAction:okbutton];
                
                [sender presentViewController:alertcontrol animated:YES completion:nil];
            }
                break;
            case RESPONSE_CODE_TIMEOUT:
            {
                NSString *title = @"Thông báo";
                NSString *message = @"Kết nối mạng không ổn định, vui lòng kiểm tra lại.";
                
                UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                [alertcontrol addAction:okbutton];
                
                [sender presentViewController:alertcontrol animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    });
}

+(void)showPopup:(UIViewController*)sender responsecode:(RESPONSE_CODE)code completionHandler:(void(^)(POPUP_ACTION action))completionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (code) {
            case RESPONSE_CODE_INVALID:
            case RESPONSE_CODE_INVALID_PASSWORD:
            case RESPONSE_CODE_API_NOT_FOUND:
            case RESPONSE_CODE_SERVER_ERROR:
            case RESPONSE_CODE_OTHER:
            case RESPONSE_CODE_NOINTERNET:
            case RESPONSE_CODE_TIMEOUT:
                [JUntil showPopup:sender responsecode:code];
                break;
            case RESPONSE_CODE_NOT_LOGEDIN:
            {
                UIAlertController *alertcontroll = [UIAlertController alertControllerWithTitle:@"You're not loged in"
                                                                                       message:@"Please login first and then try make order again!"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okbutton = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    completionHandler(ACTION_OK);
                }];
                
                UIAlertAction *cancelbutton = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    completionHandler(ACTION_CANCEL);
                }];
                
                [alertcontroll addAction:okbutton];
                [alertcontroll addAction:cancelbutton];
                
                [sender presentViewController:alertcontroll animated:YES completion:nil];
            }
                break;
            case RESPONSE_CODE_PLACE_ORDER_SUCCESS:
            {
                UIAlertController *alertcontroll = [UIAlertController alertControllerWithTitle:@"Place order sucessfull"
                                                                                       message:@"Have a nice day!"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Xác Nhận"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * _Nonnull action){
                    completionHandler(ACTION_OK);
                }];
                
                [alertcontroll addAction:confirmAction];
                [sender presentViewController:alertcontroll animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    });
}

#pragma mark - Internet
+ (INTERNET_STATUS)internetConnectionStatus
{
    struct sockaddr_in zeroAddress;
    memset(&zeroAddress, 0, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if (reachabilityRef != NULL) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // If target host is not reachable
                return OFFLINE;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // If target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return ONLINE;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs.
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return ONLINE;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return ONLINE;
            }
        }
    }
    
    return OFFLINE;
}

+ (void)monitorNetworkReachabilityChanges
{
    NSString* hostNameStr = @"google.com";
    SCNetworkReachabilityContext reachabilityContext = {0, nil, nil, nil, nil};
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName( kCFAllocatorDefault, hostNameStr.UTF8String);
    
    if (SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback, &reachabilityContext))
    {
        SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    }
}
static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_REACHABILITY_STATUS_CHANGED_NOTIFICATION object:nil userInfo:nil];
}
@end
