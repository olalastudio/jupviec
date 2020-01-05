//
//  DateTimePickerPopupController.m
//  JupViec
//
//  Created by KienVu on 12/10/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DateTimePickerPopupController.h"

@interface DateTimePickerPopupController ()

@end

@implementation DateTimePickerPopupController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_calendarPicker setDelegate:self];
    [_calendarPicker setDataSource:self];
}

-(void)setContrainForPickerView
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
    
    [_timePicker setMinimumDate:[calendar dateFromComponents:components]];
    [_timePicker setMinuteInterval:10];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setContrainForPickerView];
    
    if (_orderAttribute == ATTRIBUTE_NGAYLAMVIEC || _orderAttribute == ATTRIBUTE_NGAYLAMTRONGTUAN)
    {
        [_calendarPicker setHidden:NO];
        [_timePicker setHidden:YES];
        [_btnConfirm setHidden:YES];
        
        [_calendarPicker selectDate:[_order workDate]];
        [_txtTitle setText:@"Ngày làm việc"];
    }
    else if (_orderAttribute == ATTRIBUTE_NGAYKHAOSAT)
    {
        [_calendarPicker setHidden:NO];
        [_timePicker setHidden:YES];
        [_btnConfirm setHidden:YES];
        
        [_calendarPicker selectDate:[_order dayOfExamine]];
        [_txtTitle setText:@"Ngày khảo sát"];
    }
    else if (_orderAttribute == ATTRIBUTE_GIOLAMVIEC || _orderAttribute == ATTRIBUTE_GIOKHAOSAT)
    {
        [_calendarPicker setHidden:YES];
        [_timePicker setHidden:NO];
        [_btnConfirm setHidden:NO];
        
        [_txtTitle setText:@"Giờ làm việc"];
    }
    
    [self setSelectedTime];
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

-(void)setSelectedTime
{
    NSDate *worktime = [_order workTime];
    
    if (_orderAttribute == ATTRIBUTE_GIOKHAOSAT) {
        //worktime = [_order timeOfExamine];
    }
    
    [_timePicker setDate:worktime];
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
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectTime:indexPath:workTime:)])
    {
        [_delegate didSelectTime:_orderAttribute indexPath:_index workTime:selectedTime];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Calendar Delegate
-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@ at month %lu",date,(unsigned long)monthPosition);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectDate:date:indexPath:)]) {
        [_delegate didSelectDate:_orderAttribute date:date indexPath:_index];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSDate*)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [NSDate date];
}

#pragma mark - TimePickerView Delegate


@end
