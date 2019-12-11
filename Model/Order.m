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
@synthesize workTime = _workTime;
@synthesize extraOption = _extraOption;
@synthesize paymentMethod = _paymentMethod;
@synthesize priceTags = _priceTags;
@synthesize note = _note;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _orderType = TYPE_NONE;
        _workAddress = @"";
        _homeNumber = @"";
        _workDate = [NSDate date];
        _workDayInWeek = [NSMutableArray arrayWithCapacity:0];
        _dayOfExamine = [NSDate date];
        _timeOfExamine  = [NSMutableDictionary dictionaryWithCapacity:0];
        _workTime = [NSMutableDictionary dictionaryWithCapacity:0];
        _extraOption = [NSMutableDictionary dictionaryWithCapacity:0];
        _paymentMethod = [NSMutableDictionary dictionaryWithCapacity:0];
        _note = @"";
    }
    return self;
}

@end
