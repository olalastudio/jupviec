//
//  JNavigationBar.m
//  JupViec
//
//  Created by KienVu on 12/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JNavigationBar.h"

@implementation JNavigationBar

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
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
