//
//  AccountInfoViewController.m
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "EditAccountInfoViewController.h"
#import "LoginWithPasswordViewController.h"
#import "HomeViewController.h"
#import "CommonDefines.h"

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_addressLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_phoneNumLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_emailLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_sexLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_levelTitleLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_levelLb setTextColor:UIColorFromRGB(0xACB3BF)];
    [_usernameLb setTextColor:[UIColor blackColor]];
    [_addressLbTitle setTextColor:[UIColor blackColor]];
    [_phoneNumLbTitle setTextColor:[UIColor blackColor]];
    [_emailLbTitle setTextColor:[UIColor blackColor]];
    [_sexTitleLb setTextColor:[UIColor blackColor]];
    [_levelTitleLb setTextColor:[UIColor blackColor]];
    [_logoutBtn setTitleColor:UIColorFromRGB(0xFF5B14) forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Comfortaa-Regular" size:20]}];
    
    self.view.layer.masksToBounds = YES;
    [self.tabBarController setDelegate:self];
    if (!_loadingView) {
        _loadingView = [self.storyboard instantiateViewControllerWithIdentifier:@"idloadingview"];
        [_loadingView show:self];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSArray* viewControllerArr = [self.tabBarController viewControllers];
    for (UINavigationController* item in viewControllerArr)
    {
        UIViewController *itemVC = [(UINavigationController*)item visibleViewController];
        if ([itemVC isKindOfClass:[HomeViewController class]])
        {
            HomeViewController *homeVC = (HomeViewController*)itemVC;
            [homeVC setUser:_user];
            break;
        }
    }

    return YES;
}

-(void)updateContentView
{
    if (_user) {
        _generalInfo = [_user dictUserInfo];
        if ([[_generalInfo objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            _usernameLb.text = [_generalInfo objectForKey:@"name"];
        }
        else{
            _usernameLb.text = [_user userPhoneNum];
        }
        
        if ([[_generalInfo objectForKey:@"address"] isKindOfClass:[NSString class]]) {
            _addressLb.text = [_generalInfo objectForKey:@"address"];
        }
        else{
            _addressLb.text = @"Không có sẵn";
        }
        
        if ([[_generalInfo objectForKey:@"email"] isKindOfClass:[NSString class]]) {
            _emailLb.text = [_generalInfo objectForKey:@"email"];
        }
        else{
            _emailLb.text = @"Không có sẵn";
        }
        
        if ([[_generalInfo objectForKey:@"sex"] isKindOfClass:[NSNumber class]]) {
            if ([[_generalInfo objectForKey:@"sex"] boolValue] == YES) {
                _sexLb.text = @"nam";
            }else
                _sexLb.text = @"nữ";
        }else{
            _sexLb.text = @"Không có sẵn";
        }
        
        if ([_user userTier]) {
            _levelLb.text = [_user userTier];
        }else{
            _levelLb.text = @"Không có sẵn";
        }
        
        _phoneNumLb.text = [_user userPhoneNum];
        
        if (_loadingView) {
            [_loadingView dismiss];
        }
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
    
    for (UINavigationController *item in [self.tabBarController viewControllers])
    {
        UIViewController *viewcontroll = [item visibleViewController];
        
        if ([viewcontroll isKindOfClass:[HomeViewController class]])
        {
            homeview = (HomeViewController*)viewcontroll;
            
            [homeview logOut];
            break;
        }
    }
    
    LoginWithPasswordViewController *loginview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloginview"];
    [self.navigationController setViewControllers:@[loginview] animated:YES];
    
    _user = nil;
    _tokenStr = @"";
}
@end
