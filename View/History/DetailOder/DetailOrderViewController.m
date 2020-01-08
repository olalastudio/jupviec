//
//  DetailOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DetailOrderViewController.h"

#import "JUntil.h"
#import "JLabel.h"

#import "APIRequest.h"

@interface DetailOrderViewController ()

@end

@implementation DetailOrderViewController
@synthesize delegate = _delegate;
@synthesize user = _user;
@synthesize detailInfo = _detailInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [_lbServiceTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbAddressTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbPhoneTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbOrderDateTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbWorkTimeTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbWorkHourTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbOptionTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbPaymentTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbNoteTitle setTextColor:UIColorFromRGB(0x000000)];
    [_lbTotalPriceTitle setTextColor:UIColorFromRGB(0x000000)];
    
    [_lbServiceValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbAddressValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbPhoneValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbOrderDateValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbWorkTimeValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbWorkHourValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbOptionValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbPaymentValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbNoteValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_lbTotalPriceValue setTextColor:UIColorFromRGB(0xACB3BF)];
    
    [_btRate setTitleColor:UIColorFromRGB(0xFF5B14) forState:UIControlStateNormal];
    [_btStopService setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    
    self.view.layer.masksToBounds = YES;
}

-(void)loadView
{
    [super loadView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [self updateContentView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setUser:(User *)user
{
    _user = user;
}

-(User*)user
{
    return _user;
}

-(void)setDetailInfo:(NSDictionary *)detailInfo
{
    _detailInfo = detailInfo;
}

-(NSDictionary*)detailInfo
{
    return _detailInfo;
}

-(void)setDefineCodeGetFromServer:(NSMutableDictionary *)codes
{
    _definesCode = [[NSDictionary alloc] initWithDictionary:codes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateContentView
{
    NSString *status = [_detailInfo objectForKey:ID_REQUEST_STATUS];
    [_lbStatus setText:[JUntil stringDisplayWithID:status withCategory:ID_REQUEST_STATUS fromDefinesDictionary:_definesCode]];
    [_lbStatus setBackgroundColor:[JUntil colorDisplayForStatusID:status]];
    [_lbStatus setTextColor:UIColorFromRGB(0xFFFAFA)];
    
    NSString *rqType = [_detailInfo objectForKey:ID_REQUEST_TYPE];
    [_lbServiceValue setText:[JUntil stringDisplayWithID:rqType withCategory:ID_REQUEST_TYPE fromDefinesDictionary:_definesCode]];
    
    NSString *requester = [_detailInfo objectForKey:ID_REQUESTER];
    [_lbPhoneValue setText:requester];
    
    NSString *requestdate = [_detailInfo objectForKey:ID_UPDATE_DATE];
    NSDate *workdate = [JUntil dateFromString:requestdate];
    [_lbWorkTimeValue setText:[JUntil stringFromDate:workdate]];
    
    NSString *location = [_detailInfo objectForKey:ID_LOCATION];
    [_lbAddressValue setText:location];
    
    NSString *worktime = [_detailInfo objectForKey:ID_WORKING_HOUR];
    NSString *dayinweek = @"";
    NSArray *dayinweeks = [_detailInfo objectForKey:ID_WORK_DAYINWEEK];
    if (![dayinweeks isKindOfClass:[NSNull class]])
    {
        for (int i=0; i<[dayinweeks count]; i++)
        {
            NSString *day = [dayinweeks objectAtIndex:i];
            dayinweek = [dayinweek stringByAppendingString:day];
            
            if (i < [dayinweeks count] - 1)
            {
                dayinweek = [dayinweek stringByAppendingString:@","];
            }
            
            [_lbWorkTimeValue setText:[NSString stringWithFormat:@"%@ - %@",worktime,dayinweek]];
        }
    }
    else{
        [_lbWorkTimeValue setText:[NSString stringWithFormat:@"%@",worktime]];
    }
    
    double workhour = [[_detailInfo objectForKey:ID_WORKING_TIME] doubleValue];
    [_lbWorkHourValue setText:[NSString stringWithFormat:@"%.1f",workhour]];
    
    NSArray *options = [_detailInfo objectForKey:ID_SERVICE_EXTEND];
    if (![options isKindOfClass:[NSNull class]])
    {
        NSString *stroptions = @"";
        for (NSString *option in options)
        {
            stroptions = [stroptions stringByAppendingString:[JUntil stringDisplayWithID:option withCategory:ID_SERVICE_EXTEND fromDefinesDictionary:_definesCode]];
            
            if ([options count] > 1) {
                stroptions = [stroptions stringByAppendingString:@","];
            }
        }
        [_lbOptionValue setText:stroptions];
    }
    
    NSString *paymentmethod = [_detailInfo objectForKey:ID_PAYMENT_METHOD];
    if (![paymentmethod isKindOfClass:[NSNull class]])
    {
        [_lbPaymentValue setText:[JUntil stringDisplayWithID:paymentmethod withCategory:ID_PAYMENT_METHOD fromDefinesDictionary:_definesCode]];
    }
    
    NSString *note = [_detailInfo objectForKey:ID_USER_NOTE];
    if (![note isKindOfClass:[NSNull class]])
    {
        [_lbNoteValue setText:[NSString stringWithFormat:@" %@",note]];
    }
    
    NSNumber *price = [_detailInfo objectForKey:ID_TOTAL_PRICE];
    if (![price isKindOfClass:[NSNull class]])
    {
        [_lbTotalPriceValue setText:[NSString stringWithFormat:@"%.3fđ",[price doubleValue]]];
    }
        
    [self showStopButton];
    [self showRateButton];
}

-(void)showRateButton
{
    NSString *requestStatus = [_detailInfo objectForKey:ID_REQUEST_STATUS];
    
    if ([requestStatus isEqualToString:CODE_DADONDEP])
    {
        [_btRate setHidden:NO];
    }
    else
    {
        [_btRate setHidden:YES];
    }
}

-(void)showStopButton
{
    NSString *request_status = [_detailInfo objectForKey:ID_REQUEST_STATUS];
    
    if ([request_status isEqualToString:CODE_DANGYEUCAU])
    {
        [_btStopService setHidden:NO];
    }
    else
    {
        [_btStopService setHidden:YES];
    }
}

-(IBAction)didPressRateButton:(id)sender
{
    RateViewController *rateview = [self.storyboard instantiateViewControllerWithIdentifier:@"idrateview"];
    
    [rateview setUserToken:[_user userToken]];
    [rateview setIDService:[_detailInfo objectForKey:ID_SERVICE]];
    [rateview setServiceInfo:_detailInfo];
    [rateview setDelegate:self];
    
    [self.navigationController pushViewController:rateview animated:YES];
}

- (IBAction)didPressStopServiceButton:(id)sender
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    NSString *serviceID = [_detailInfo objectForKey:ID_SERVICE];
    NSString *token = [_user userToken];
    
    [apirequest requestAPICancelRequest:serviceID token:token completionHandler:^(NSDictionary * _Nullable resultDict, NSError * _Nonnull error)
    {
        if (error.code == 200)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleViewForStopOrder:resultDict];
            });
        }
        else if (error.code == RESPONSE_CODE_NODATA)
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_NODATA];
        }
        else if (error.code == RESPONSE_CODE_TIMEOUT)
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
        }
        else
        {
            [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
        }
    }];
}

#pragma mark - Delegate
-(void)handleViewForStopOrder:(NSDictionary*)resultDic
{    
    if (_delegate && [_delegate respondsToSelector:@selector(didStopOder:)])
    {
        [_delegate didStopOder:resultDic];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didRateOrder:(NSDictionary *)orderInfo
{
    _detailInfo = orderInfo;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didRateOder:)])
    {
        [_delegate didRateOder:orderInfo];
    }
}
@end
