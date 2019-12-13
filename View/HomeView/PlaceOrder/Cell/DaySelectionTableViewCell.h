//
//  DaySelectionTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DaySelectionTableViewCellDelegate <NSObject>

-(void)didClickChangeDaySelection:(ORDER_ATTRIBUTE)sender index:(NSIndexPath*)index;

@end

@interface DaySelectionTableViewCell : UITableViewCell
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
}

@property id<DaySelectionTableViewCellDelegate>     delegate;
@property (weak, nonatomic) IBOutlet UIImageView    *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel        *txtTitle;
@property (weak, nonatomic) IBOutlet UIButton       *btWorkDayValue;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

- (IBAction)didPressWorkDayButton:(id)sender;


@end

NS_ASSUME_NONNULL_END
