//
//  AccountInfoViewController.m
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "EditAccountInfoViewController.h"
#import "HomeViewController.h"
#import "CommonDefines.h"

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_user) {
        _generalInfo = [_user dictUserInfo];
        if ([[_generalInfo objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            _usernameLb.text = [_generalInfo objectForKey:@"name"];
        }
        if ([[_generalInfo objectForKey:@"email"] isKindOfClass:[NSString class]]) {
            _emailLb.text = [_generalInfo objectForKey:@"email"];
        }
        _phoneNumLb.text = [_user userPhoneNum];
    }
    
    [_addressLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_phoneNumLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_emailLb setTextColor:UIColorFromRGB(0xACB3BF)];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    self.view.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_user) {
        _generalInfo = [_user dictUserInfo];
        if ([[_generalInfo objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            _usernameLb.text = [_generalInfo objectForKey:@"name"];
        }
        if ([[_generalInfo objectForKey:@"email"] isKindOfClass:[NSString class]]) {
            _emailLb.text = [_generalInfo objectForKey:@"email"];
        }
        _phoneNumLb.text = [_user userPhoneNum];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"idshoweditaccountinfo"])
    {
        EditAccountInfoViewController* editAccountInfoVC = segue.destinationViewController;
        editAccountInfoVC.user = _user;
        editAccountInfoVC.tokenStr = _tokenStr;
    }
}

- (IBAction)didPressLogoutButton:(id)sender
{
    HomeViewController *homeview;
    
    for (UIViewController *item in [self.navigationController viewControllers])
    {
        if ([item isKindOfClass:[HomeViewController class]])
        {
            homeview = (HomeViewController*)item;
            
            [homeview logOut];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
