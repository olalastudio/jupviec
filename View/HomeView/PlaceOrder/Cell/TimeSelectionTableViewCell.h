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

@class JTextView;

NS_ASSUME_NONNULL_BEGIN

@protocol TimeSelectionTableViewCellDelegate <NSObject>

-(void)didClickWorkTimeSelection:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath*)index;
-(void)didClickWorkHourSelection:(ORDER_ATTRIBUTE)attribute index:(NSIndexPath*)index;

@end

@interface TimeSelectionTableViewCell : UITableViewCell <UITextViewDelegate>
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
}

@property id<TimeSelectionTableViewCellDelegate>    delegate;

@property (weak, nonatomic) IBOutlet UILabel    *txtWorkTime;
@property (weak, nonatomic) IBOutlet UILabel    *txtWorkHour;
@property (weak, nonatomic) IBOutlet JTextView  *workTime;
@property (weak, nonatomic) IBOutlet JTextView  *workHour;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

@end

NS_ASSUME_NONNULL_END
