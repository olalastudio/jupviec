//
//  SignInViewController.h
//  JupViec
//
//  Created by KienVu on 11/26/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"
#import "APIRequest.h"

@class JButton;

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : JViewController <UITextFieldDelegate>
{
    NSString* strOTPServer;
    NSString* strPhoneNumber;
    NSString* strToken;
}

@property (nonatomic, assign) NSInteger intActionMode;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UILabel *txtPhoneTitle;
@property (weak, nonatomic) IBOutlet JButton *btNext;

- (IBAction)didPressNextButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
