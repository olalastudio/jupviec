//
//  DateTimePickerPopupController.h
//  JupViec
//
//  Created by KienVu on 12/10/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "Order.h"
#import <FSCalendar/FSCalendar.h>

@protocol DateTimePickerDelegate <NSObject>

-(void)didSelectDate:(ORDER_ATTRIBUTE)sender date:(NSDate*_Nullable)date indexPath:(NSIndexPath*_Nonnull)index;
-(void)didSelectTime:(ORDER_ATTRIBUTE)sender indexPath:(NSIndexPath*_Nonnull)index workTime:(NSDate*_Nonnull)worktime;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DateTimePickerPopupController : UIViewController <FSCalendarDelegate, FSCalendarDataSource>
{
    ORDER_ATTRIBUTE _orderAttribute;
    NSIndexPath     *_index;
    Order           *_order;
}

@property id<DateTimePickerDelegate>        delegate;

@property (weak, nonatomic) IBOutlet UILabel    *txtTitle;
@property (weak, nonatomic) IBOutlet UIButton   *btnConfirm;

@property (weak, nonatomic) IBOutlet FSCalendar *calendarPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;


- (IBAction)didPressCloseDateTimePickerPopupButton:(id)sender;
- (IBAction)didPressConfirmTimeButton:(id)sender;


-(void)setOrderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

@end

NS_ASSUME_NONNULL_END
