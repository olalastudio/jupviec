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

@end
