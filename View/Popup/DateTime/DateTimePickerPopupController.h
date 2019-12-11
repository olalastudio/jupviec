//
//  DateTimePickerPopupController.h
//  JupViec
//
//  Created by KienVu on 12/10/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import <FSCalendar/FSCalendar.h>

@protocol DateTimePickerDelegate <NSObject>

-(void)didSelectDate:(ORDER_ATTRIBUTE)sender date:(NSDate*_Nullable)date indexPath:(NSIndexPath*_Nonnull)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DateTimePickerPopupController : UIViewController <FSCalendarDelegate, FSCalendarDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    ORDER_ATTRIBUTE _orderAttribute;
    NSIndexPath     *_index;
    NSDate          *_selectedDate;
}

@property id<DateTimePickerDelegate>        delegate;

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet FSCalendar *calendarPicker;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@property (weak, nonatomic) IBOutlet UIPickerView *startTime;
@property (weak, nonatomic) IBOutlet UIPickerView *endTime;

- (IBAction)didPressCloseDateTimePickerPopupButton:(id)sender;
- (IBAction)didPressConfirmTimeButton:(id)sender;


-(void)setOrderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setSelectedDate:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END
