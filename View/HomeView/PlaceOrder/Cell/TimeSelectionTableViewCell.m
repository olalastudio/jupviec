//
//  TimeSelectionTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "TimeSelectionTableViewCell.h"

@implementation TimeSelectionTableViewCell
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

- (IBAction)didPressWorkTimeButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeTimeSelection:)])
    {
        [_delegate didClickChangeTimeSelection:_indexPath];
    }
}
@end
