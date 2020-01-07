//
//  ConfirmOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "HomeViewController.h"
#import "APIRequest.h"
#import "JUntil.h"

@interface ConfirmOrderViewController ()

@end

@implementation ConfirmOrderViewController
@synthesize order = _order;
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Xác nhận dịch vụ"];
    self.view.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_txtContent setText:@"\n"];
    
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
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n"];
            
            NSAttributedString *tasktype = [[NSAttributedString alloc] initWithString:@"Loại dịch vụ: Đặt Lẻ\n\n"];
            [attributeStr appendAttributedString:tasktype];
            
            NSString *strworkaddress = [NSString stringWithFormat:@"Địa điểm làm việc: %@\n\n",[_order workAddress]];
            NSAttributedString *workaddress = [[NSAttributedString alloc] initWithString:strworkaddress];
            [attributeStr appendAttributedString:workaddress];
            
            NSString *strworkdate = [NSString stringWithFormat:@"Ngày làm việc: %@\n\n",[_order workDate]];
            NSAttributedString *workdate = [[NSAttributedString alloc] initWithString:strworkdate];
            [attributeStr appendAttributedString:workdate];
            
            NSString *strworkTime = [NSString stringWithFormat:@"Giờ làm việc: %@\n\n",[_order workTime]];
            NSAttributedString *worktime = [[NSAttributedString alloc] initWithString:strworkTime];
            [attributeStr appendAttributedString:worktime];
            
            NSString *strextraservice = [NSString stringWithFormat:@"Dịch vụ kèm theo: %@\n\n",[_order extraOption]];
            NSAttributedString *extraservice = [[NSAttributedString alloc] initWithString:strextraservice];
            [attributeStr appendAttributedString:extraservice];
            
            NSString *strpaymentmethod = [NSString stringWithFormat:@"Hình thức thanh toán: %@\n\n",[_order paymentMethod]];
            NSAttributedString *paymentmethod = [[NSAttributedString alloc] initWithString:strpaymentmethod];
            [attributeStr appendAttributedString:paymentmethod];
            
            NSString *strnote = [NSString stringWithFormat:@"Ghi chú: %@\n\n",[_order note]];
            NSAttributedString *note = [[NSAttributedString alloc] initWithString:strnote];
            [attributeStr appendAttributedString:note];
            
            [_txtContent setAttributedText:attributeStr];
        }
            break;
        case TYPE_DUNGDINHKY:
        {
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n"];
            
            NSAttributedString *tasktype = [[NSAttributedString alloc] initWithString:@"Loại dịch vụ: Đặt Định kỳ\n"];
            [attributeStr appendAttributedString:tasktype];
            
            NSString *strworkaddress = [NSString stringWithFormat:@"Địa điểm làm việc: %@\n\n",[_order workAddress]];
            NSAttributedString *workaddress = [[NSAttributedString alloc] initWithString:strworkaddress];
            [attributeStr appendAttributedString:workaddress];
            
            NSString *strworkdate = [NSString stringWithFormat:@"Ngày làm việc: %@\n\n",[_order workDate]];
            NSAttributedString *workdate = [[NSAttributedString alloc] initWithString:strworkdate];
            [attributeStr appendAttributedString:workdate];
            
            NSString *strworkdayinweek = [NSString stringWithFormat:@"Ngày làm trong tuần : %@\n\n",[_order workDayInWeek]];
            NSAttributedString *workdayinweek = [[NSAttributedString alloc] initWithString:strworkdayinweek];
            [attributeStr appendAttributedString:workdayinweek];
            
            NSString *strworkTime = [NSString stringWithFormat:@"Giờ làm việc: %@\n\n",[_order workTime]];
            NSAttributedString *worktime = [[NSAttributedString alloc] initWithString:strworkTime];
            [attributeStr appendAttributedString:worktime];
            
            NSString *strextraservice = [NSString stringWithFormat:@"Dịch vụ kèm theo: %@\n\n",[_order extraOption]];
            NSAttributedString *extraservice = [[NSAttributedString alloc] initWithString:strextraservice];
            [attributeStr appendAttributedString:extraservice];
            
            NSString *strpaymentmethod = [NSString stringWithFormat:@"Hình thức thanh toán: %@\n\n",[_order paymentMethod]];
            NSAttributedString *paymentmethod = [[NSAttributedString alloc] initWithString:strpaymentmethod];
            [attributeStr appendAttributedString:paymentmethod];
            
            NSString *strnote = [NSString stringWithFormat:@"Ghi chú: %@\n\n",[_order note]];
            NSAttributedString *note = [[NSAttributedString alloc] initWithString:strnote];
            [attributeStr appendAttributedString:note];
            
            [_txtContent setAttributedText:attributeStr];
        }
            break;
        case TYPE_TONGVESINH:
        {
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n"];
            
            NSAttributedString *tasktype = [[NSAttributedString alloc] initWithString:@"Loại dịch vụ: Tổng vệ sinh\n"];
            [attributeStr appendAttributedString:tasktype];
            
            NSString *strworkaddress = [NSString stringWithFormat:@"Địa điểm làm việc: %@\n\n",[_order workAddress]];
            NSAttributedString *workaddress = [[NSAttributedString alloc] initWithString:strworkaddress];
            [attributeStr appendAttributedString:workaddress];
            
            NSString *strexamdate = [NSString stringWithFormat:@"Ngày khảo sat: %@\n\n",[_order dayOfExamine]];
            NSAttributedString *examdate = [[NSAttributedString alloc] initWithString:strexamdate];
            [attributeStr appendAttributedString:examdate];
            
            NSString *strexamTime = [NSString stringWithFormat:@"Giờ khảo sát mong muốn: %@\n\n",[_order timeOfExamine]];
            NSAttributedString *examtime = [[NSAttributedString alloc] initWithString:strexamTime];
            [attributeStr appendAttributedString:examtime];
            
            NSString *strnote = [NSString stringWithFormat:@"Ghi chú: %@\n\n",[_order note]];
            NSAttributedString *note = [[NSAttributedString alloc] initWithString:strnote];
            [attributeStr appendAttributedString:note];
            
            [_txtContent setAttributedText:attributeStr];
        }
            break;
        case TYPE_JUPSOFA:
        {
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n"];
            
            NSAttributedString *tasktype = [[NSAttributedString alloc] initWithString:@"Loại dịch vụ: Jup Sofa\n"];
            [attributeStr appendAttributedString:tasktype];
            
            NSString *strworkaddress = [NSString stringWithFormat:@"Địa điểm làm việc: %@\n\n",[_order workAddress]];
            NSAttributedString *workaddress = [[NSAttributedString alloc] initWithString:strworkaddress];
            [attributeStr appendAttributedString:workaddress];
            
            NSString *strexamdate = [NSString stringWithFormat:@"Ngày làm việc: %@\n\n",[_order workDate]];
            NSAttributedString *examdate = [[NSAttributedString alloc] initWithString:strexamdate];
            [attributeStr appendAttributedString:examdate];
            
            NSString *strexamTime = [NSString stringWithFormat:@"Giờ làm việc: %@\n\n",[_order workTime]];
            NSAttributedString *examtime = [[NSAttributedString alloc] initWithString:strexamTime];
            [attributeStr appendAttributedString:examtime];
            
            NSString *strnote = [NSString stringWithFormat:@"Ghi chú: %@\n\n",[_order note]];
            NSAttributedString *note = [[NSAttributedString alloc] initWithString:strnote];
            [attributeStr appendAttributedString:note];
            
            [_txtContent setAttributedText:attributeStr];
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
    
    [apiRequest requestAPIBookService:strToken detailService:detailService completionhandler:^(NSDictionary * _Nullable serviceInfo, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
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
        [JUntil showPopup:self responsecode:RESPONSE_CODE_PLACE_ORDER_SUCCESS completionHandler:^(POPUP_ACTION action) {
            if (action == ACTION_OK)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *viewcontrollers = [self.navigationController viewControllers];
                    
                    for (UIViewController *viewcontroll in viewcontrollers)
                    {
                        if ([viewcontroll isKindOfClass:[HomeViewController class]])
                        {
                            HomeViewController *homeview = (HomeViewController*)viewcontroll;
                            [homeview didCompleteOrder:serviceInfo];
                            
                            [self.navigationController popToViewController:homeview animated:YES];
                        }
                    }
                });
            }
        }];
    }
}
@end
