//
//  JTextField.m
//  JupViec
//
//  Created by KienVu on 1/13/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "JTextField.h"
#import "CommonDefines.h"

@implementation JTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    [super drawRect:rect];

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height - 1, rect.size.width, 1)];
    [path setLineWidth:1];
    [UIColorFromRGB(0xFF7E46) setFill];
     
    [path fill];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.borderStyle = UITextBorderStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect frame = [self frame];
    CGFloat fontsize = self.font.lineHeight;
    
    frame.size.height = fontsize + 7*2;
    
    [self setFrame:frame];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.y -= 7;
    
    return bounds;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.y -= 7;
    
    return bounds;
}

@end
