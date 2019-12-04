//
//  HomeTaskTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomeTaskTableViewCell.h"

@implementation HomeTaskTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    self.layer.cornerRadius = 12.0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.size.width -= 2*5;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
