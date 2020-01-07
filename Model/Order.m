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
@synthesize workHour = _workHour;
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
        [self initTimeOfExam];
        [self initWorkTime];
        _workHour = 3;
        _extraOption = nil;
        _paymentMethod = nil;
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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    if (minute % 10 > 0)
    {
        minute = ((minute/10) + 1) * 10;
    }
    
    if (minute >= 60) {
        minute = 0;
        hour = hour + 1;
    }
    
    
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:0];
    [components setNanosecond:0];
    
    _workTime = [calendar dateFromComponents:components];
}

-(void)initTimeOfExam
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    if (minute % 10 > 0)
    {
        minute = ((minute/10) + 1) * 10;
    }
    
    if (minute >= 60) {
        minute = 0;
        hour = hour + 1;
    }
    
    
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:0];
    [components setNanosecond:0];
    
    _timeOfExamine = [calendar dateFromComponents:components];
}
@end
