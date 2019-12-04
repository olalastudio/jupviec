//
//  CreatePasswordViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreatePasswordViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtInputPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtReInputPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (nonatomic, assign) NSString* strPhoneNum;
@property (nonatomic, assign) NSString* strToken;
@property (nonatomic, assign) NSInteger intActionMode;

- (IBAction)didClickRegisterBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END
