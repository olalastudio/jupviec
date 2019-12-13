//
//  Order.h
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface Order : NSObject

@property   TASK_TYPE           *orderType;
@property   NSString            *workAddress;
@property   NSString            *homeNumber;
@property   NSDate              *workDate;
@property   NSMutableArray      *workDayInWeek;
@property   NSDate              *dayOfExamine;
@property   NSMutableDictionary    *timeOfExamine;
@property   SHIFT_WORK             workShift;
@property   NSMutableDictionary    *workTime;
@property   NSMutableDictionary    *extraOption;
@property   NSMutableDictionary    *paymentMethod;
@property   NSMutableDictionary    *priceTags;
@property   NSString               *note;

@end

NS_ASSUME_NONNULL_END
