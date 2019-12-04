//
//  OTPCheckViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTPCheckViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtOTPInput;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (nonatomic, assign) NSString* strOTPServer;
@property (nonatomic, assign) NSString* strPhoneNum;
@property (nonatomic, assign) NSString* strToken;
@property (nonatomic, assign) NSInteger intActionMode;

- (IBAction)didClickCheckOTPNumber:(id)sender;

@end

NS_ASSUME_NONNULL_END
