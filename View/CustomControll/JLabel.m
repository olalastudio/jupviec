//
//  JLabel.m
//  JupViec
//
//  Created by KienVu on 12/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JLabel.h"

@implementation JLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // Corner
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = frame.size.width + 8;
    
    [super setFrame:frame];
}

@end
