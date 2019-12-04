//
//  OTPCheckViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "OTPCheckViewController.h"
#import "CreatePasswordViewController.h"

@interface OTPCheckViewController ()

@end

@implementation OTPCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtOTPInput setDelegate:self];
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

// UITextFieldDelegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"idcreatepassword"])
    {
        CreatePasswordViewController* createPassVC = segue.destinationViewController;
        createPassVC.strPhoneNum = _strPhoneNum;
        createPassVC.intActionMode = _intActionMode;
        if (_intActionMode == MODE_FORGOT_PASSWORD && _strToken)
        {
            createPassVC.strToken = _strToken;
        }
    }
}

- (IBAction)didClickCheckOTPNumber:(id)sender
{
    if (_strOTPServer && [_strOTPServer isEqualToString:[_txtOTPInput text]])
    {
        NSLog(@"otp correct");
        [self performSegueWithIdentifier:@"idcreatepassword" sender:self];
    }
    else
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Mã OTP chưa chính xác vui lòng nhập lại" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"otp incorrect, re-input");
            [self->_txtOTPInput setText:@""];
        }];
        [alertController addAction:okAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
        
}
@end
