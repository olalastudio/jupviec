//
//  ConfirmOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "HomeViewController.h"
#import "LoadingViewController.h"
#import "CommonDefines.h"
#import "APIRequest.h"
#import "JUntil.h"

@interface ConfirmOrderViewController ()
{
    NSDictionary *_serviceInfo;
}

@end

@implementation ConfirmOrderViewController
@synthesize order = _order;
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Xác nhận dịch vụ"];
    
    self.view.layer.masksToBounds = YES;

    [_txtType setTextColor:[UIColor blackColor]];
    [_txtAddressTitle setTextColor:[UIColor blackColor]];
    [_txtPhoneNumberTitle setTextColor:[UIColor blackColor]];
    [_txtWorkDateTitle setTextColor:[UIColor blackColor]];
    [_txtWorkTimeTitle setTextColor:[UIColor blackColor]];
    [_txtWorkHourTitle setTextColor:[UIColor blackColor]];
    [_txtExtendServiceTitle setTextColor:[UIColor blackColor]];
    [_txtPaymentMethodTitle setTextColor:[UIColor blackColor]];
    [_txtNoteTitle setTextColor:[UIColor blackColor]];
    [_txtTotalMoneyTitle setTextColor:[UIColor blackColor]];
    [_txtTotalMoneyValue setTextColor:[UIColor blackColor]];
    
    [_txtAddressValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtPhoneNumberValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtWorkDateValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtWorkTimeValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtWorkHourValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtExtendServiceValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtPaymentMethodValue setTextColor:UIColorFromRGB(0xACB3BF)];
    [_txtNoteValue setTextColor:UIColorFromRGB(0xACB3BF)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self showContent];
}

-(void)setOrder:(Order *)order
{
    _order = order;
}

-(Order*)order
{
    return _order;
}

-(void)showContent
{
    switch ([_order orderType]) {
        case TYPE_DUNGLE:
        {

            [_txtType setText:@"Dùng lẻ"];
            [_txtAddressValue setText:[NSString stringWithFormat:@"%@ %@",[_order homeNumber],[_order workAddress]]];
            [_txtWorkDateValue setText:[JUntil stringFromDate:[_order workDate]]];
            
            NSDate *worktime = [_order workTime];
            NSInteger hour = [JUntil hourFromDate:worktime];
            NSInteger minute = [JUntil minuteFromDate:worktime];
            double workhour = [_order workHour];
            
            [_txtWorkTimeValue setText:[NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute]];
            [_txtWorkHourValue setText:[NSString stringWithFormat:@"%.1f",workhour]];
            
            NSArray *options = [_order extraOption];
            if (![options isKindOfClass:[NSNull class]])
            {
                NSString *stroptions = @"";
                for (NSDictionary *option in options)
                {
                    stroptions = [stroptions stringByAppendingString:[option objectForKey:ID_NAME]];
                    
                    if ([options count] > 1) {
                        stroptions = [stroptions stringByAppendingString:@","];
                    }
                }
                [_txtExtendServiceValue setText:stroptions];
            }
            
            NSMutableDictionary *paymentmethod = [_order paymentMethod];
            if ([paymentmethod count] > 0)
            {
                NSString *name = [paymentmethod objectForKey:ID_NAME];
                [_txtPaymentMethodValue setText:name];
            }
            
            [_txtNoteValue setText:[_order note]];
            
        }
            break;
        case TYPE_DUNGDINHKY:
        {
            [_txtType setText:@"Dùng định kỳ"];
            [_txtAddressValue setText:[_order workAddress]];
            [_txtWorkDateValue setText:[JUntil stringFromDate:[_order workDate]]];
            
            NSDate *worktime = [_order workTime];
            NSInteger hour = [JUntil hourFromDate:worktime];
            NSInteger minute = [JUntil minuteFromDate:worktime];
            double workhour = [_order workHour];
            
            NSMutableString *workdayinweek = [NSMutableString string];
            if ([[_order workDayInWeek] count] > 0)
            {
                for (int i = 0; i< [[_order workDayInWeek] count]; i++)
                {
                    NSString *day = [[_order workDayInWeek] objectAtIndex:i];
                    [workdayinweek appendString:day];
                    if (i == [[_order workDayInWeek] count] - 1) {
                        break;
                    }
                    [workdayinweek appendString:@","];
                }
            }
            
            if ([workdayinweek isEqualToString:@""]) {
                [_txtWorkTimeValue setText:[NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute]];
            }else{
                [_txtWorkTimeValue setText:[NSString stringWithFormat:@"%2ld:%2ld - %@",(long)hour,(long)minute,workdayinweek]];
            }
            
            [_txtWorkHourValue setText:[NSString stringWithFormat:@"%.1f",workhour]];
            
            NSArray *options = [_order extraOption];
            if (![options isKindOfClass:[NSNull class]])
            {
                NSString *stroptions = @"";
                for (NSDictionary *option in options)
                {
                    stroptions = [stroptions stringByAppendingString:[option objectForKey:ID_NAME]];
                    
                    if ([options count] > 1) {
                        stroptions = [stroptions stringByAppendingString:@","];
                    }
                }
                [_txtExtendServiceValue setText:stroptions];
            }
            
            NSMutableDictionary *paymentmethod = [_order paymentMethod];
            if ([paymentmethod count] > 0)
            {
                NSString *name = [paymentmethod objectForKey:ID_NAME];
                [_txtPaymentMethodValue setText:name];
            }
            
            [_txtNoteValue setText:[_order note]];
            
        }
            break;
        case TYPE_TONGVESINH:
        {
            [_txtType setText:@"Tổng vệ sinh"];
            [_txtAddressValue setText:[_order workAddress]];
            [_txtWorkDateValue setText:[JUntil stringFromDate:[_order dayOfExamine]]];
            
            NSDate *worktime = [_order timeOfExamine];
            NSInteger hour = [JUntil hourFromDate:worktime];
            NSInteger minute = [JUntil minuteFromDate:worktime];
            double workhour = [_order workHour];
            
            [_txtWorkTimeValue setText:[NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute]];
            [_txtWorkHourValue setText:[NSString stringWithFormat:@"%.1f",workhour]];
            
            [_txtNoteValue setText:[_order note]];
            
            [_txtExtendServiceValue setText:@"None"];
        }
            break;
        case TYPE_JUPSOFA:
        {
            [_txtType setText:@"Đặt JupSofa"];
            [_txtAddressValue setText:[_order workAddress]];
            [_txtWorkDateValue setText:[JUntil stringFromDate:[_order workDate]]];
            
            NSDate *worktime = [_order workTime];
            NSInteger hour = [JUntil hourFromDate:worktime];
            NSInteger minute = [JUntil minuteFromDate:worktime];
            double workhour = [_order workHour];
            
            [_txtWorkTimeValue setText:[NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute]];
            [_txtWorkHourValue setText:[NSString stringWithFormat:@"%.1f",workhour]];
            
             [_txtNoteValue setText:[_order note]];
            
            [_txtExtendServiceValue setText:@"None"];
            [_txtPaymentMethodValue setText:@"None"];
            
        }
            break;
        default:
            break;
    }
    
    [_txtTotalMoneyValue setText:[NSString stringWithFormat:@"%.3fđ/%.1fh",[_order totalMoney],[_order workHour]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressConfirmOrderButton:(id)sender
{
    NSString *strToken = [_user userToken];
    NSMutableDictionary *detailService = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    //request type
    switch ([_order orderType]) {
        case TYPE_DUNGLE:
        {
            [detailService setObject:CODE_DUNGLE forKey:ID_REQUEST_TYPE];
            
            //requester
            if ([_user userPhoneNum]) {
                [detailService setObject:[_user userPhoneNum] forKey:ID_REQUESTER];
            }
            
            //location
            [detailService setObject:[NSString stringWithFormat:@"%@ %@",[_order homeNumber],[_order workAddress]] forKey:ID_LOCATION];
            
            //working date
            [detailService setObject:[JUntil stringFromDate:[_order workDate]] forKey:ID_WORKING_DATE];
            
            //workinghour
            NSInteger hour = [JUntil hourFromDate:[_order workTime]];
            NSInteger minute = [JUntil minuteFromDate:[_order workTime]];
            NSString *strWorkHour = [NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute];
            [detailService setObject:strWorkHour forKey:ID_WORKING_HOUR];
            
            //working time
            [detailService setObject:[NSString stringWithFormat:@"%.1f",[_order workHour]] forKey:ID_WORKING_TIME];
            
            //extend service
            NSArray *extendservice = [_order extraOption];
            NSMutableArray *options = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *item in extendservice)
            {
                NSString *extendcode = [item objectForKey:@"code"];
                [options addObject:extendcode];
            }
            
            if ([options count] > 0) {
                [detailService setObject:options forKey:ID_SERVICE_EXTEND];
            }
            
            //Payment method
            NSString *paymethod = [[_order paymentMethod] objectForKey:@"code"];
            [detailService setObject:paymethod forKey:ID_PAYMENT_METHOD];
            
            //user note
            [detailService setObject:[_order note] forKey:ID_USER_NOTE];
        }
            break;
        case TYPE_DUNGDINHKY:
        {
            [detailService setObject:CODE_DINHKY forKey:ID_REQUEST_TYPE];
            
            //requester
            if ([_user userPhoneNum]) {
                [detailService setObject:[_user userPhoneNum] forKey:ID_REQUESTER];
            }
            
            //location
            [detailService setObject:[_order workAddress] forKey:ID_LOCATION];
            
            //working date
            [detailService setObject:[JUntil stringFromDate:[_order workDate]] forKey:ID_WORKING_DATE];
            
            //workinghour
            NSInteger hour = [JUntil hourFromDate:[_order workTime]];
            NSInteger minute = [JUntil minuteFromDate:[_order workTime]];
            NSString *strWorkHour = [NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute];
            [detailService setObject:strWorkHour forKey:ID_WORKING_HOUR];
            
            //working time
            [detailService setObject:[NSString stringWithFormat:@"%.1f",[_order workHour]] forKey:ID_WORKING_TIME];
            
            //extend service
            NSArray *extendservice = [_order extraOption];
            NSMutableArray *options = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *item in extendservice) {
                NSString *extendcode = [item objectForKey:@"code"];
                [options addObject:extendcode];
            }
            
            if ([options count] > 0) {
                [detailService setObject:options forKey:ID_SERVICE_EXTEND];
            }
            
            //day of week
            if ([[_order workDayInWeek] count] > 0) {
                [detailService setObject:[_order workDayInWeek] forKey:ID_WORK_DAYINWEEK];
            }
            
            
            //Payment method
            NSString *paymethod = [[_order paymentMethod] objectForKey:@"code"];
            [detailService setObject:paymethod forKey:ID_PAYMENT_METHOD];
            
            //user note
            [detailService setObject:[_order note] forKey:ID_USER_NOTE];
        }
            break;
        case TYPE_TONGVESINH:
        {
            [detailService setObject:CODE_TONGVESINH forKey:ID_REQUEST_TYPE];
            
            //requester
            if ([_user userPhoneNum]) {
                [detailService setObject:[_user userPhoneNum] forKey:ID_REQUESTER];
            }
            
            //location
            [detailService setObject:[_order workAddress] forKey:ID_LOCATION];
            
            //working date
            [detailService setObject:[JUntil stringFromDate:[_order dayOfExamine]] forKey:ID_WORKING_DATE];
            
            //workinghour
            NSInteger hour = [JUntil hourFromDate:[_order timeOfExamine]];
            NSInteger minute = [JUntil minuteFromDate:[_order timeOfExamine]];
            NSString *strWorkHour = [NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute];
            [detailService setObject:strWorkHour forKey:ID_WORKING_HOUR];
            
            //user note
            [detailService setObject:[_order note] forKey:ID_USER_NOTE];
        }
            break;
        case TYPE_JUPSOFA:
        {
            [detailService setObject:CODE_SOFA forKey:ID_REQUEST_TYPE];
            
            //requester
            [detailService setObject:[_user userPhoneNum] forKey:ID_REQUESTER];
            
            //location
            [detailService setObject:[_order workAddress] forKey:ID_LOCATION];
            
            //working date
            [detailService setObject:[JUntil stringFromDate:[_order workDate]] forKey:ID_WORKING_DATE];
            
            //workinghour
            NSInteger hour = [JUntil hourFromDate:[_order workTime]];
            NSInteger minute = [JUntil minuteFromDate:[_order workTime]];
            NSString *strWorkHour = [NSString stringWithFormat:@"%2ld:%2ld",(long)hour,(long)minute];
            [detailService setObject:strWorkHour forKey:ID_WORKING_HOUR];
            
            //user note
            [detailService setObject:[_order note] forKey:ID_USER_NOTE];
        }
            break;
        default:
            break;
    }
    
    //price
    NSNumber *price = [NSNumber numberWithDouble:[_order totalMoney]];
    [detailService setObject:price forKey:ID_PRICE];
    
    APIRequest *apiRequest = [[APIRequest alloc] init];
    
    LoadingViewController *loadingview = [self.storyboard instantiateViewControllerWithIdentifier:@"idloadingview"];
    [loadingview show:self];
    
    [apiRequest requestAPIBookService:strToken detailService:detailService completionhandler:^(NSDictionary * _Nullable serviceInfo, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingview dismiss];
            [self showConfirmAlert:serviceInfo error:error];
        });
    }];
}

#pragma mark - Alert Confirm
-(void)showConfirmAlert:(NSDictionary*)serviceInfo error:(NSError*)error
{
    if (error.code != 200)
    {
        [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
    }
    else
    {
        _serviceInfo = [NSDictionary dictionaryWithDictionary:serviceInfo];
        [JUntil showPopup:self responsecode:RESPONSE_CODE_PLACE_ORDER_SUCCESS completionHandler:^(POPUP_ACTION action) {
            
        }];
    }
}

-(NSDictionary*)completeServiceInfo
{
    return _serviceInfo;
}

-(void)didCloseAlertPopupWithCode:(POPUP_ACTION)code
{
    if (code == ACTION_OK)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *viewcontrollers = [self.navigationController viewControllers];
            
            for (UIViewController *viewcontroll in viewcontrollers)
            {
                if ([viewcontroll isKindOfClass:[HomeViewController class]])
                {
                    HomeViewController *homeview = (HomeViewController*)viewcontroll;
                    [homeview didCompleteOrder:[self completeServiceInfo]];
                    
                    [self.navigationController popToViewController:homeview animated:YES];
                }
            }
        });
    }
}
@end
