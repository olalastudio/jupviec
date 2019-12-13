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
    
    [_startTime setRestorationIdentifier:@"starttimepicker"];
    [_endTime setRestorationIdentifier:@"endtimepicker"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_calendarPicker selectDate:[_order workDate]];
    
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

-(NSArray*)startTimeArray
{
    SHIFT_WORK shiftWork = [_order workShift];
    
    switch (shiftWork) {
        case SHIFT_WORK_MORNING:
            return @[@"08:00",@"08:30",@"09:00",@"09:30",@"10:00"];
            break;
        case SHIFT_WORK_AFTERNOON:
            return @[@"13:00",@"13:30",@"14:00",@"14:30",@"15:00"];
            break;
            case SHIFT_WORK_EVENING:
            return @[@"17:00",@"17:30",@"18:00",@"18:30",@"19:00"];
            break;
        default:
            break;
    }
    
    return nil;
}

-(NSArray*)endTimeArray
{
    SHIFT_WORK shiftWork = [_order workShift];
    
    switch (shiftWork) {
        case SHIFT_WORK_MORNING:
            return @[@"10:00",@"10:30",@"11:00",@"11:30",@"12:00"];
            break;
        case SHIFT_WORK_AFTERNOON:
            return @[@"15:00",@"15:30",@"16:00",@"16:30",@"17:00"];
            break;
            case SHIFT_WORK_EVENING:
            return @[@"19:00",@"19:30",@"20:00",@"20:30",@"21:00"];
            break;
        default:
            break;
    }
    
    return nil;
}

-(void)setSelectedTime
{
    NSMutableDictionary *worktime = [_order workTime];
    NSString *starttime = [worktime objectForKey:ATTRIBUTE_START_TIME];
    NSString *endtime = [worktime objectForKey:ATTRIBUTE_END_TIME];
    
    NSArray *startArray = [self startTimeArray];
    NSArray *endArray = [self endTimeArray];
    
    //start time
    for (int i=0; i < startArray.count; i++)
    {
        if ([starttime isEqualToString:[startArray objectAtIndex:i]])
        {
            [_startTime selectRow:i inComponent:0 animated:YES];
            break;
        }
    }
    
    //end time
    for (int i=0; i < endArray.count; i++)
    {
        if ([endtime isEqualToString:[endArray objectAtIndex:i]])
        {
            [_endTime selectRow:i inComponent:0 animated:YES];
            break;
        }
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
    NSString *startTime = [[self startTimeArray] objectAtIndex:[_startTime selectedRowInComponent:0]];
    NSString *endTime = [[self endTimeArray] objectAtIndex:[_endTime selectedRowInComponent:0]];
    
    NSDictionary *worktime = [NSDictionary dictionaryWithObjectsAndKeys:startTime,ATTRIBUTE_START_TIME, endTime, ATTRIBUTE_END_TIME, nil];

    if (_delegate && [_delegate respondsToSelector:@selector(didSelectTime:indexPath:workTime:)]) {
        [_delegate didSelectTime:_orderAttribute indexPath:_index workTime:worktime];
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

#pragma mark - PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([[pickerView restorationIdentifier] isEqualToString:@"starttimepicker"]) {
        return [[self startTimeArray] count];
    }
    
    return [[self endTimeArray] count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *list;
    if ([[pickerView restorationIdentifier] isEqualToString:@"starttimepicker"]) {
        list = [self startTimeArray];
    }
    else{
        list = [self endTimeArray];
    }
    
    return [list objectAtIndex:row];
}

@end
