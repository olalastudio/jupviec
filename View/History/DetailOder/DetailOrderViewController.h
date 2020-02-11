//
//  DetailOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"

#import "RateViewController.h"
#import "User.h"

@class JLabel;

NS_ASSUME_NONNULL_BEGIN

@protocol DetailOrderViewDelegate <NSObject>

-(void)didStopOder:(NSDictionary*)resultDic;
-(void)didRateOder:(NSDictionary*)resultDic;

@end

@interface DetailOrderViewController : JViewController <RateViewDelegate>
{
    NSDictionary            *_definesCode;
}

@property id<DetailOrderViewDelegate>           delegate;

@property (strong, nonatomic)   User                *user;
@property (strong, nonatomic)   NSDictionary        *detailInfo;

@property (weak, nonatomic) IBOutlet UIButton       *btRate;

@property (weak, nonatomic) IBOutlet JLabel         *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel        *lbServiceTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbServiceValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbAddressTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbAddressValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbPhoneTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbPhoneValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbOrderDateTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbOrderDateValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbWorkTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbWorkTimeValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbWorkHourTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbWorkHourValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbOptionTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbOptionValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbPaymentTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbPaymentValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbNoteTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbNoteValue;
@property (weak, nonatomic) IBOutlet UILabel        *lbTotalPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel        *lbTotalPriceValue;
@property (weak, nonatomic) IBOutlet UIButton       *btStopService;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusWidthConstrains;

-(IBAction)didPressRateButton:(id)sender;
- (IBAction)didPressStopServiceButton:(id)sender;

-(void)setDefineCodeGetFromServer:(NSDictionary*)codes;

@end

NS_ASSUME_NONNULL_END
