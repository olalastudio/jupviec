//
//  ConfirmOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "JAlertPopupController.h"
#import "Order.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderViewController : JViewController <JAlertPopupDelegate>
{
    Order       *_order;
    User        *_user;
}
@property Order     *order;
@property User      *user;

@property (weak, nonatomic) IBOutlet UILabel *txtType;
@property (weak, nonatomic) IBOutlet UILabel *txtAddressTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtAddressValue;
@property (weak, nonatomic) IBOutlet UILabel *txtPhoneNumberTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtPhoneNumberValue;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkDateTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkDateValue;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkHourTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkHourValue;
@property (weak, nonatomic) IBOutlet UILabel *txtExtendServiceTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtExtendServiceValue;
@property (weak, nonatomic) IBOutlet UILabel *txtPaymentMethodTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtPaymentMethodValue;
@property (weak, nonatomic) IBOutlet UILabel *txtNoteTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtNoteValue;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoneyTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoneyValue;
@property (weak, nonatomic) IBOutlet UIButton *btConfirm;

- (IBAction)didPressConfirmOrderButton:(id)sender;


@end

NS_ASSUME_NONNULL_END
