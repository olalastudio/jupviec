//
//  AppDelegate.h
//  JupViec
//
//  Created by KienVu on 11/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;

@end

