//
//  HomeViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HomePromotionHeaderViewCell.h"
#import "HomePromotionCollectionViewCell.h"
#import "User.h"
#import "JUntil.h"

@class LoginButton;

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : JViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UITabBarControllerDelegate, HomePromotionHeaderDelegate>
{
    NSMutableDictionary     *_serviceInfo;
    NSArray                 *_serviceTypesArr;
}

@property (weak, nonatomic) IBOutlet UITableView    *tbSelectionTask;
@property (weak, nonatomic) IBOutlet LoginButton    *loginBtn;
@property (nonatomic, strong) User                  *user;
@property (nonatomic, weak) NSString                *strUserToken;
@property (nonatomic, strong) NSDictionary          *configurationInfoDict;
@property (nonatomic, strong) NSString              *strPhoneNum;

-(void)logIn:(NSString*)strToken phoneNumber:(NSString*)phonenumber;
-(void)logOut;

// Order result
-(void)didCompleteOrder:(NSDictionary*)orderInfo;
@end

NS_ASSUME_NONNULL_END
