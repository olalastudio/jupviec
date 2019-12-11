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
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

- (IBAction)didPressWorkDayButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeDaySelection:)]) {
        [_delegate didClickChangeDaySelection:_indexPath];
    }
}
@end
