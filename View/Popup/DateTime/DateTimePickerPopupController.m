//
//  DateTimePickerPopupController.m
//  JupViec
//
//  Created by KienVu on 12/10/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DateTimePickerPopupController.h"
#import "PopupView.h"

@interface DateTimePickerPopupController ()

@end

@implementation DateTimePickerPopupController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_timePicker setValue:[UIColor blackColor] forKey:@"textColor"];
    [_timePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
           self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                self.popupView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    [self.view setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:0.38]];
    
    if (_orderAttribute == ATTRIBUTE_SOGIOLAM)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
        [_timePicker setCountDownDuration:[_order workHour]*60*60];
    }
    else if (_orderAttribute == ATTRIBUTE_NGAYLAMVIEC)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeDate];
        [_timePicker setDate:[_order workDate]];
    }
    else if (_orderAttribute == ATTRIBUTE_NGAYLAMTRONGTUAN)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeDate];
        [_timePicker setDate:[_order workDate]];
    }
    else if (_orderAttribute == ATTRIBUTE_NGAYKHAOSAT)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeDate];
        [_timePicker setDate:[_order dayOfExamine]];
    }
    else if (_orderAttribute == ATTRIBUTE_GIOLAMVIEC)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeTime];
        [_timePicker setDate:[_order workTime]];
    }
    else if (_orderAttribute == ATTRIBUTE_GIOKHAOSAT)
    {
        [_timePicker setDatePickerMode:UIDatePickerModeTime];
        [_timePicker setDate:[_order timeOfExamine]];
    }
        
    [self setTimeForPickerView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

-(void)setOrderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _orderAttribute = attribute;
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _index = index;
}

-(void)setOrder:(Order*)order
{
    _order = order;
}

-(void)setTimeForPickerView
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    minute = ((minute/10) + 1)*10;
    
    if (minute >= 60) {
        minute = 0;
        hour = hour + 1;
    }
    
    [components setHour:hour];
    [components setMinute:minute];
    
    if (_orderAttribute == ATTRIBUTE_SOGIOLAM)
    {
        [_timePicker setMinuteInterval:30];
    }
    else
    {
        [_timePicker setMinimumDate:[calendar dateFromComponents:components]];
        [_timePicker setMinuteInterval:10];
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

- (IBAction)didPressCloseDateTimePickerPopupButton:(id)sender
{    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didPressConfirmTimeButton:(id)sender
{
    NSDate *selectedTime = [_timePicker date];
    
    if (_orderAttribute == ATTRIBUTE_GIOLAMVIEC || _orderAttribute == ATTRIBUTE_GIOKHAOSAT)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectTime:indexPath:workTime:)])
        {
            [_delegate didSelectTime:_orderAttribute indexPath:_index workTime:selectedTime];
        }
    }
    else if (_orderAttribute == ATTRIBUTE_SOGIOLAM)
    {
        NSTimeInterval timeinterval = [_timePicker countDownDuration];
        double hour = timeinterval/3600;
        
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectNumberHour:indexPath:workTime:)])
        {
            [_delegate didSelectNumberHour:_orderAttribute indexPath:_index workTime:hour];
        }
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectDate:date:indexPath:)])
        {
            [_delegate didSelectDate:_orderAttribute date:selectedTime indexPath:_index];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
