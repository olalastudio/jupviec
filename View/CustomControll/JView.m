//
//  JView.m
//  JupViec
//
//  Created by Olala on 12/28/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JView.h"

@implementation JView

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

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    
    //coner
    CALayer *innerlayer = [CALayer layer];
    innerlayer.frame = self.bounds;
    innerlayer.masksToBounds = YES;
    innerlayer.cornerRadius = 8;
    innerlayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self.layer insertSublayer:innerlayer atIndex:0];
    
    // shadow
    self.layer.masksToBounds = NO;
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 4.0;
}
@end
