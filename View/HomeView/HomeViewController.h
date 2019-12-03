//
//  HomeViewController.h
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
{
    User* user;
}

- (IBAction)didClickLoginButton:(id)sender;

@end

NS_ASSUME_NONNULL_END