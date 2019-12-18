//
//  ConfirmOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "ConfirmOrderViewController.h"

@interface ConfirmOrderViewController ()

@end

@implementation ConfirmOrderViewController
@synthesize order = _order;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Xác nhận dịch vụ"];
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
            
            [_txtContent setAttributedText:attributeStr];
        }
            break;
        case TYPE_TONGVESINH:
        {
        }
            break;
        case TYPE_JUPSOFA:
        {
        }
            break;
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressConfirmOrderButton:(id)sender {
}
@end
