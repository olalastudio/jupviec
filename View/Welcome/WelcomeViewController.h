//
//  WelcomeViewController.h
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface WelcomeViewController : UIViewController

@property (assign, nonatomic) NSInteger      index;

@property (weak, nonatomic) IBOutlet UILabel *txtWelcome;

@end

NS_ASSUME_NONNULL_END
