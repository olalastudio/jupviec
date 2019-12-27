//
//  RateViewController.h
//  JupViec
//
//  Created by KienVu on 12/19/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RateViewController : JViewController
{
    NSString    *_token;
    NSString    *_idservice;
    NSDictionary    *_serviceInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *lbRateScore;

@property (weak, nonatomic) IBOutlet UILabel *lbComment;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (weak, nonatomic) IBOutlet UIButton *btRate;

@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;

- (IBAction)didPressStar1:(id)sender;
- (IBAction)didPressStar2:(id)sender;
- (IBAction)didPressStar3:(id)sender;
- (IBAction)didPressStar4:(id)sender;
- (IBAction)didPressStar5:(id)sender;

- (IBAction)didPressRateButton:(id)sender;

-(void)setUserToken:(NSString*)token;
-(void)setServiceInfo:(NSDictionary*)serviceInfo;
-(void)setIDService:(NSString*)idservice;

@end

NS_ASSUME_NONNULL_END
