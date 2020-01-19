//
//  AccountInfoViewController.h
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoViewController : JViewController <UITabBarControllerDelegate>
{
    NSDictionary* _generalInfo;
}

@property (weak, nonatomic) IBOutlet UILabel    *addressLbTitle;
@property (weak, nonatomic) IBOutlet UILabel    *addressLb;
@property (weak, nonatomic) IBOutlet UILabel    *usernameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbTitle;
@property (weak, nonatomic) IBOutlet UILabel    *phoneNumLb;
@property (weak, nonatomic) IBOutlet UILabel *emailLbTitle;
@property (weak, nonatomic) IBOutlet UILabel    *emailLb;
@property (weak, nonatomic) IBOutlet UIButton   *logoutBtn;

@property (strong, nonatomic) User              *user;
@property (strong, nonatomic) NSString          *tokenStr;

- (IBAction)didPressLogoutButton:(id)sender;

-(void)updateContentView;
@end

NS_ASSUME_NONNULL_END
