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
    
    [_startTime setDelegate:self];
    [_startTime setDataSource:self];
    [_endTime setDelegate:self];
    [_endTime setDataSource:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_calendarPicker selectDate:_selectedDate];
    
    if (_orderAttribute == ATTRIBUTE_NGAYLAMVIEC)
    {
        [_calendarPicker setHidden:NO];
        [_startTime setHidden:YES];
        [_endTime setHidden:YES];
        [_btnConfirm setHidden:YES];
        
        [_txtTitle setText:@"Ngày làm việc"];
    }
    else if (_orderAttribute == ATTRIBUTE_GIOLAMVIEC)
    {
        [_calendarPicker setHidden:YES];
        [_startTime setHidden:NO];
        [_endTime setHidden:NO];
        [_btnConfirm setHidden:NO];
        
        [_txtTitle setText:@"Giờ làm việc"];
    }
    
    [_startTime selectRow:0 inComponent:0 animated:YES];
    [_endTime selectRow:3 inComponent:0 animated:YES];
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

-(void)setSelectedDate:(NSDate *)date
{
    _selectedDate = date;
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

- (IBAction)didPressConfirmTimeButton:(id)sender {
    
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

#pragma mark - PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 7;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"06:00";
    }
    else if (row == 1){
        return @"07:00";
    }
    else if (row == 2){
        return @"08:00";
    }
    else if (row == 3){
        return @"09:00";
    }
    else if (row == 4){
        return @"10:00";
    }
    else if (row == 5){
        return @"11:00";
    }
    else if (row == 6){
        return @"12:00";
    }
    
    return @"";
}

@end
