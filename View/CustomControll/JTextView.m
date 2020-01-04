//
//  JTextView.m
//  JupViec
//
//  Created by KienVu on 12/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JTextView.h"

@implementation JTextView

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

    self.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.21];
    self.layer.borderColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.51].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 10;
    
    self.textContainerInset = UIEdgeInsetsMake(13, 16, 13, 16);
}

@end
