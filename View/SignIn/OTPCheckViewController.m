//
//  OTPCheckViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "OTPCheckViewController.h"
#import "CreatePasswordViewController.h"
#import "JButton.h"

@interface OTPCheckViewController ()
{
    NSInteger keyboardheight;
}

@end

@implementation OTPCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.layer.masksToBounds = YES;
    
    [_txtOTPInput setDelegate:self];
    
    //test
    if (_strOTPServer) {
        [_txtOTPInput setText:_strOTPServer];
    }
    
    [_txtOTPInput setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_txtOTPInputTitle setTextColor:UIColorFromRGB(0x5C5C5C)];
    
    keyboardheight = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
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
    [self.view endEditing:YES];
    
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
