//
//  LoginWithPasswordViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"
#import "JUntil.h"

#import "JAlertPopupController.h"

@class JButton;
@class JTextField;
@class JTextField;

NS_ASSUME_NONNULL_BEGIN

@interface LoginWithPasswordViewController : JViewController <UITextFieldDelegate, JAlertPopupDelegate>
{
    NSString* strUserphone;
    NSString* strUserPass;
    NSInteger intActionMode;
    NSString* strToken;
}

@property (weak, nonatomic) IBOutlet JTextField    *txtInputUserPhone;
@property (weak, nonatomic) IBOutlet JTextField    *txtInputUserPass;
@property (weak, nonatomic) IBOutlet UIButton       *btForgotPassword;
@property (weak, nonatomic) IBOutlet JButton        *btConfirm;
@property (weak, nonatomic) IBOutlet UIButton       *btRegisterNow;
@property (weak, nonatomic) IBOutlet UILabel        *txtQuestion;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)didClickedFogetPassword:(id)sender;
- (IBAction)didClickedRegisterNewAcc:(id)sender;
- (IBAction)didClickedLogin:(id)sender;

@end

NS_ASSUME_NONNULL_END
