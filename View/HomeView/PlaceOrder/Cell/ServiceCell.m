//
//  ServiceCell.m
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_txtServiceName setTextColor:[UIColor blackColor]];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)isSelect
{
    return _isSelect;
}

-(void)setIsSelect:(BOOL)select
{
    _isSelect = select;
    
    if (_type == TYPE_POPUP)
    {
        NSLog(@"title %@",[_txtServiceName text]);
        if (_isSelect) {
            NSLog(@"selected");
            [_btDelete setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
            [_btDelete setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
        }
        else{
            NSLog(@"unselected");
            [_btDelete setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [_btDelete setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
        }
    }
    else{
        [_btDelete setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [_btDelete setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    }
}

-(void)setServiceCellType:(ServiceCellType)type
{
    _type = type;
}

-(void)setIndexPath:(NSIndexPath*)index
{
    _index = index;
}

-(void)setTitle:(NSString *)title
{
    [_txtServiceName setText:title];
}

- (IBAction)didClickDeleteServiceButton:(id)sender
{
    if (_type == TYPE_ORDER)
    {
        NSLog(@"click delete service");
        if (_delegate && [_delegate respondsToSelector:@selector(didClickDeleteServiceAt:)])
        {
            [_delegate didClickDeleteServiceAt:_index];
        }
    }
    else
    {
        NSLog(@"unselect");
    }
}
@end
