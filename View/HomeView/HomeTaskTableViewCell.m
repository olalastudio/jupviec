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

    // shadow
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 6.0;
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 12;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 15;
    frame.origin.y -= 5;
    frame.size.width -= 2*15;
    frame.size.height -= 2*5;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
