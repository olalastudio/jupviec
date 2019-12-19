//
//  DetailOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailOrderViewController : UIViewController
{
    
}

@property (strong, nonatomic)   User            *user;
@property (strong, nonatomic)   NSDictionary    *DetailInfo;

@end

NS_ASSUME_NONNULL_END
