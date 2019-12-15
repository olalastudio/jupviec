//
//  SignInViewController.m
//  JupViec
//
//  Created by KienVu on 11/26/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "SignInViewController.h"
#import "OTPCheckViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtPhone setDelegate:self];
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

//TextField delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)didSuccessGetRequest:(NSString*)strOTP error:(NSInteger)errCode
{
    strOTPServer = strOTP;
    if (errCode == 200)
    {
        NSLog(@"sdt chua dang ky, tiep tuc dang ky");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"idcheckotp" sender:self];
        });
    }
    else if (errCode == 400 && _intActionMode == MODE_REGISTER_NEW_ACC)
    {
        //show alert
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Số điện thoại đã được đăng ký. Bạn có muốn đăng nhập không." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* reTypePhoneNumAction = [UIAlertAction actionWithTitle:@"Nhập Lại" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Nhap lai so dien thoai");
        }];
        UIAlertAction* registerAction = [UIAlertAction actionWithTitle:@"Dang nhap" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"sdt da ton tai move to login view");
            // move to login view
            [self performSegueWithIdentifier:@"idLogin" sender:self];
        }];
        
        [alertControler addAction:reTypePhoneNumAction];
        [alertControler addAction:registerAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertControler animated:YES completion:nil];
        });
    }
    else if (errCode == 400 && _intActionMode == MODE_FORGOT_PASSWORD)
    {
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Account is not existed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Account is not existed");
        }];
        [alertControler addAction:alertAct];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertControler animated:YES completion:nil];
        });
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"idcheckotp"])
    {
        OTPCheckViewController* otpCheckVC = segue.destinationViewController;
        otpCheckVC.strOTPServer = strOTPServer;
        otpCheckVC.strPhoneNum = strPhoneNumber;
        otpCheckVC.intActionMode = _intActionMode;
        if (_intActionMode == MODE_FORGOT_PASSWORD && strToken)
        {
            otpCheckVC.strToken = strToken;
        }
    }
}

- (IBAction)didPressNextButton:(id)sender {
    if ([_txtPhone text])
    {
        strPhoneNumber = [_txtPhone text];
        APIRequest* apiRequest = [[APIRequest alloc]init];
        
        if (_intActionMode == MODE_REGISTER_NEW_ACC)
        {
            [apiRequest requestAPIGetOTP:strPhoneNumber completionHandler:^(NSString * _Nullable otpStr, NSError * _Nonnull err) {
                NSLog(@"otp: %@", otpStr);
                [self didSuccessGetRequest:otpStr error:err.code];
            }];
        } else if (_intActionMode == MODE_FORGOT_PASSWORD)
        {
            [apiRequest requestAPIForgotPassword:strPhoneNumber completionHandler:^(NSDictionary * _Nullable data, NSError * _Nonnull err) {
                if (err.code == 200)
                {
                    NSString* otp = [data objectForKey:@"otp"];
                    NSString* token = [data objectForKey:@"token"];
                    self->strToken = token;
                    [self didSuccessGetRequest:otp error:err.code];
                } else
                    [self didSuccessGetRequest:nil error:err.code];
            }];
        }
    }
}
@end
