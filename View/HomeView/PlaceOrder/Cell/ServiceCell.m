//
//  ServiceCell.m
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (_type == TYPE_POPUP)
    {
        if (selected) {
            [_btDelete setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
            [_btDelete setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
        }
        else{
            [_btDelete setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            [_btDelete setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
        }
    }
}

-(void)setServiceCellType:(ServiceCellType)type
{
    _type = type;
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
    }
    else
    {
        NSLog(@"unselect");
    }
}
@end
