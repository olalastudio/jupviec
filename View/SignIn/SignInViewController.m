//
//  SignInViewController.m
//  JupViec
//
//  Created by KienVu on 11/26/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "SignInViewController.h"
#import "OTPCheckViewController.h"
#import "JButton.h"
#import "JUntil.h"

@interface SignInViewController ()
{
    NSInteger keyboardheight;
}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.layer.masksToBounds = YES;
    
    [_txtPhone setDelegate:self];
    
    [_txtPhone setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_txtPhoneTitle setTextColor:UIColorFromRGB(0x5C5C5C)];
    
    keyboardheight = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
    [self registerFromKeyboardNotification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self unregisterFromKeyboardNotification];
}

-(void)registerFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unregisterFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
 
    keyboardheight = beginrect.origin.y - endrect.origin.y;
    
    _bottomConstraint.constant += keyboardheight;
    
    [self.view layoutIfNeeded];
}

-(void)keyboardDidHide:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
    
    keyboardheight = endrect.origin.y - beginrect.origin.y;
    
    if ((_bottomConstraint.constant - keyboardheight) > 0) {
        _bottomConstraint.constant -= keyboardheight;
    }
    
    [self.view layoutIfNeeded];
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
    else if (errCode == 204)
    {
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"Popup" message:@"param name invalid or not found" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertControler addAction:alertAct];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertControler animated:YES completion:nil];
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
    else if (errCode == 400 && _intActionMode == MODE_FORGOT_PASSWORD)  // account not existed
    {
        [JUntil showPopup:self responsecode:RESPONSE_CODE_ACCOUNT_NOT_EXIST];
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

- (IBAction)didPressNextButton:(id)sender
{
    [self.view endEditing:YES];
    
    if ([_txtPhone text])
    {
        strPhoneNumber = [_txtPhone text];
        APIRequest* apiRequest = [[APIRequest alloc]init];
        
        if (_intActionMode == MODE_REGISTER_NEW_ACC)
        {
            [apiRequest requestAPIGetOTP:strPhoneNumber completionHandler:^(NSString * _Nullable otpStr, NSError * _Nonnull err){
                NSLog(@"otp: %@", otpStr);
                [self didSuccessGetRequest:otpStr error:err.code];
            }];
        }
        else if (_intActionMode == MODE_FORGOT_PASSWORD)
        {
            [apiRequest requestAPIForgotPassword:strPhoneNumber completionHandler:^(NSDictionary * _Nullable data, NSError * _Nonnull err){
                if (err.code == 200)
                {
                    NSString* otp = [data objectForKey:@"otp"];
                    NSString* token = [data objectForKey:@"otp"];
                    self->strToken = token;
                    [self didSuccessGetRequest:otp error:err.code];
                } else
                    [self didSuccessGetRequest:nil error:err.code];
            }];
        }
    }
}
@end
