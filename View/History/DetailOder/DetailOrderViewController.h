//
//  DetailOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailOrderViewController : UIViewController
{
    
}

@property (strong, nonatomic)   User            *user;
@property (strong, nonatomic)   NSDictionary    *detailInfo;

@property (weak, nonatomic) IBOutlet UIBarButtonItem    *btRate;
@property (weak, nonatomic) IBOutlet UITextView         *txtContent;
@property (weak, nonatomic) IBOutlet UIButton           *btStopService;

-(IBAction)didPressRateButton:(id)sender;
- (IBAction)didPressStopServiceButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
