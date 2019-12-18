//
//  Order.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize orderType = _orderType;
@synthesize workAddress = _workAddress;
@synthesize homeNumber = _homeNumber;
@synthesize workDate = _workDate;
@synthesize workDayInWeek =_workDayInWeek;
@synthesize dayOfExamine = _dayOfExamine;
@synthesize timeOfExamine = _timeOfExamine;
@synthesize workShift   = _workShift;
@synthesize workTime = _workTime;
@synthesize extraOption = _extraOption;
@synthesize paymentMethod = _paymentMethod;
@synthesize priceTags = _priceTags;
@synthesize note = _note;
@synthesize totalMoney = _totalMoney;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _orderType = TYPE_NONE;
        _workAddress = @"";
        _homeNumber = @"";
        [self initWorkDate];
        _workDayInWeek = [NSMutableArray arrayWithCapacity:0];
        _dayOfExamine = [NSDate date];
        _timeOfExamine  = [NSMutableDictionary dictionaryWithCapacity:0];
        [self initWorkTime];
        _extraOption = [NSMutableArray arrayWithCapacity:0];
        _paymentMethod = [NSMutableDictionary dictionaryWithCapacity:0];
        _note = @"";
        _totalMoney = 0;
    }
    return self;
}

-(void)initWorkDate
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    _workDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
}

-(void)initWorkTime
{
    NSString *startTime = @"08:00";
    NSString *endTime = @"11:30";
    
    _workShift = SHIFT_WORK_MORNING;
    _workTime = [NSMutableDictionary dictionaryWithObjectsAndKeys:startTime,ATTRIBUTE_START_TIME, endTime, ATTRIBUTE_END_TIME, nil];
}
@end
