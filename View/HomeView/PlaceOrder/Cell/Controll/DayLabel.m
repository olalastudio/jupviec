//
//  DayLabel.m
//  JupViec
//
//  Created by KienVu on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DayLabel.h"

@implementation DayLabel
@synthesize selected = _selected;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //code here
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _selected = NO;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_selected) {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    else{
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_selected) {
        _selected = NO;
    }
    else{
        _selected = YES;
    }
    
    [self setNeedsDisplay];
}
@end
