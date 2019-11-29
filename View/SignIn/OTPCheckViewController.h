//
//  OTPCheckViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPCheckViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtOTPInput;
@property (weak, nonatomic) IBOutlet UILabel *lbFailCheckOTP;
@property (weak, nonatomic) IBOutlet UIButton *btnReGetOTP;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@end

NS_ASSUME_NONNULL_END
