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
#import "DayLabel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DaySelectionTableViewCellDelegate <NSObject>

-(void)didClickChangeDaySelection:(ORDER_ATTRIBUTE)sender index:(NSIndexPath*)index;
-(void)didSelectDayOfTheWeek:(NSMutableArray*)dayofweeks;

@end

@interface DaySelectionTableViewCell : UITableViewCell <DayLabelDelegate>
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
    
    NSMutableArray      *_listSelectedDay;
}

@property id<DaySelectionTableViewCellDelegate>     delegate;
@property (weak, nonatomic) IBOutlet UILabel        *txtTitle;

@property (weak, nonatomic) IBOutlet DayLabel *Thu2;
@property (weak, nonatomic) IBOutlet DayLabel *Thu3;
@property (weak, nonatomic) IBOutlet DayLabel *Thu4;
@property (weak, nonatomic) IBOutlet DayLabel *Thu5;
@property (weak, nonatomic) IBOutlet DayLabel *Thu6;
@property (weak, nonatomic) IBOutlet DayLabel *Thu7;
@property (weak, nonatomic) IBOutlet DayLabel *CN;


-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

- (IBAction)didPressWorkDayButton:(id)sender;


@end

NS_ASSUME_NONNULL_END
