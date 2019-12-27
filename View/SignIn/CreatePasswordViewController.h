//
//  CreatePasswordViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"
#import "User.h"
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreatePasswordViewController : JViewController <UITextFieldDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITextField    *txtInputPassword;
@property (weak, nonatomic) IBOutlet UITextField    *txtReInputPassword;
@property (weak, nonatomic) IBOutlet UIButton       *btnRegister;

@property (nonatomic, strong) User          *user;
@property (nonatomic, strong) NSString      *strPhoneNum;
@property (nonatomic, strong) NSString      *strToken;
@property (nonatomic, assign) NSInteger     intActionMode;

- (IBAction)didClickRegisterBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END
