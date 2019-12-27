//
//  ConfirmOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "Order.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderViewController : JViewController
{
    Order       *_order;
    User        *_user;
}
@property Order     *order;
@property User      *user;

@property (weak, nonatomic) IBOutlet UITextView *txtContent;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoneyValue;
@property (weak, nonatomic) IBOutlet UIButton *btConfirm;

- (IBAction)didPressConfirmOrderButton:(id)sender;


@end

NS_ASSUME_NONNULL_END
