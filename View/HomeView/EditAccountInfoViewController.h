//
//  EditAccountInfoViewController.h
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditAccountInfoViewController : JViewController <UITextFieldDelegate>
{
    BOOL _isChangeInfo;
    NSMutableDictionary* _accountGeneralInfo;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *identifyCardTF;
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) NSString* tokenStr;
- (IBAction)changeEdittedAccountInfo:(id)sender;

@end

NS_ASSUME_NONNULL_END
