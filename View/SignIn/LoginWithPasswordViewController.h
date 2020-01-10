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

@class JButton;

NS_ASSUME_NONNULL_BEGIN

@interface LoginWithPasswordViewController : JViewController <UITextFieldDelegate>
{
    NSString* strUserphone;
    NSString* strUserPass;
    NSInteger intActionMode;
    NSString* strToken;
}

@property (weak, nonatomic) IBOutlet UITextField    *txtInputUserPhone;
@property (weak, nonatomic) IBOutlet UITextField    *txtInputUserPass;
@property (weak, nonatomic) IBOutlet UIButton       *btForgotPassword;
@property (weak, nonatomic) IBOutlet JButton        *btConfirm;
@property (weak, nonatomic) IBOutlet UIButton       *btRegisterNow;
@property (weak, nonatomic) IBOutlet UILabel        *txtQuestion;

- (IBAction)didClickedFogetPassword:(id)sender;
- (IBAction)didClickedRegisterNewAcc:(id)sender;
- (IBAction)didClickedLogin:(id)sender;

@end

NS_ASSUME_NONNULL_END
