//
//  LoginButton.h
//  testimageview
//
//  Created by Olala on 12/30/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    STATUS_LOGEDIN,
    STATUS_NONE,
} LOGINSTATUS;

NS_ASSUME_NONNULL_BEGIN

@interface LoginButton : UIButton
{
    LOGINSTATUS     _loginstatus;
}

-(void)setLoginStatus:(LOGINSTATUS)status;
-(LOGINSTATUS)loginStatus;

@end

NS_ASSUME_NONNULL_END
