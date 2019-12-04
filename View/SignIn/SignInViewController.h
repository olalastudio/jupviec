//
//  SignInViewController.h
//  JupViec
//
//  Created by KienVu on 11/26/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "APIRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : UIViewController <UITextFieldDelegate>
{
    NSString* strOTPServer;
    NSString* strPhoneNumber;
    NSString* strToken;
}

@property (nonatomic, assign) NSInteger intActionMode;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

- (IBAction)didPressNextButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
