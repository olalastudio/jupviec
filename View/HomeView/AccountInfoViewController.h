//
//  AccountInfoViewController.h
//  JupViec
//
//  Created by Khanhlt on 12/16/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoViewController : UIViewController
{
    NSDictionary* _generalInfo;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel    *usernameLb;
@property (weak, nonatomic) IBOutlet UILabel    *phoneNumLb;
@property (weak, nonatomic) IBOutlet UILabel    *emailLb;
@property (strong, nonatomic) User              *user;
@property (strong, nonatomic) NSString          *tokenStr;

- (IBAction)didPressLogoutButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
