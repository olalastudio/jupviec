//
//  TextDetailPopupView.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "TextDetailPopupView.h"

@implementation TextDetailPopupView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
}

@end
