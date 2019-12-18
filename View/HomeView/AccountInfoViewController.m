//
//  AccountInfoViewController.m
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "EditAccountInfoViewController.h"

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

@end
