//
//  DaySelectionTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DaySelectionTableViewCell.h"

@implementation DaySelectionTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_Thu2 setDayInWeek:DAY_THU2];
    [_Thu3 setDayInWeek:DAY_THU3];
    [_Thu4 setDayInWeek:DAY_THU4];
    [_Thu5 setDayInWeek:DAY_THU5];
    [_Thu6 setDayInWeek:DAY_THU6];
    [_Thu7 setDayInWeek:DAY_THU7];
    [_CN setDayInWeek:DAY_CN];
    
    [_Thu2 setDelegate:self];
    [_Thu3 setDelegate:self];
    [_Thu4 setDelegate:self];
    [_Thu5 setDelegate:self];
    [_Thu6 setDelegate:self];
    [_Thu7 setDelegate:self];
    [_CN setDelegate:self];
    
    _listSelectedDay = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _ordeAttribute = attribute;
}

-(void)setOrder:(Order *)order
{
    _order = order;
    
    [self showDay];
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

- (IBAction)didPressWorkDayButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeDaySelection:index:)]) {
        [_delegate didClickChangeDaySelection:_ordeAttribute index:_indexPath];
    }
}

-(void)showDay
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, dd/MM/yyyy"];
    [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
    
    [_btWorkDayValue setTitle:[format stringFromDate:[_order workDate]] forState:UIControlStateNormal];
}

#pragma mark - DayLabel Delegate
-(void)didSelectDayLabel:(DAYINWEEK)dayinweek
{
    [_listSelectedDay removeAllObjects];
    
    if ([_Thu2 selected]) {
        [_listSelectedDay addObject:@"T2"];
    }
    if ([_Thu3 selected]) {
        [_listSelectedDay addObject:@"T3"];
    }
    if ([_Thu4 selected]) {
        [_listSelectedDay addObject:@"T4"];
    }
    if ([_Thu5 selected]) {
        [_listSelectedDay addObject:@"T5"];
    }
    if ([_Thu6 selected]) {
        [_listSelectedDay addObject:@"T6"];
    }
    if ([_Thu7 selected]) {
        [_listSelectedDay addObject:@"T7"];
    }
    if ([_CN selected]) {
        [_listSelectedDay addObject:@"CN"];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectDayOfTheWeek:)])
    {
        [_delegate didSelectDayOfTheWeek:_listSelectedDay];
    }
}

-(void)didUnSelectDayLabel:(DAYINWEEK)dayinweek
{
    
}
@end
