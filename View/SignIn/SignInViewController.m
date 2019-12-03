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

-(void)didSuccessGetOTP:(NSString*)strOTP error:(NSInteger)errCode
{
    strOTPServer = strOTP;
    if (errCode == 400)
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
    } else if (errCode == 200)
    {
        NSLog(@"sdt chua dang ky, tiep tuc dang ky");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"idcheckotp" sender:self];
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
    }
}

- (IBAction)didPressNextButton:(id)sender {
    if ([_txtPhone text])
    {
        strPhoneNumber = [_txtPhone text];
        APIRequest* apiRequest = [[APIRequest alloc]init];
        [apiRequest requestAPIGetOTP:strPhoneNumber completionHandler:^(NSString * _Nonnull otpStr, NSError * _Nonnull err) {
            NSLog(@"otp: %@", otpStr);
            [self didSuccessGetOTP:otpStr error:err.code];
            //handle
        }];
    }
}
@end
