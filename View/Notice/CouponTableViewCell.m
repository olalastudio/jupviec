//
//  CouponTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // shadow
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = true;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.2;
    self.layer.masksToBounds = false;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 15;
    frame.origin.y -= 5;
    frame.size.width -= 2*15;
    frame.size.height -= 2*5;
    
    [super setFrame:frame];
}

@end
