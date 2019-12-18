//
//  AppDelegate.m
//  JupViec
//
//  Created by KienVu on 11/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import "NetworkReachability.h"

@interface AppDelegate ()
{
    CLLocationManager *locationmanager;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    [[FIRMessaging messaging] setDelegate:self];
    
    UNAuthorizationOptions option = UNAuthorizationOptionAlert;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"allow app send notification on this device");
    }];
    
    [application registerForRemoteNotifications];
    [FIRApp configure];
    
    [GMSPlacesClient provideAPIKey:@"AIzaSyB1Qo46kfokUCUb9pTGUb0QV5aoKmPV6qE"];
    [GMSServices provideAPIKey:@"AIzaSyB1Qo46kfokUCUb9pTGUb0QV5aoKmPV6qE"];

    if (NetworkReachability.internetConnectionStatus != ONLINE)
    {
        [self showAlertForInternetConnection];
    }

    return YES;
}

- (void)showAlertForInternetConnection
{
//    UIWindow* topWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    topWindow.rootViewController = [UIViewController new];
//    topWindow.windowLevel = UIWindowLevelAlert + 1;
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Khong co ket noi mang. Kiem tra lai ket noi mang" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    UIViewController* topVC = self.window.rootViewController;
    dispatch_async(dispatch_get_main_queue(), ^{
        [topVC presentViewController:alertController animated:YES completion:nil];
    });
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    //access location
    [self requestLocationPermission];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - LocationDelegate
-(void)requestLocationPermission
{
    if ([CLLocationManager locationServicesEnabled])
    {
        locationmanager = [[CLLocationManager alloc] init];
        locationmanager.delegate = self;
        
        [locationmanager requestAlwaysAuthorization];
    }
    else
    {
        NSLog(@"Location service was disable. Plz anable first");
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"did change status %d",status);
    
    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Location permission denied");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"Location permission allowed");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Location permission is not determine");
            break;
        default:
            break;
    }
}

#pragma mark - Firebase Messegging
-(void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
    NSLog(@"%@",remoteMessage.appData);
}

-(void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    NSLog(@"%@",fcmToken);
}
@end
