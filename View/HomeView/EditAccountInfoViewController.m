//
//  EditAccountInfoViewController.m
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "EditAccountInfoViewController.h"
#import "APIRequest.h"
#import "AccountInfoViewController.h"
#import "HomeViewController.h"

@interface EditAccountInfoViewController ()

@end

@implementation EditAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_userNameTF setDelegate:self];
    _isChangeInfo = NO;
    _accountGeneralInfo = [[_user dictUserInfo]mutableCopy];
    if (_accountGeneralInfo) {
        if ([[_accountGeneralInfo objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            _userNameTF.text = [_accountGeneralInfo objectForKey:@"name"];
        }
        if ([[_accountGeneralInfo objectForKey:@"email"] isKindOfClass:[NSString class]]) {
            _emailTF.text = [_accountGeneralInfo objectForKey:@"email"];
        }
        if ([[_accountGeneralInfo objectForKey:@"age"] isKindOfClass:[NSNumber class]]) {
            _ageTF.text = [[_accountGeneralInfo objectForKey:@"age"]stringValue];
        }
        if ([[_accountGeneralInfo objectForKey:@"address"] isKindOfClass:[NSString class]]) {
            _addressTF.text = [_accountGeneralInfo objectForKey:@"address"];
        }
        if ([[_accountGeneralInfo objectForKey:@"identity_card"] isKindOfClass:[NSNumber class]]) {
            _identifyCardTF.text = [[_accountGeneralInfo objectForKey:@"identity_card"]stringValue];
        }
    }
    [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_emailTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_ageTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_addressTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_identifyCardTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField*)textField
{
    if (!_isChangeInfo) {
        _isChangeInfo = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)changeEdittedAccountInfo:(id)sender {
    
    if (_isChangeInfo && _user && [_user userToken])
    {
        [_accountGeneralInfo setObject:_userNameTF.text forKey:@"name"];
        [_accountGeneralInfo setObject:_emailTF.text forKey:@"email"];
        [_accountGeneralInfo setObject:[NSNumber numberWithInteger:[_ageTF.text integerValue]] forKey:@"age"];
        [_accountGeneralInfo setObject:_addressTF.text forKey:@"address"];
        [_accountGeneralInfo setObject:[NSNumber numberWithInteger:[_identifyCardTF.text integerValue]] forKey:@"identity_card"];
        
        APIRequest* api = [[APIRequest alloc]init];
        
        [api requestAPIUpdateAccountInfo:[_user userToken] accountInfo:_accountGeneralInfo completionHandler:^(User * _Nullable user, NSError * _Nonnull error)
        {
            if (error.code == 200)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self didSuccessChangeAccountInfo:user];
                });
            }
            else if (error.code == RESPONSE_CODE_NODATA)
            {
                [JUntil showPopup:self responsecode:RESPONSE_CODE_NODATA];
            }
            else if (error.code == RESPONSE_CODE_TIMEOUT)
            {
                [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
            }
            else
            {
                [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
            }
        }];
    }
}

- (void)didSuccessChangeAccountInfo:(User*)user
{
    NSArray* viewControllersArr = [self.navigationController viewControllers];
    
    for (UIViewController* vc in viewControllersArr) {
        if ([vc isKindOfClass:[AccountInfoViewController class]])
        {
            AccountInfoViewController* accountInfoVC = (AccountInfoViewController*)vc;
            accountInfoVC.user = user;
        }
        else if ([vc isKindOfClass:[HomeViewController class]])
        {
            HomeViewController* homeview = (HomeViewController*)vc;
            [homeview setUser:user];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
