//
//  CreatePasswordViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "CreatePasswordViewController.h"
#import "APIRequest.h"

@interface CreatePasswordViewController ()

@end

@implementation CreatePasswordViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtInputPassword setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//UITextFieldDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"idUserHomeVC"])
    {
        HomeViewController* homeVC = [segue destinationViewController];
        homeVC.user = _user;
        homeVC.strUserToken = _strToken;
    }
}

- (void)requestLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
            APIRequest* apiRequest = [[APIRequest alloc]init];
            NSString *password = [self.txtInputPassword text];
            
            [apiRequest requestAPILogin:self.strPhoneNum password:password completionHandler:^(NSString * _Nullable token, NSError * _Nonnull error)
            {
                if (error.code == 200)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setStrToken:token];
                        [self.user setUserToken:token];
                        
                        for (UIViewController *vc in [self.navigationController viewControllers]) {
                            
                            if ([vc isKindOfClass:[HomeViewController class]]) {
                                [(HomeViewController*)vc setUser:self.user];
                                break;
                            }
                        }
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }
            }];
     });
}

- (IBAction)didClickRegisterBtn:(id)sender {
    if ([[_txtInputPassword text] isEqualToString:[_txtReInputPassword text]])
    {
        APIRequest* apiRequest = [[APIRequest alloc]init];
        if (_intActionMode == MODE_FORGOT_PASSWORD)
        {
            [apiRequest requestAPIUpdatePassword:_strPhoneNum password:[_txtInputPassword text] token:_strToken completionHandler:^(User * _Nullable user, NSError * _Nonnull error) {
                if (error.code == 200)
                {
                    NSLog(@"change password success");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"idUserHomeVC" sender:self];
                    });
                }
            }];
        }
        else if (_intActionMode == MODE_REGISTER_NEW_ACC)
        {
            [apiRequest requestAPIRegister:_strPhoneNum password:[_txtInputPassword text] completionHandler:^(User * _Nonnull user, NSError * _Nullable err) {
                if (err.code == 200)
                {
                    NSLog(@"Register success");
                    self.user = user;
                    //login to get token
                    [self requestLogin];
                }
            }];
        }
    }else{
        NSLog(@"password is not match");
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Nhập lại mật khẩu cần trùng khớp" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_txtReInputPassword setText:@""];
        }];
        [alertController addAction:alertAct];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}
@end
