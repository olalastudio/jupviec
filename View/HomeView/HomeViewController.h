//
//  HomeViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    NSMutableDictionary     *_serviceInfo;
    NSArray                 *_serviceTypesArr;
}

@property (weak, nonatomic) IBOutlet UITableView    *tbSelectionTask;
@property (weak, nonatomic) IBOutlet UIButton       *loginBtn;
@property (nonatomic, strong) User                  *user;
@property (nonatomic, weak) NSString                *strUserToken;
@property (nonatomic, strong) NSDictionary          *configurationInfoDict;
@property (nonatomic, strong) NSString              *strPhoneNum;

- (IBAction)didClickLoginButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
