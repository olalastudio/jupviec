//
//  OTPCheckViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"

@class JButton;

NS_ASSUME_NONNULL_BEGIN

@interface OTPCheckViewController : JViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *txtOTPInputTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtOTPInput;
@property (weak, nonatomic) IBOutlet JButton *btnContinue;
@property (nonatomic, assign) NSString* strOTPServer;
@property (nonatomic, assign) NSString* strPhoneNum;
@property (nonatomic, assign) NSString* strToken;
@property (nonatomic, assign) NSInteger intActionMode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)didClickCheckOTPNumber:(id)sender;

@end

NS_ASSUME_NONNULL_END
