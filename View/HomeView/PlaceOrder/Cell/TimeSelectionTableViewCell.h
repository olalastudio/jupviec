//
//  TimeSelectionTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TimeSelectionTableViewCellDelegate <NSObject>

-(void)didClickChangeTimeSelection:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath*)index;
-(void)didClickChangeWorkShift:(SHIFT_WORK)workshift workTime:(NSMutableDictionary*)worktime attribute:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath*)index;

@end

@interface TimeSelectionTableViewCell : UITableViewCell
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
}

@property id<TimeSelectionTableViewCellDelegate>    delegate;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgShiftWork;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkTime;
@property (weak, nonatomic) IBOutlet UIButton *btWorkTimeValue;

- (IBAction)didPressWorkTimeButton:(id)sender;
- (IBAction)didSelectWorkShiftSegment:(id)sender;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

@end

NS_ASSUME_NONNULL_END
